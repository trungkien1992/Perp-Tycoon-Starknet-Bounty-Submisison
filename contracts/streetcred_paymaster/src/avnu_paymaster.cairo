use starknet::ContractAddress;

#[starknet::interface]
trait IAVNUPaymaster<TContractState> {
    // AVNU-compatible paymaster validation functions
    fn validate_and_pay_for_transaction(
        ref self: TContractState,
        account: ContractAddress,
        tx_hash: felt252,
        suggested_max_fee: u256
    ) -> bool;
    
    fn can_sponsor_transaction(
        self: @TContractState,
        account: ContractAddress,
        amount: u256
    ) -> bool;
    
    // Enhanced management functions
    fn get_paymaster_balance(self: @TContractState) -> u256;
    fn get_spending_limit(self: @TContractState, account: ContractAddress) -> u256;
    fn get_daily_spent(self: @TContractState, account: ContractAddress) -> u256;
    fn set_spending_limit(ref self: TContractState, account: ContractAddress, daily_limit: u256);
    
    // Fund management
    fn deposit_funds(ref self: TContractState, amount: u256);
    fn withdraw_funds(ref self: TContractState, amount: u256, recipient: ContractAddress);
    
    // Authorization
    fn set_authorized_contract(ref self: TContractState, contract_address: ContractAddress, authorized: bool);
    fn is_authorized_contract(self: @TContractState, contract_address: ContractAddress) -> bool;
    
    // Emergency controls
    fn pause(ref self: TContractState);
    fn unpause(ref self: TContractState);
    fn is_paused(self: @TContractState) -> bool;
    
    // Analytics
    fn get_total_sponsored(self: @TContractState) -> u256;
    fn get_transactions_count(self: @TContractState) -> u256;
    
    // Owner management
    fn get_owner(self: @TContractState) -> ContractAddress;
    fn transfer_ownership(ref self: TContractState, new_owner: ContractAddress);
}

#[starknet::contract]
mod StreetCredAVNUPaymaster {
    use super::IAVNUPaymaster;
    use starknet::{ContractAddress, get_caller_address, get_block_timestamp, get_contract_address};
    use starknet::storage::{Map, StorageMapReadAccess, StorageMapWriteAccess};

    #[storage]
    struct Storage {
        // Basic ownership and controls
        owner: ContractAddress,
        paused: bool,
        
        // Paymaster configuration
        balance: u256,
        fee_rate: u256, // Basis points (100 = 1%)
        
        // Spending limits per account
        spending_limits: Map<ContractAddress, u256>,
        daily_spent: Map<(ContractAddress, u64), u256>, // (account, day) -> spent
        
        // Global limits
        global_daily_limit: u256,
        global_daily_spent: Map<u64, u256>, // day -> spent
        
        // Authorization
        authorized_contracts: Map<ContractAddress, bool>,
        
        // Analytics
        total_sponsored: u256,
        transactions_count: u256,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        TransactionSponsored: TransactionSponsored,
        SpendingLimitUpdated: SpendingLimitUpdated,
        FundsDeposited: FundsDeposited,
        FundsWithdrawn: FundsWithdrawn,
        ContractAuthorized: ContractAuthorized,
        OwnershipTransferred: OwnershipTransferred,
        Paused: Paused,
        Unpaused: Unpaused,
    }

    #[derive(Drop, starknet::Event)]
    struct TransactionSponsored {
        #[key]
        account: ContractAddress,
        #[key]
        tx_hash: felt252,
        fee_paid: u256,
        timestamp: u64,
    }

    #[derive(Drop, starknet::Event)]
    struct SpendingLimitUpdated {
        #[key]
        account: ContractAddress,
        daily_limit: u256,
    }

    #[derive(Drop, starknet::Event)]
    struct FundsDeposited {
        #[key]
        depositor: ContractAddress,
        amount: u256,
        new_balance: u256,
    }

    #[derive(Drop, starknet::Event)]
    struct FundsWithdrawn {
        #[key]
        recipient: ContractAddress,
        amount: u256,
        new_balance: u256,
    }

