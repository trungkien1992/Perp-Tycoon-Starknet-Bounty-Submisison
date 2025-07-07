use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use starknet::storage::{Map, StorageMapReadAccess, StorageMapWriteAccess};
use core::num::traits::Zero;

#[starknet::interface]
trait IERC165<TContractState> {
    fn supports_interface(self: @TContractState, interface_id: felt252) -> bool;
}

#[starknet::interface]
trait IERC721<TContractState> {
    fn balance_of(self: @TContractState, owner: ContractAddress) -> u256;
    fn owner_of(self: @TContractState, token_id: u256) -> ContractAddress;
    fn safe_transfer_from(
        ref self: TContractState,
        from: ContractAddress,
        to: ContractAddress,
        token_id: u256,
        data: Span<felt252>
    );
    fn transfer_from(ref self: TContractState, from: ContractAddress, to: ContractAddress, token_id: u256);
    fn approve(ref self: TContractState, to: ContractAddress, token_id: u256);
    fn set_approval_for_all(ref self: TContractState, operator: ContractAddress, approved: bool);
    fn get_approved(self: @TContractState, token_id: u256) -> ContractAddress;
    fn is_approved_for_all(self: @TContractState, owner: ContractAddress, operator: ContractAddress) -> bool;
}

#[starknet::interface]
trait IERC721Metadata<TContractState> {
    fn name(self: @TContractState) -> ByteArray;
    fn symbol(self: @TContractState) -> ByteArray;
    fn token_uri(self: @TContractState, token_id: u256) -> ByteArray;
}

#[starknet::interface]
trait IStreetArtNFT<TContractState> {
    // Minting Functions
    fn mint_achievement_nft(ref self: TContractState, to: ContractAddress, achievement_type: u8) -> u256;
    fn mint_level_milestone_nft(ref self: TContractState, to: ContractAddress, level: u256) -> u256;
    fn mint_trade_streak_nft(ref self: TContractState, to: ContractAddress, streak_days: u256) -> u256;
    fn mint_custom_art_nft(ref self: TContractState, to: ContractAddress, art_id: u256, metadata_uri: ByteArray) -> u256;
    
    // Utility Functions
    fn total_supply(self: @TContractState) -> u256;
    fn max_supply(self: @TContractState) -> u256;
    fn set_max_supply(ref self: TContractState, new_max_supply: u256);
    fn get_nft_metadata(self: @TContractState, token_id: u256) -> NFTMetadata;
    fn get_nfts_by_owner(self: @TContractState, owner: ContractAddress) -> Array<u256>;
    fn get_achievement_count(self: @TContractState, owner: ContractAddress, achievement_type: u8) -> u256;
    
    // Admin Functions
    fn set_base_uri(ref self: TContractState, base_uri: ByteArray);
    fn set_authorized_minter(ref self: TContractState, minter: ContractAddress, authorized: bool);
    fn pause_minting(ref self: TContractState);
    fn unpause_minting(ref self: TContractState);
    fn owner(self: @TContractState) -> ContractAddress;
    fn transfer_ownership(ref self: TContractState, new_owner: ContractAddress);
}

#[derive(Drop, Serde, starknet::Store)]
struct NFTMetadata {
    nft_type: u8,        // 1: Achievement, 2: Level Milestone, 3: Streak, 4: Custom Art
    value: u256,         // Level, streak days, or achievement tier
    minted_at: u64,      // Timestamp
    special_attributes: ByteArray, // JSON metadata for special properties
}

// Achievement Types
const ACHIEVEMENT_FIRST_TRADE: u8 = 1;
const ACHIEVEMENT_PROFIT_MASTER: u8 = 2;
const ACHIEVEMENT_STREAK_WARRIOR: u8 = 3;
const ACHIEVEMENT_VOLUME_KING: u8 = 4;
const ACHIEVEMENT_DIAMOND_HANDS: u8 = 5;

