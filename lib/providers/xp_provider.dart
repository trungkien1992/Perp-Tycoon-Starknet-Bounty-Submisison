import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/contract_service.dart';
import '../services/starknet_service.dart';
import 'starknet_provider.dart';
import '../app_mode.dart';

/// Enhanced XP state that includes contract integration
class XPState {
  final int localXP;
  final int contractXP;
  final int level;
  final int xpToNextLevel;
  final int rank;
  final bool isLoading;
  final String? error;
  final List<LeaderboardEntry> leaderboard;
  final List<NFTMetadata> nfts;
  
  XPState({
    this.localXP = 0,
    this.contractXP = 0,
    this.level = 1,
    this.xpToNextLevel = 100,
    this.rank = 0,
    this.isLoading = false,
    this.error,
    this.leaderboard = const [],
    this.nfts = const [],
  });
  
  XPState copyWith({
    int? localXP,
    int? contractXP,
    int? level,
    int? xpToNextLevel,
    int? rank,
    bool? isLoading,
    String? error,
    List<LeaderboardEntry>? leaderboard,
    List<NFTMetadata>? nfts,
  }) {
    return XPState(
      localXP: localXP ?? this.localXP,
      contractXP: contractXP ?? this.contractXP,
      level: level ?? this.level,
      xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
      rank: rank ?? this.rank,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      leaderboard: leaderboard ?? this.leaderboard,
      nfts: nfts ?? this.nfts,
    );
  }
  
  /// Get the effective XP (prioritize contract XP in real mode)
  int get effectiveXP => isMockMode() ? localXP : contractXP;
}

class XPNotifier extends StateNotifier<XPState> {
  final ContractService _contractService;
  final Ref _ref;
  
  XPNotifier(this._contractService, this._ref) : super(XPState()) {
    _initialize();
  }
  
