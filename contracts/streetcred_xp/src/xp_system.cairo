use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use starknet::storage::{Map, StorageMapReadAccess, StorageMapWriteAccess};
use core::num::traits::Zero;

#[starknet::interface]
trait IStreetCredXP<TContractState> {
    // XP Management
    fn get_xp(self: @TContractState, player: ContractAddress) -> u256;
    fn add_xp(ref self: TContractState, player: ContractAddress, amount: u256);
    fn get_level(self: @TContractState, player: ContractAddress) -> u256;
    fn get_xp_to_next_level(self: @TContractState, player: ContractAddress) -> u256;
    
    // Leaderboard Functions
    fn get_leaderboard_top_10(self: @TContractState) -> Array<(ContractAddress, u256)>;
    fn get_player_rank(self: @TContractState, player: ContractAddress) -> u256;
    fn get_total_players(self: @TContractState) -> u256;
    
    // Statistics
    fn get_player_stats(self: @TContractState, player: ContractAddress) -> PlayerStats;
    fn get_global_stats(self: @TContractState) -> GlobalStats;
    
    // Admin Functions
    fn set_xp_per_trade(ref self: TContractState, amount: u256);
    fn set_authorized_contract(ref self: TContractState, contract: ContractAddress, authorized: bool);
    fn emergency_pause(ref self: TContractState);
    fn unpause(ref self: TContractState);
}

#[derive(Drop, Serde, starknet::Store)]
struct PlayerStats {
    xp: u256,
    level: u256,
    trades_completed: u256,
    last_activity: u64,
    joined_timestamp: u64,
    total_earnings: u256,
}

#[derive(Drop, Serde, starknet::Store)]
struct GlobalStats {
    total_players: u256,
    total_xp_distributed: u256,
    total_trades: u256,
    highest_level: u256,
}

#[starknet::contract]
mod StreetCredXP {
    use super::{IStreetCredXP, PlayerStats, GlobalStats};
    use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
    use starknet::storage::{Map, StorageMapReadAccess, StorageMapWriteAccess, Vec, VecTrait, MutableVecTrait};
    use core::num::traits::Zero;

    #[storage]
    struct Storage {
        // Player Data
        player_xp: Map<ContractAddress, u256>,
        player_stats: Map<ContractAddress, PlayerStats>,
        player_exists: Map<ContractAddress, bool>,
        
        // Leaderboard (top 100 players for gas efficiency)
        leaderboard: Vec<ContractAddress>,
        player_ranks: Map<ContractAddress, u256>,
        
        // Configuration
        xp_per_trade: u256,
        xp_per_level: u256,
        
        // Access Control
        owner: ContractAddress,
        authorized_contracts: Map<ContractAddress, bool>,
        paused: bool,
        
        // Global Statistics
        global_stats: GlobalStats,
        
        // Events tracking
        last_leaderboard_update: u64,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        XPGained: XPGained,
        LevelUp: LevelUp,
        LeaderboardUpdated: LeaderboardUpdated,
        PlayerRegistered: PlayerRegistered,
        TradeCompleted: TradeCompleted,
    }

    #[derive(Drop, starknet::Event)]
    struct XPGained {
        #[key]
        player: ContractAddress,
        amount: u256,
        new_total: u256,
        source: ByteArray,
    }

    #[derive(Drop, starknet::Event)]
    struct LevelUp {
        #[key]
        player: ContractAddress,
        old_level: u256,
        new_level: u256,
    }

    #[derive(Drop, starknet::Event)]
    struct LeaderboardUpdated {
        #[key]
        player: ContractAddress,
        new_rank: u256,
        xp: u256,
    }

    #[derive(Drop, starknet::Event)]
    struct PlayerRegistered {
        #[key]
        player: ContractAddress,
        timestamp: u64,
    }

