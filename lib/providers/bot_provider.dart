/// Trading bot provider for Perp Tycoon casino game
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:math' as math;
import '../models/game_models.dart';
import 'game_state_provider.dart';

/// Provider for trading bot management
final botProvider = StateNotifierProvider<BotNotifier, List<TradingBot>>((ref) {
  return BotNotifier(ref);
});

/// Provider for bot automation timer
final botTimerProvider = StateProvider<Timer?>((ref) => null);

/// Provider for bot earnings per second
final botEarningsProvider = StateProvider<double>((ref) {
  final gameState = ref.watch(gameStateProvider);
  return gameState.totalEarningsPerSecond;
});

/// Bot notifier that manages trading bots
class BotNotifier extends StateNotifier<List<TradingBot>> {
  final Ref _ref;
  Timer? _botTimer;
  
  BotNotifier(this._ref) : super([]) {
    _loadBotsFromGameState();
    _startBotAutomation();
  }

  /// Load bots from game state
  void _loadBotsFromGameState() {
    final gameState = _ref.read(gameStateProvider);
    state = gameState.ownedBots;
  }

  /// Start bot automation timer
  void _startBotAutomation() {
    _botTimer?.cancel();
    _botTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _processBotEarnings();
    });
  }

  /// Process bot earnings every second
  void _processBotEarnings() {
    if (state.isEmpty) return;
    
    double totalEarnings = 0.0;
    
    for (final bot in state) {
      if (bot.isActive) {
        totalEarnings += bot.earningsPerSecond;
      }
    }
    
    if (totalEarnings > 0) {
      _ref.read(gameStateProvider.notifier).addCash(totalEarnings);
    }
  }

  /// Hire a new bot
  bool hireBot(BotType botType) {
    final gameStateNotifier = _ref.read(gameStateProvider.notifier);
    final cost = botType.baseCost;
    
    if (gameStateNotifier.canAfford(cost)) {
      if (gameStateNotifier.spendCash(cost)) {
        final newBot = TradingBot(
          id: '${botType.name}_${DateTime.now().millisecondsSinceEpoch}',
          type: botType,
          name: botType.displayName,
          market: botType.market,
          baseProfitPerHour: botType.baseProfitPerHour,
          speed: 1.0, // 1 trade per hour base
          level: 1,
          hiredAt: DateTime.now(),
          isActive: true,
        );
        
        state = [...state, newBot];
        _updateGameState();
        return true;
      }
    }
    return false;
  }

  /// Upgrade a bot
  bool upgradeBot(String botId) {
    final gameStateNotifier = _ref.read(gameStateProvider.notifier);
    final botIndex = state.indexWhere((bot) => bot.id == botId);
    
    if (botIndex >= 0) {
      final bot = state[botIndex];
      final upgradeCost = bot.upgradeCost;
      
      if (gameStateNotifier.canAfford(upgradeCost)) {
        if (gameStateNotifier.spendCash(upgradeCost)) {
          final upgradedBot = bot.copyWith(level: bot.level + 1);
          final updatedBots = [...state];
          updatedBots[botIndex] = upgradedBot;
          state = updatedBots;
          _updateGameState();
          return true;
        }
      }
    }
    return false;
  }

  /// Toggle bot active state
  void toggleBotActive(String botId) {
    final botIndex = state.indexWhere((bot) => bot.id == botId);
    if (botIndex >= 0) {
      final bot = state[botIndex];
      final toggledBot = bot.copyWith(isActive: !bot.isActive);
      final updatedBots = [...state];
      updatedBots[botIndex] = toggledBot;
      state = updatedBots;
      _updateGameState();
    }
  }

  /// Fire a bot (sell it back for 50% cost)
  bool fireBot(String botId) {
    final gameStateNotifier = _ref.read(gameStateProvider.notifier);
    final botIndex = state.indexWhere((bot) => bot.id == botId);
    
    if (botIndex >= 0) {
      final bot = state[botIndex];
      final sellbackValue = bot.type.baseCost * 0.5; // 50% sellback
      
      // Remove bot and add sellback cash
      final updatedBots = [...state];
      updatedBots.removeAt(botIndex);
      state = updatedBots;
      
      gameStateNotifier.addCash(sellbackValue);
      _updateGameState();
      return true;
    }
    return false;
  }

  /// Get bots by type
  List<TradingBot> getBotsByType(BotType type) {
    return state.where((bot) => bot.type == type).toList();
  }

  /// Get total bots count
  int get totalBots => state.length;

  /// Get active bots count
  int get activeBots => state.where((bot) => bot.isActive).length;

  /// Get total earnings per second
  double get totalEarningsPerSecond {
    double total = 0.0;
    for (final bot in state) {
      if (bot.isActive) {
        total += bot.earningsPerSecond;
      }
    }
    return total;
  }

  /// Get bot by id
  TradingBot? getBotById(String botId) {
    try {
      return state.firstWhere((bot) => bot.id == botId);
    } catch (e) {
      return null;
    }
  }

  /// Check if bot type is owned
  bool hasBotOfType(BotType type) {
    return state.any((bot) => bot.type == type);
  }

  /// Get bot count by type
  int getBotCountByType(BotType type) {
    return state.where((bot) => bot.type == type).length;
  }

  /// Update game state with current bots
  void _updateGameState() {
    final currentState = _ref.read(gameStateProvider);
    _ref.read(gameStateProvider.notifier).state = currentState.copyWith(
      ownedBots: state,
      lastSaveTime: DateTime.now(),
    );
  }

  @override
  void dispose() {
    _botTimer?.cancel();
    super.dispose();
  }
}