    #[derive(Drop, starknet::Event)]
    struct ContractAuthorized {
        #[key]
        contract_address: ContractAddress,
        authorized: bool,
    }

    #[derive(Drop, starknet::Event)]
    struct OwnershipTransferred {
        #[key]
        previous_owner: ContractAddress,
        #[key]
        new_owner: ContractAddress,
    }

    #[derive(Drop, starknet::Event)]
    struct Paused {
        #[key]
        timestamp: u64,
    }

    #[derive(Drop, starknet::Event)]
    struct Unpaused {
        #[key]
        timestamp: u64,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        owner: ContractAddress,
        initial_balance: u256
    ) {
        self.owner.write(owner);
        self.paused.write(false);
        self.balance.write(initial_balance);
        self.fee_rate.write(100); // 1% default fee
        self.global_daily_limit.write(10000000000000000000); // 10 ETH per day
    }

    #[abi(embed_v0)]
    impl AVNUPaymasterImpl of IAVNUPaymaster<ContractState> {
        /// AVNU-compatible transaction validation and payment
        fn validate_and_pay_for_transaction(
            ref self: ContractState,
            account: ContractAddress,
            tx_hash: felt252,
            suggested_max_fee: u256
        ) -> bool {
            // Check if paused
            assert(!self.paused.read(), 'Paymaster is paused');
            
            // Check if transaction can be sponsored
            assert(self.can_sponsor_transaction(account, suggested_max_fee), 'Cannot sponsor transaction');
            
            // Calculate actual fee
            let actual_fee = self._calculate_fee(suggested_max_fee);
            
            // Check paymaster balance
            let current_balance = self.balance.read();
            assert(current_balance >= actual_fee, 'Insufficient paymaster balance');
            
            // Update balances and limits
            self.balance.write(current_balance - actual_fee);
            
            // Update daily spending tracking
            let today = get_block_timestamp() / 86400;
            
            // Update account daily spending
            let daily_key = (account, today);
            let account_spent_today = self.daily_spent.read(daily_key);
            self.daily_spent.write(daily_key, account_spent_today + actual_fee);
            
            // Update global daily spending
            let global_spent_today = self.global_daily_spent.read(today);
            self.global_daily_spent.write(today, global_spent_today + actual_fee);
            
            // Update analytics
            self.total_sponsored.write(self.total_sponsored.read() + actual_fee);
            self.transactions_count.write(self.transactions_count.read() + 1);
            
            // Emit event
            self.emit(TransactionSponsored {
                account,
                tx_hash,
                fee_paid: actual_fee,
                timestamp: get_block_timestamp(),
            });
            
            true
        }
        
        /// Check if transaction can be sponsored
        fn can_sponsor_transaction(
            self: @ContractState,
            account: ContractAddress,
            amount: u256
        ) -> bool {
            // Check if paused
            if self.paused.read() {
                return false;
            }
            
            // Check paymaster balance
            let current_balance = self.balance.read();
            let actual_fee = self._calculate_fee(amount);
            if current_balance < actual_fee {
                return false;
            }
            
            let today = get_block_timestamp() / 86400;
            
            // Check account daily limit
            let account_limit = self.spending_limits.read(account);
            if account_limit > 0 {
                let daily_key = (account, today);
                let account_spent_today = self.daily_spent.read(daily_key);
                if account_spent_today + actual_fee > account_limit {
                    return false;
                }
            }
            
            // Check global daily limit
            let global_limit = self.global_daily_limit.read();
            let global_spent_today = self.global_daily_spent.read(today);
            if global_spent_today + actual_fee > global_limit {
                return false;
            }
            
            true
        }
        
        /// Get paymaster balance
        fn get_paymaster_balance(self: @ContractState) -> u256 {
            self.balance.read()
        }
        
        /// Get account spending limit
        fn get_spending_limit(self: @ContractState, account: ContractAddress) -> u256 {
            self.spending_limits.read(account)
        }
        