#[starknet::contract]
mod StreetArtNFT {
    use super::{IERC165, IERC721, IERC721Metadata, IStreetArtNFT, NFTMetadata};
    use super::{ACHIEVEMENT_FIRST_TRADE, ACHIEVEMENT_PROFIT_MASTER, ACHIEVEMENT_STREAK_WARRIOR, ACHIEVEMENT_VOLUME_KING, ACHIEVEMENT_DIAMOND_HANDS};
    use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
    use starknet::storage::{Map, StorageMapReadAccess, StorageMapWriteAccess, Vec, VecTrait, MutableVecTrait};
    use core::num::traits::Zero;

    #[storage]
    struct Storage {
        // ERC721 Standard Storage
        name: ByteArray,
        symbol: ByteArray,
        owners: Map<u256, ContractAddress>,
        balances: Map<ContractAddress, u256>,
        token_approvals: Map<u256, ContractAddress>,
        operator_approvals: Map<(ContractAddress, ContractAddress), bool>,
        
        // Metadata Storage
        token_uris: Map<u256, ByteArray>,
        base_uri: ByteArray,
        nft_metadata: Map<u256, NFTMetadata>,
        
        // Supply Management
        total_supply: u256,
        max_supply: u256,
        current_token_id: u256,
        
        // Access Control
        owner: ContractAddress,
        authorized_minters: Map<ContractAddress, bool>,
        minting_paused: bool,
        
        // Achievement Tracking
        owner_tokens: Map<ContractAddress, Vec<u256>>,
        achievement_counts: Map<(ContractAddress, u8), u256>,
        
        // Street Art Specific
        custom_art_registry: Map<u256, bool>, // Track which art IDs are used
        milestone_levels: Map<u256, bool>,     // Track which levels have milestone NFTs
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Transfer: Transfer,
        Approval: Approval,
        ApprovalForAll: ApprovalForAll,
        StreetArtMinted: StreetArtMinted,
        AchievementUnlocked: AchievementUnlocked,
        MilestoneMinted: MilestoneMinted,
        OwnershipTransferred: OwnershipTransferred,
    }

    #[derive(Drop, starknet::Event)]
    struct Transfer {
        #[key]
        from: ContractAddress,
        #[key]
        to: ContractAddress,
        #[key]
        token_id: u256
    }

    #[derive(Drop, starknet::Event)]
    struct Approval {
        #[key]
        owner: ContractAddress,
        #[key]
        approved: ContractAddress,
        #[key]
        token_id: u256
    }

    #[derive(Drop, starknet::Event)]
    struct ApprovalForAll {
        #[key]
        owner: ContractAddress,
        #[key]
        operator: ContractAddress,
        approved: bool
    }

    #[derive(Drop, starknet::Event)]
    struct StreetArtMinted {
        #[key]
        token_id: u256,
        #[key]
        to: ContractAddress,
        nft_type: u8,
        value: u256,
        timestamp: u64,
    }

    #[derive(Drop, starknet::Event)]
    struct AchievementUnlocked {
        #[key]
        player: ContractAddress,
        #[key]
        achievement_type: u8,
        token_id: u256,
        description: ByteArray,
    }

    #[derive(Drop, starknet::Event)]
    struct MilestoneMinted {
        #[key]
        player: ContractAddress,
        #[key]
        level: u256,
        token_id: u256,
    }

    #[derive(Drop, starknet::Event)]
    struct OwnershipTransferred {
        #[key]
        previous_owner: ContractAddress,
        #[key]
        new_owner: ContractAddress,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        name: ByteArray,
        symbol: ByteArray,
        max_supply: u256,
        base_uri: ByteArray,
        owner: ContractAddress
    ) {
        self.name.write(name);
        self.symbol.write(symbol);
        self.max_supply.write(max_supply);
        self.base_uri.write(base_uri);
        self.owner.write(owner);
        self.total_supply.write(0);
        self.current_token_id.write(1);
        self.minting_paused.write(false);
    }

    #[abi(embed_v0)]
    impl ERC165Impl of IERC165<ContractState> {
        fn supports_interface(self: @ContractState, interface_id: felt252) -> bool {
            interface_id == 0x01ffc9a7 || // ERC165
            interface_id == 0x80ac58cd || // ERC721
            interface_id == 0x5b5e139f    // ERC721Metadata
        }
    }