  /// Initialize XP data from contract or local storage
  Future<void> _initialize() async {
    if (isMockMode()) {
      // In mock mode, just use local state
      return;
    }
    
    state = state.copyWith(isLoading: true);
    
    try {
      final starknetState = _ref.read(starknetConnectionProvider);
      if (!starknetState.isConnected || starknetState.accountAddress == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Starknet wallet not connected'
        );
        return;
      }
      
      // Load XP from contract
      await _syncWithContract();
      
    } catch (e) {
      print('❌ Failed to initialize XP from contract: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
  
  /// Gain XP - this is the key function that writes to the contract
  Future<void> gainXP(int amount) async {
    print('🎯 XPNotifier.gainXP called with amount: $amount');
    
    // Update local state immediately for UI responsiveness
    final newLocalXP = state.localXP + amount;
    final newLevel = _calculateLevel(newLocalXP);
    final newXpToNext = _calculateXpToNextLevel(newLocalXP);
    
    state = state.copyWith(
      localXP: newLocalXP,
      level: newLevel,
      xpToNextLevel: newXpToNext,
      isLoading: true,
    );
    
    // Check for level milestone NFT
    if (newLevel % 10 == 0 && newLevel > state.level) {
      await _mintLevelMilestoneNFT(newLevel);
    }
    
    // If in real mode, write to contract
    if (!isMockMode()) {
      await _writeXPToContract(amount);
    }
    
    // Refresh contract data
    await _syncWithContract();
  }
  
  /// Write XP to the Starknet contract
  Future<void> _writeXPToContract(int amount) async {
    try {
      final starknetState = _ref.read(starknetConnectionProvider);
      if (!starknetState.isConnected || starknetState.accountAddress == null) {
        throw Exception('Starknet wallet not connected');
      }
      
      print('🔗 Writing $amount XP to contract for ${starknetState.accountAddress}');
      
      // This is the key contract interaction!
      final txHash = await _contractService.addXPToContract(
        playerAddress: starknetState.accountAddress!,
        xpAmount: amount,
      );
      
      print('✅ XP written to contract successfully: $txHash');
      
      // Update state to reflect successful contract write
      state = state.copyWith(
        error: null,
        isLoading: false,
      );
      
    } catch (e) {
      print('❌ Failed to write XP to contract: $e');
      state = state.copyWith(
        error: 'Failed to write XP to contract: $e',
        isLoading: false,
      );
    }
  }
  
  /// Sync local state with contract data
  Future<void> _syncWithContract() async {
    if (isMockMode()) {
      state = state.copyWith(isLoading: false);
      return;
    }
    
    try {
      final starknetState = _ref.read(starknetConnectionProvider);
      if (!starknetState.isConnected || starknetState.accountAddress == null) {
        return;
      }
      
      // Read data from contracts
      final contractXP = await _contractService.getXPFromContract(starknetState.accountAddress!);
      final rank = await _contractService.getPlayerRankFromContract(starknetState.accountAddress!);
      final leaderboard = await _contractService.getLeaderboardFromContract();
      final nfts = await _contractService.getPlayerNFTs(starknetState.accountAddress!);
      
      final level = _calculateLevel(contractXP);
      final xpToNext = _calculateXpToNextLevel(contractXP);
      
      state = state.copyWith(
        contractXP: contractXP,
        level: level,
        xpToNextLevel: xpToNext,
        rank: rank,
        leaderboard: leaderboard,
        nfts: nfts,
        isLoading: false,
        error: null,
      );
      
      print('✅ Synced with contract: $contractXP XP, Level $level, Rank $rank');
      
    } catch (e) {
      print('❌ Failed to sync with contract: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to sync with contract: $e',
      );
    }
  }
  
  /// Refresh all data from contracts
  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await _syncWithContract();
  }
  
  /// Mint achievement NFT
  Future<void> mintAchievementNFT(int achievementType) async {
    try {
      final starknetState = _ref.read(starknetConnectionProvider);
      if (!starknetState.isConnected || starknetState.accountAddress == null) {
        throw Exception('Starknet wallet not connected');
      }
      
      final txHash = await _contractService.mintAchievementNFT(
        playerAddress: starknetState.accountAddress!,
        achievementType: achievementType,
      );
      
      print('🎨 Achievement NFT minted: $txHash');
      
      // Refresh NFT data
      await _syncWithContract();
      
    } catch (e) {
      print('❌ Failed to mint achievement NFT: $e');
      state = state.copyWith(error: 'Failed to mint achievement NFT: $e');
    }
  }
  
  /// Mint level milestone NFT
  Future<void> _mintLevelMilestoneNFT(int level) async {
    if (level < 10 || level % 10 != 0) return; // Only milestone levels
    
    try {
      final starknetState = _ref.read(starknetConnectionProvider);
      if (!starknetState.isConnected || starknetState.accountAddress == null) {
        return;
      }
      
      final txHash = await _contractService.mintLevelMilestoneNFT(
        playerAddress: starknetState.accountAddress!,
        level: level,
      );
      
      print('🏆 Level milestone NFT minted for level $level: $txHash');
      
    } catch (e) {
      print('❌ Failed to mint level milestone NFT: $e');
    }
  }
  
  /// Reset XP (local only in mock mode)
  void resetXP() {
    if (isMockMode()) {
      state = XPState();
    } else {
      // In real mode, cannot reset contract data
      print('⚠️ Cannot reset XP in real mode - contract data is immutable');
    }
  }
  
  /// Calculate level from XP
  int _calculateLevel(int xp) {
    return (xp / 100).floor() + 1;
  }
  
  /// Calculate XP needed for next level
  int _calculateXpToNextLevel(int xp) {
    final currentLevel = _calculateLevel(xp);
    final xpForNextLevel = currentLevel * 100;
    return xpForNextLevel - xp;
  }
}

/// Provider for contract service
final contractServiceProvider = Provider<ContractService>((ref) {
  final starknetService = ref.read(starknetServiceProvider);
  return ContractService(starknetService);
});

/// Provider for Starknet service
final starknetServiceProvider = Provider<StarknetService>((ref) {
  return StarknetService();
});

/// Main XP provider that integrates with contracts
final xpProvider = StateNotifierProvider<XPNotifier, XPState>((ref) {
  final contractService = ref.read(contractServiceProvider);
  return XPNotifier(contractService, ref);
});

/// Convenience provider for just the XP number (for backwards compatibility)
final xpValueProvider = Provider<int>((ref) {
  return ref.watch(xpProvider).effectiveXP;
});

/// Provider for leaderboard data
final leaderboardProvider = Provider<List<LeaderboardEntry>>((ref) {
  return ref.watch(xpProvider).leaderboard;
});

/// Provider for player NFTs
final playerNFTsProvider = Provider<List<NFTMetadata>>((ref) {
  return ref.watch(xpProvider).nfts;
});