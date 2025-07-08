use starknet::ContractAddress;

#[starknet::interface]
trait IPaymaster<TContractState> {
    // Paymaster validation functions
    fn validate_paymaster_transaction(
        self: @TContractState,
        user_address: ContractAddress,
        call_data: Array<felt252>,
        max_fee: u256,
        signature: Array<felt252>
    ) -> felt252;
    
    fn execute_from_paymaster(
        ref self: TContractState,
        user_address: ContractAddress,
        call_data: Array<felt252>,
        max_fee: u256
    ) -> Array<felt252>;
    
    // Paymaster management functions
    fn get_paymaster_balance(self: @TContractState) -> u256;
    fn deposit_funds(ref self: TContractState, amount: u256);
    fn withdraw_funds(ref self: TContractState, amount: u256, recipient: ContractAddress);
    fn set_authorized_contract(ref self: TContractState, contract_address: ContractAddress, authorized: bool);
    fn is_authorized_contract(self: @TContractState, contract_address: ContractAddress) -> bool;
    fn get_user_usage(self: @TContractState, user_address: ContractAddress) -> u256;
    fn set_user_limit(ref self: TContractState, user_address: ContractAddress, limit: u256);
}

#[starknet::contract]
mod StreetCredPaymaster {
    use super::IPaymaster;
    use starknet::{ContractAddress, get_caller_address, get_block_timestamp, get_contract_address};
    use starknet::storage::{Map, StorageMapReadAccess, StorageMapWriteAccess};
    use core::pedersen::pedersen;
    use core::traits::Into;
    use core::traits::TryInto;
    use core::option::OptionTrait;
    use core::array::ArrayTrait;

    #[storage]
    struct Storage {
        owner: ContractAddress,
        balance: u256,
        authorized_contracts: Map<ContractAddress, bool>,
        user_daily_usage: Map<ContractAddress, u256>,
        user_daily_limit: Map<ContractAddress, u256>,
        user_last_usage_day: Map<ContractAddress, u256>,
        nonce_used: Map<felt252, bool>,
        total_sponsored: u256,
        daily_limit: u256,
        daily_usage: u256,
        last_usage_day: u256,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        TransactionSponsored: TransactionSponsored,
        FundsDeposited: FundsDeposited,
        FundsWithdrawn: FundsWithdrawn,
        ContractAuthorized: ContractAuthorized,
        UserLimitSet: UserLimitSet,
    }

    #[derive(Drop, starknet::Event)]
    struct TransactionSponsored {
        #[key]
        user_address: ContractAddress,
        #[key]
        contract_address: ContractAddress,
        gas_fee: u256,
        timestamp: u64,
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
    struct UserLimitSet {
        #[key]
        user_address: ContractAddress,
        limit: u256,
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress, initial_balance: u256) {
        self.owner.write(owner);
        self.balance.write(initial_balance);
        self.daily_limit.write(1000000000000000000); // 1 ETH per day
        self.last_usage_day.write(get_block_timestamp().into() / 86400); // Current day
    }

    #[abi(embed_v0)]
    impl PaymasterImpl of IPaymaster<ContractState> {
        /// Validate a paymaster transaction
        fn validate_paymaster_transaction(
            self: @ContractState,
            user_address: ContractAddress,
            call_data: Array<felt252>,
            max_fee: u256,
            signature: Array<felt252>
        ) -> felt252 {
            // Check if paymaster has sufficient balance
            let current_balance = self.balance.read();
            assert(current_balance >= max_fee, 'Insufficient paymaster balance');

            // Check daily limits
            let current_day = get_block_timestamp().into() / 86400;
            let last_day = self.last_usage_day.read();
            let daily_usage = if current_day == last_day {
                self.daily_usage.read()
            } else {
                0
            };
            
            let daily_limit = self.daily_limit.read();
            assert(daily_usage + max_fee <= daily_limit, 'Daily limit exceeded');

            // Check user-specific limits
            let user_last_day = self.user_last_usage_day.read(user_address);
            let user_daily_usage = if current_day == user_last_day {
                self.user_daily_usage.read(user_address)
            } else {
                0
            };
            
            let user_limit = self.user_daily_limit.read(user_address);
            if user_limit > 0 {
                assert(user_daily_usage + max_fee <= user_limit, 'User daily limit exceeded');
            }

            // Validate signature (simplified)
            let message_hash = self._create_message_hash(user_address, call_data, max_fee);
            let is_valid = self._verify_signature(message_hash, signature);
            assert(is_valid, 'Invalid paymaster signature');

            // Return success
            1
        }