/// Bot service for advanced bot operations
class BotService {
  static final BotService _instance = BotService._internal();
  factory BotService() => _instance;
  BotService._internal();

  /// Calculate bot performance stats
  BotStats calculateBotStats(TradingBot bot) {
    final now = DateTime.now();
    final hoursActive = now.difference(bot.hiredAt).inHours;
    final totalEarnings = bot.earningsPerSecond * 3600 * hoursActive;
    
    return BotStats(
      bot: bot,
      hoursActive: hoursActive,
      totalEarnings: totalEarnings,
      earningsPerHour: bot.earningsPerSecond * 3600,
      efficiency: _calculateEfficiency(bot),
    );
  }

  /// Calculate bot efficiency rating
  double _calculateEfficiency(TradingBot bot) {
    final baseEfficiency = bot.baseProfitPerHour / bot.type.baseCost;
    final levelMultiplier = 1.0 + (bot.level - 1) * 0.2;
    return baseEfficiency * levelMultiplier;
  }

  /// Get recommended bot for current game state
  BotType? getRecommendedBot(double availableCash, List<TradingBot> ownedBots) {
    final affordableBots = BotType.values.where((type) => type.baseCost <= availableCash);
    
    if (affordableBots.isEmpty) return null;
    
    // Recommend based on strategy
    if (ownedBots.isEmpty) {
      // First bot - recommend cheapest
      return affordableBots.reduce((a, b) => a.baseCost < b.baseCost ? a : b);
    } else {
      // Recommend most efficient affordable bot
      return affordableBots.reduce((a, b) {
        final efficiencyA = a.baseProfitPerHour / a.baseCost;
        final efficiencyB = b.baseProfitPerHour / b.baseCost;
        return efficiencyA > efficiencyB ? a : b;
      });
    }
  }

  /// Calculate optimal bot distribution
  Map<BotType, int> calculateOptimalDistribution(double totalBudget) {
    final distribution = <BotType, int>{};
    double remainingBudget = totalBudget;
    
    // Priority order: efficiency-based
    final sortedBots = BotType.values.toList()
      ..sort((a, b) {
        final efficiencyA = a.baseProfitPerHour / a.baseCost;
        final efficiencyB = b.baseProfitPerHour / b.baseCost;
        return efficiencyB.compareTo(efficiencyA);
      });
    
    for (final botType in sortedBots) {
      final count = (remainingBudget / botType.baseCost).floor();
      if (count > 0) {
        distribution[botType] = count;
        remainingBudget -= count * botType.baseCost;
      }
    }
    
    return distribution;
  }

  /// Get bot upgrade priority
  List<TradingBot> getUpgradePriority(List<TradingBot> bots, double availableCash) {
    final affordableUpgrades = bots.where((bot) => bot.upgradeCost <= availableCash);
    
    return affordableUpgrades.toList()
      ..sort((a, b) {
        // Sort by efficiency gain per cost
        final efficiencyA = (a.earningsPerSecond * 0.2) / a.upgradeCost;
        final efficiencyB = (b.earningsPerSecond * 0.2) / b.upgradeCost;
        return efficiencyB.compareTo(efficiencyA);
      });
  }
}

/// Bot performance statistics
class BotStats {
  final TradingBot bot;
  final int hoursActive;
  final double totalEarnings;
  final double earningsPerHour;
  final double efficiency;

  BotStats({
    required this.bot,
    required this.hoursActive,
    required this.totalEarnings,
    required this.earningsPerHour,
    required this.efficiency,
  });
}

/// Provider for bot service
final botServiceProvider = Provider((ref) => BotService());