    #[abi(embed_v0)]
    impl ERC721Impl of IERC721<ContractState> {
        fn balance_of(self: @ContractState, owner: ContractAddress) -> u256 {
            assert(!owner.is_zero(), 'ERC721: invalid owner');
            self.balances.read(owner)
        }

        fn owner_of(self: @ContractState, token_id: u256) -> ContractAddress {
            let owner = self.owners.read(token_id);
            assert(!owner.is_zero(), 'ERC721: invalid token ID');
            owner
        }

        fn safe_transfer_from(
            ref self: ContractState,
            from: ContractAddress,
            to: ContractAddress,
            token_id: u256,
            data: Span<felt252>
        ) {
            self.transfer_from(from, to, token_id);
        }

        fn transfer_from(ref self: ContractState, from: ContractAddress, to: ContractAddress, token_id: u256) {
            assert(self._is_approved_or_owner(get_caller_address(), token_id), 'ERC721: unauthorized');
            self._transfer(from, to, token_id);
        }

        fn approve(ref self: ContractState, to: ContractAddress, token_id: u256) {
            let owner = self.owner_of(token_id);
            let caller = get_caller_address();
            assert(caller == owner || self.is_approved_for_all(owner, caller), 'ERC721: unauthorized');
            
            self.token_approvals.write(token_id, to);
            self.emit(Approval { owner, approved: to, token_id });
        }

        fn set_approval_for_all(ref self: ContractState, operator: ContractAddress, approved: bool) {
            let caller = get_caller_address();
            assert(caller != operator, 'ERC721: approve to caller');
            
            self.operator_approvals.write((caller, operator), approved);
            self.emit(ApprovalForAll { owner: caller, operator, approved });
        }

        fn get_approved(self: @ContractState, token_id: u256) -> ContractAddress {
            assert(self._exists(token_id), 'ERC721: invalid token ID');
            self.token_approvals.read(token_id)
        }

        fn is_approved_for_all(self: @ContractState, owner: ContractAddress, operator: ContractAddress) -> bool {
            self.operator_approvals.read((owner, operator))
        }
    }