        /// Execute transaction from paymaster
        fn execute_from_paymaster(
            ref self: ContractState,
            user_address: ContractAddress,
            call_data: Array<felt252>,
            max_fee: u256
        ) -> Array<felt252> {
            // Only authorized contracts can execute
            let caller = get_caller_address();
            assert(self.authorized_contracts.read(caller), 'Contract not authorized');

            // Update balances and usage
            let current_balance = self.balance.read();
            assert(current_balance >= max_fee, 'Insufficient balance');
            self.balance.write(current_balance - max_fee);

            // Update daily usage
            let current_day = get_block_timestamp().into() / 86400;
            let last_day = self.last_usage_day.read();
            
            if current_day != last_day {
                self.daily_usage.write(max_fee);
                self.last_usage_day.write(current_day);
            } else {
                let daily_usage = self.daily_usage.read();
                self.daily_usage.write(daily_usage + max_fee);
            }

            // Update user daily usage
            let user_last_day = self.user_last_usage_day.read(user_address);
            if current_day != user_last_day {
                self.user_daily_usage.write(user_address, max_fee);
                self.user_last_usage_day.write(user_address, current_day);
            } else {
                let user_usage = self.user_daily_usage.read(user_address);
                self.user_daily_usage.write(user_address, user_usage + max_fee);
            }

            // Update total sponsored
            let total = self.total_sponsored.read();
            self.total_sponsored.write(total + max_fee);

            // Emit event
            self.emit(TransactionSponsored {
                user_address,
                contract_address: caller,
                gas_fee: max_fee,
                timestamp: get_block_timestamp(),
            });

            // Return execution result
            let mut result = ArrayTrait::new();
            result.append(1); // Success
            result
        }

        /// Get paymaster balance
        fn get_paymaster_balance(self: @ContractState) -> u256 {
            self.balance.read()
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

        /// Withdraw funds from paymaster
        fn withdraw_funds(ref self: ContractState, amount: u256, recipient: ContractAddress) {
            let caller = get_caller_address();
            let owner = self.owner.read();
            assert(caller == owner, 'Only owner can withdraw');

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

        /// Set authorized contract
        fn set_authorized_contract(ref self: ContractState, contract_address: ContractAddress, authorized: bool) {
            let caller = get_caller_address();
            let owner = self.owner.read();
            assert(caller == owner, 'Only owner can authorize');

            self.authorized_contracts.write(contract_address, authorized);

            self.emit(ContractAuthorized {
                contract_address,
                authorized,
            });
        }

        /// Check if contract is authorized
        fn is_authorized_contract(self: @ContractState, contract_address: ContractAddress) -> bool {
            self.authorized_contracts.read(contract_address)
        }

        /// Get user usage
        fn get_user_usage(self: @ContractState, user_address: ContractAddress) -> u256 {
            let current_day = get_block_timestamp().into() / 86400;
            let user_last_day = self.user_last_usage_day.read(user_address);
            
            if current_day == user_last_day {
                self.user_daily_usage.read(user_address)
            } else {
                0
            }
        }

        /// Set user limit
        fn set_user_limit(ref self: ContractState, user_address: ContractAddress, limit: u256) {
            let caller = get_caller_address();
            let owner = self.owner.read();
            assert(caller == owner, 'Only owner can set limits');

            self.user_daily_limit.write(user_address, limit);

            self.emit(UserLimitSet {
                user_address,
                limit,
            });
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        /// Create message hash for signature verification
        fn _create_message_hash(
            self: @ContractState,
            user_address: ContractAddress,
            call_data: Array<felt252>,
            max_fee: u256
        ) -> felt252 {
            // Create hash of user address, call data, and max fee
            let user_felt: felt252 = user_address.into();
            let fee_felt: felt252 = max_fee.try_into().unwrap();
            
            // Simple hash for now - in production would use proper structured hashing
            pedersen(user_felt, fee_felt)
        }

        /// Verify signature (simplified implementation)
        fn _verify_signature(
            self: @ContractState,
            message_hash: felt252,
            signature: Array<felt252>
        ) -> bool {
            // In production, this would verify the ECDSA signature
            // For now, return true if signature is non-empty
            signature.len() > 0
        }
    }
}