    #[derive(Drop, starknet::Event)]
    struct TradeCompleted {
        #[key]
        player: ContractAddress,
        xp_earned: u256,
        trade_type: ByteArray,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        owner: ContractAddress,
        xp_per_trade: u256
    ) {
        self.owner.write(owner);
        self.xp_per_trade.write(xp_per_trade);
        self.xp_per_level.write(100); // 100 XP per level
        self.paused.write(false);
        
        // Initialize global stats
        let initial_stats = GlobalStats {
            total_players: 0,
            total_xp_distributed: 0,
            total_trades: 0,
            highest_level: 1,
        };
        self.global_stats.write(initial_stats);
    }

    #[abi(embed_v0)]
    impl StreetCredXPImpl of IStreetCredXP<ContractState> {
        fn get_xp(self: @ContractState, player: ContractAddress) -> u256 {
            self.player_xp.read(player)
        }

        fn add_xp(ref self: ContractState, player: ContractAddress, amount: u256) {
            self._assert_not_paused();
            self._assert_authorized();
            
            let old_xp = self.player_xp.read(player);
            let old_level = self._calculate_level(old_xp);
            let new_xp = old_xp + amount;
            let new_level = self._calculate_level(new_xp);
            
            // Register player if first time
            if !self.player_exists.read(player) {
                self._register_player(player);
            }
            
            // Update XP
            self.player_xp.write(player, new_xp);
            
            // Update player stats
            let mut stats = self.player_stats.read(player);
            stats.xp = new_xp;
            stats.level = new_level;
            stats.trades_completed += 1;
            stats.last_activity = get_block_timestamp();
            self.player_stats.write(player, stats);
            
            // Update global stats
            let mut global = self.global_stats.read();
            global.total_xp_distributed += amount;
            global.total_trades += 1;
            if new_level > global.highest_level {
                global.highest_level = new_level;
            }
            self.global_stats.write(global);
            
            // Emit events
            self.emit(XPGained { 
                player, 
                amount, 
                new_total: new_xp,
                source: "trade_completion"
            });
            
            self.emit(TradeCompleted {
                player,
                xp_earned: amount,
                trade_type: "perpetual_trade"
            });
            
            // Check for level up
            if new_level > old_level {
                self.emit(LevelUp { player, old_level, new_level });
            }
            
            // Update leaderboard
            self._update_leaderboard(player, new_xp);
        }

        fn get_level(self: @ContractState, player: ContractAddress) -> u256 {
            let xp = self.player_xp.read(player);
            self._calculate_level(xp)
        }

        fn get_xp_to_next_level(self: @ContractState, player: ContractAddress) -> u256 {
            let current_xp = self.player_xp.read(player);
            let current_level = self._calculate_level(current_xp);
            let xp_for_next_level = (current_level + 1) * self.xp_per_level.read();
            
            if current_xp >= xp_for_next_level {
                0
            } else {
                xp_for_next_level - current_xp
            }
        }

        fn get_leaderboard_top_10(self: @ContractState) -> Array<(ContractAddress, u256)> {
            let mut result = ArrayTrait::new();
            let leaderboard_len = self.leaderboard.len();
            let max_items = if leaderboard_len > 10 { 10 } else { leaderboard_len };
            
            let mut i = 0;
            while i < max_items {
                let player = self.leaderboard.at(i).read();
                let xp = self.player_xp.read(player);
                result.append((player, xp));
                i += 1;
            };
            
            result
        }

        fn get_player_rank(self: @ContractState, player: ContractAddress) -> u256 {
            if !self.player_exists.read(player) {
                return 0; // Unranked
            }
            
            let rank = self.player_ranks.read(player);
            if rank == 0 {
                // Player not in top 100, calculate approximate rank
                let player_xp = self.player_xp.read(player);
                self._calculate_approximate_rank(player_xp)
            } else {
                rank
            }
        }

        fn get_total_players(self: @ContractState) -> u256 {
            self.global_stats.read().total_players
        }