    #[abi(embed_v0)]
    impl ERC721MetadataImpl of IERC721Metadata<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            self.name.read()
        }

        fn symbol(self: @ContractState) -> ByteArray {
            self.symbol.read()
        }

        fn token_uri(self: @ContractState, token_id: u256) -> ByteArray {
            assert(self._exists(token_id), 'ERC721: invalid token ID');
            
            let custom_uri = self.token_uris.read(token_id);
            if custom_uri.len() > 0 {
                return custom_uri;
            }
            
            // Generate dynamic URI based on NFT type and metadata
            let metadata = self.nft_metadata.read(token_id);
            self._generate_token_uri(token_id, metadata)
        }
    }

    #[abi(embed_v0)]
    impl StreetArtNFTImpl of IStreetArtNFT<ContractState> {
        fn mint_achievement_nft(ref self: ContractState, to: ContractAddress, achievement_type: u8) -> u256 {
            self._assert_authorized_minter();
            self._assert_minting_not_paused();
            self._assert_valid_achievement_type(achievement_type);
            
            let token_id = self._mint_base(to, 1, achievement_type); // Type 1: Achievement
            
            // Update achievement count
            let current_count = self.achievement_counts.read((to, achievement_type));
            self.achievement_counts.write((to, achievement_type), current_count + 1);
            
            let description = self._get_achievement_description(achievement_type);
            
            self.emit(AchievementUnlocked { 
                player: to, 
                achievement_type, 
                token_id,
                description
            });
            
            token_id
        }

        fn mint_level_milestone_nft(ref self: ContractState, to: ContractAddress, level: u256) -> u256 {
            self._assert_authorized_minter();
            self._assert_minting_not_paused();
            assert(level >= 10, 'Level must be >= 10'); // Only milestone levels
            assert(level % 10 == 0, 'Must be milestone level'); // Every 10 levels
            assert(!self.milestone_levels.read(level), 'Milestone already claimed');
            
            let token_id = self._mint_base(to, 2, level); // Type 2: Level Milestone
            self.milestone_levels.write(level, true);
            
            self.emit(MilestoneMinted { 
                player: to, 
                level, 
                token_id 
            });
            
            token_id
        }

        fn mint_trade_streak_nft(ref self: ContractState, to: ContractAddress, streak_days: u256) -> u256 {
            self._assert_authorized_minter();
            self._assert_minting_not_paused();
            assert(streak_days >= 7, 'Streak must be >= 7 days');
            
            let token_id = self._mint_base(to, 3, streak_days); // Type 3: Streak
            
            token_id
        }

        fn mint_custom_art_nft(ref self: ContractState, to: ContractAddress, art_id: u256, metadata_uri: ByteArray) -> u256 {
            self._assert_only_owner();
            self._assert_minting_not_paused();
            assert(!self.custom_art_registry.read(art_id), 'Art ID already used');
            
            let token_id = self._mint_base(to, 4, art_id); // Type 4: Custom Art
            self.custom_art_registry.write(art_id, true);
            self.token_uris.write(token_id, metadata_uri);
            
            token_id
        }

        fn total_supply(self: @ContractState) -> u256 {
            self.total_supply.read()
        }

        fn max_supply(self: @ContractState) -> u256 {
            self.max_supply.read()
        }

        fn set_max_supply(ref self: ContractState, new_max_supply: u256) {
            self._assert_only_owner();
            let current_supply = self.total_supply.read();
            assert(new_max_supply >= current_supply, 'Max supply too low');
            self.max_supply.write(new_max_supply);
        }

        fn get_nft_metadata(self: @ContractState, token_id: u256) -> NFTMetadata {
            assert(self._exists(token_id), 'ERC721: invalid token ID');
            self.nft_metadata.read(token_id)
        }

        fn get_nfts_by_owner(self: @ContractState, owner: ContractAddress) -> Array<u256> {
            let mut result = ArrayTrait::new();
            let balance = self.balances.read(owner);
            
            // Simple implementation - iterate through all tokens
            // In production, maintain an index for efficiency
            let total = self.total_supply.read();
            let mut i = 1;
            let mut found = 0;
            
            while i <= total && found < balance {
                if self.owners.read(i) == owner {
                    result.append(i);
                    found += 1;
                }
                i += 1;
            };
            
            result
        }

        fn get_achievement_count(self: @ContractState, owner: ContractAddress, achievement_type: u8) -> u256 {
            self.achievement_counts.read((owner, achievement_type))
        }

        fn set_base_uri(ref self: ContractState, base_uri: ByteArray) {
            self._assert_only_owner();
            self.base_uri.write(base_uri);
        }

        fn set_authorized_minter(ref self: ContractState, minter: ContractAddress, authorized: bool) {
            self._assert_only_owner();
            self.authorized_minters.write(minter, authorized);
        }

        fn pause_minting(ref self: ContractState) {
            self._assert_only_owner();
            self.minting_paused.write(true);
        }

        fn unpause_minting(ref self: ContractState) {
            self._assert_only_owner();
            self.minting_paused.write(false);
        }

        fn owner(self: @ContractState) -> ContractAddress {
            self.owner.read()
        }

        fn transfer_ownership(ref self: ContractState, new_owner: ContractAddress) {
            self._assert_only_owner();
            assert(!new_owner.is_zero(), 'New owner is zero address');
            
            let previous_owner = self.owner.read();
            self.owner.write(new_owner);
            
            self.emit(OwnershipTransferred { previous_owner, new_owner });
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn _mint_base(ref self: ContractState, to: ContractAddress, nft_type: u8, value: u256) -> u256 {
            assert(!to.is_zero(), 'ERC721: mint to zero address');
            self._assert_max_supply_not_exceeded();
            
            let token_id = self.current_token_id.read();
            
            // Set ownership
            self.owners.write(token_id, to);
            let balance = self.balances.read(to);
            self.balances.write(to, balance + 1);
            
            // Update supply
            let total = self.total_supply.read();
            self.total_supply.write(total + 1);
            self.current_token_id.write(token_id + 1);
            
            // Set metadata
            let metadata = NFTMetadata {
                nft_type,
                value,
                minted_at: get_block_timestamp(),
                special_attributes: "",
            };
            self.nft_metadata.write(token_id, metadata);
            
            // Emit events
            self.emit(Transfer { from: Zero::zero(), to, token_id });
            self.emit(StreetArtMinted { 
                token_id, 
                to, 
                nft_type, 
                value, 
                timestamp: get_block_timestamp() 
            });
            
            token_id
        }

        fn _exists(self: @ContractState, token_id: u256) -> bool {
            !self.owners.read(token_id).is_zero()
        }

        fn _is_approved_or_owner(self: @ContractState, spender: ContractAddress, token_id: u256) -> bool {
            assert(self._exists(token_id), 'ERC721: invalid token ID');
            let owner = self.owners.read(token_id);
            spender == owner || self.get_approved(token_id) == spender || self.is_approved_for_all(owner, spender)
        }

        fn _transfer(ref self: ContractState, from: ContractAddress, to: ContractAddress, token_id: u256) {
            assert(from == self.owner_of(token_id), 'ERC721: invalid from');
            assert(!to.is_zero(), 'ERC721: invalid to');

            // Clear approvals
            self.token_approvals.write(token_id, Zero::zero());

            // Update balances
            let from_balance = self.balances.read(from);
            self.balances.write(from, from_balance - 1);
            let to_balance = self.balances.read(to);
            self.balances.write(to, to_balance + 1);

            // Update ownership
            self.owners.write(token_id, to);

            self.emit(Transfer { from, to, token_id });
        }

        fn _generate_token_uri(self: @ContractState, token_id: u256, metadata: NFTMetadata) -> ByteArray {
            let base = self.base_uri.read();
            // In production, concatenate base URI with token-specific path
            // For now, return base URI
            base
        }

        fn _get_achievement_description(self: @ContractState, achievement_type: u8) -> ByteArray {
            if achievement_type == ACHIEVEMENT_FIRST_TRADE {
                "First Trade Completed - Welcome to StreetCred!"
            } else if achievement_type == ACHIEVEMENT_PROFIT_MASTER {
                "Profit Master - Consistent Trading Success"
            } else if achievement_type == ACHIEVEMENT_STREAK_WARRIOR {
                "Streak Warrior - Multiple Days of Trading"
            } else if achievement_type == ACHIEVEMENT_VOLUME_KING {
                "Volume King - High Trading Volume Achieved"
            } else if achievement_type == ACHIEVEMENT_DIAMOND_HANDS {
                "Diamond Hands - Long-term Position Holder"
            } else {
                "Unknown Achievement"
            }
        }

        fn _assert_only_owner(self: @ContractState) {
            let caller = get_caller_address();
            let owner = self.owner.read();
            assert(caller == owner, 'Ownable: caller is not owner');
        }

        fn _assert_authorized_minter(self: @ContractState) {
            let caller = get_caller_address();
            let owner = self.owner.read();
            let is_authorized = self.authorized_minters.read(caller);
            assert(caller == owner || is_authorized, 'Unauthorized minter');
        }

        fn _assert_minting_not_paused(self: @ContractState) {
            assert(!self.minting_paused.read(), 'Minting is paused');
        }

        fn _assert_max_supply_not_exceeded(self: @ContractState) {
            let current_supply = self.total_supply.read();
            let max_supply = self.max_supply.read();
            assert(current_supply < max_supply, 'Max supply exceeded');
        }

        fn _assert_valid_achievement_type(self: @ContractState, achievement_type: u8) {
            assert(
                achievement_type == ACHIEVEMENT_FIRST_TRADE ||
                achievement_type == ACHIEVEMENT_PROFIT_MASTER ||
                achievement_type == ACHIEVEMENT_STREAK_WARRIOR ||
                achievement_type == ACHIEVEMENT_VOLUME_KING ||
                achievement_type == ACHIEVEMENT_DIAMOND_HANDS,
                'Invalid achievement type'
            );
        }
    }
}