        /// Get account daily spent amount
        fn get_daily_spent(self: @ContractState, account: ContractAddress) -> u256 {
            let today = get_block_timestamp() / 86400;
            let daily_key = (account, today);
            self.daily_spent.read(daily_key)
        }
        
        /// Set account spending limit (owner only)
        fn set_spending_limit(ref self: ContractState, account: ContractAddress, daily_limit: u256) {
            assert(get_caller_address() == self.owner.read(), 'Only owner can set limits');
            self.spending_limits.write(account, daily_limit);
            
            self.emit(SpendingLimitUpdated { account, daily_limit });
        }
        
        /// Deposit funds to paymaster
        fn deposit_funds(ref self: ContractState, amount: u256) {
            let caller = get_caller_address();
            
            let current_balance = self.balance.read();
            let new_balance = current_balance + amount;
            self.balance.write(new_balance);
            
            self.emit(FundsDeposited {
                depositor: caller,
                amount,
                new_balance,
            });
        }
        
        /// Withdraw funds from paymaster (owner only)
        fn withdraw_funds(ref self: ContractState, amount: u256, recipient: ContractAddress) {
            assert(get_caller_address() == self.owner.read(), 'Only owner can withdraw');
            
            let current_balance = self.balance.read();
            assert(current_balance >= amount, 'Insufficient balance');
            
            let new_balance = current_balance - amount;
            self.balance.write(new_balance);
            
            self.emit(FundsWithdrawn {
                recipient,
                amount,
                new_balance,
            });
        }
        
        /// Set authorized contract (owner only)
        fn set_authorized_contract(ref self: ContractState, contract_address: ContractAddress, authorized: bool) {
            assert(get_caller_address() == self.owner.read(), 'Only owner can authorize');
            self.authorized_contracts.write(contract_address, authorized);
            
            self.emit(ContractAuthorized { contract_address, authorized });
        }
        
        /// Check if contract is authorized
        fn is_authorized_contract(self: @ContractState, contract_address: ContractAddress) -> bool {
            self.authorized_contracts.read(contract_address)
        }
        
        /// Pause paymaster (owner only)
        fn pause(ref self: ContractState) {
            assert(get_caller_address() == self.owner.read(), 'Only owner can pause');
            self.paused.write(true);
            self.emit(Paused { timestamp: get_block_timestamp() });
        }
        
        /// Unpause paymaster (owner only)
        fn unpause(ref self: ContractState) {
            assert(get_caller_address() == self.owner.read(), 'Only owner can unpause');
            self.paused.write(false);
            self.emit(Unpaused { timestamp: get_block_timestamp() });
        }
        
        /// Check if paymaster is paused
        fn is_paused(self: @ContractState) -> bool {
            self.paused.read()
        }
        
        /// Get total amount sponsored
        fn get_total_sponsored(self: @ContractState) -> u256 {
            self.total_sponsored.read()
        }
        
        /// Get total transaction count
        fn get_transactions_count(self: @ContractState) -> u256 {
            self.transactions_count.read()
        }
        
        /// Get current owner
        fn get_owner(self: @ContractState) -> ContractAddress {
            self.owner.read()
        }
        
        /// Transfer ownership (owner only)
        fn transfer_ownership(ref self: ContractState, new_owner: ContractAddress) {
            let caller = get_caller_address();
            let current_owner = self.owner.read();
            assert(caller == current_owner, 'Only owner can transfer');
            
            self.owner.write(new_owner);
            
            self.emit(OwnershipTransferred {
                previous_owner: current_owner,
                new_owner,
            });
        }
    }
    
    #[generate_trait]
    impl InternalImpl of InternalTrait {
        /// Calculate actual fee to charge (applies fee rate)
        fn _calculate_fee(self: @ContractState, suggested_fee: u256) -> u256 {
            let fee_rate = self.fee_rate.read();
            suggested_fee * fee_rate / 10000 // Convert basis points to percentage
        }
    }
}