        fn get_player_stats(self: @ContractState, player: ContractAddress) -> PlayerStats {
            if !self.player_exists.read(player) {
                // Return empty stats for non-existent players
                PlayerStats {
                    xp: 0,
                    level: 1,
                    trades_completed: 0,
                    last_activity: 0,
                    joined_timestamp: 0,
                    total_earnings: 0,
                }
            } else {
                self.player_stats.read(player)
            }
        }

        fn get_global_stats(self: @ContractState) -> GlobalStats {
            self.global_stats.read()
        }

        fn set_xp_per_trade(ref self: ContractState, amount: u256) {
            self._assert_only_owner();
            self.xp_per_trade.write(amount);
        }

        fn set_authorized_contract(ref self: ContractState, contract: ContractAddress, authorized: bool) {
            self._assert_only_owner();
            self.authorized_contracts.write(contract, authorized);
        }

        fn emergency_pause(ref self: ContractState) {
            self._assert_only_owner();
            self.paused.write(true);
        }

        fn unpause(ref self: ContractState) {
            self._assert_only_owner();
            self.paused.write(false);
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn _calculate_level(self: @ContractState, xp: u256) -> u256 {
            let xp_per_level = self.xp_per_level.read();
            if xp_per_level == 0 { return 1; }
            
            (xp / xp_per_level) + 1
        }

        fn _register_player(ref self: ContractState, player: ContractAddress) {
            self.player_exists.write(player, true);
            
            let timestamp = get_block_timestamp();
            let stats = PlayerStats {
                xp: 0,
                level: 1,
                trades_completed: 0,
                last_activity: timestamp,
                joined_timestamp: timestamp,
                total_earnings: 0,
            };
            self.player_stats.write(player, stats);
            
            // Update global player count
            let mut global = self.global_stats.read();
            global.total_players += 1;
            self.global_stats.write(global);
            
            self.emit(PlayerRegistered { player, timestamp });
        }

        fn _update_leaderboard(ref self: ContractState, player: ContractAddress, new_xp: u256) {
            // Simple leaderboard update - in production, use more efficient sorting
            // For now, just track if player should be in top 100
            let current_rank = self.player_ranks.read(player);
            
            // This is a simplified implementation
            // In production, implement proper sorting algorithm
            if current_rank == 0 && new_xp > 1000 { // Threshold for leaderboard entry
                let new_rank = self._find_insert_position(new_xp);
                self.player_ranks.write(player, new_rank);
                
                self.emit(LeaderboardUpdated { 
                    player, 
                    new_rank, 
                    xp: new_xp 
                });
            }
        }

        fn _find_insert_position(self: @ContractState, xp: u256) -> u256 {
            // Simplified ranking logic
            // In production, implement binary search or efficient sorting
            let leaderboard_size = self.leaderboard.len();
            if leaderboard_size < 100 {
                leaderboard_size + 1
            } else {
                100 // Bottom of leaderboard
            }
        }

        fn _calculate_approximate_rank(self: @ContractState, player_xp: u256) -> u256 {
            // Approximate rank calculation for players not in top 100
            // This is a simplified heuristic
            let total_players = self.global_stats.read().total_players;
            let global_stats = self.global_stats.read();
            
            if total_players == 0 { return 1; }
            
            // Rough estimate based on XP percentile
            if player_xp == 0 { return total_players; }
            
            // Simple heuristic: assume linear distribution
            let avg_xp = global_stats.total_xp_distributed / total_players;
            if player_xp >= avg_xp {
                total_players / 2 // Above average
            } else {
                (total_players * 3) / 4 // Below average
            }
        }

        fn _assert_only_owner(self: @ContractState) {
            let caller = get_caller_address();
            let owner = self.owner.read();
            assert(caller == owner, 'Only owner can call this');
        }

        fn _assert_authorized(self: @ContractState) {
            let caller = get_caller_address();
            let owner = self.owner.read();
            let is_authorized = self.authorized_contracts.read(caller);
            
            assert(caller == owner || is_authorized, 'Unauthorized caller');
        }

        fn _assert_not_paused(self: @ContractState) {
            assert(!self.paused.read(), 'Contract is paused');
        }
    }
}