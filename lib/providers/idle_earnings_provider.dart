/// Idle earnings provider for Perp Tycoon casino game
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:math' as math;
import '../models/game_models.dart';
import 'game_state_provider.dart';
import 'bot_provider.dart';

/// Provider for idle earnings calculation
final idleEarningsProvider = StateNotifierProvider<IdleEarningsNotifier, IdleEarningsState>((ref) {
  return IdleEarningsNotifier(ref);
});

/// Provider for offline earnings welcome screen
final offlineEarningsProvider = StateProvider<OfflineEarnings?>((ref) => null);

/// Idle earnings state
class IdleEarningsState {
  final double totalEarningsPerSecond;
  final double sessionEarnings;
  final DateTime sessionStart;
  final bool isCalculating;
  final Map<String, double> botContributions;

  IdleEarningsState({
    required this.totalEarningsPerSecond,
    required this.sessionEarnings,
    required this.sessionStart,
    required this.isCalculating,
    required this.botContributions,
  });

  IdleEarningsState copyWith({
    double? totalEarningsPerSecond,
    double? sessionEarnings,
    DateTime? sessionStart,
    bool? isCalculating,
    Map<String, double>? botContributions,
  }) {
    return IdleEarningsState(
      totalEarningsPerSecond: totalEarningsPerSecond ?? this.totalEarningsPerSecond,
      sessionEarnings: sessionEarnings ?? this.sessionEarnings,
      sessionStart: sessionStart ?? this.sessionStart,
      isCalculating: isCalculating ?? this.isCalculating,
      botContributions: botContributions ?? this.botContributions,
    );
  }
}

/// Offline earnings data
class OfflineEarnings {
  final double totalEarnings;
  final Duration timeOffline;
  final DateTime lastSaveTime;
  final DateTime returnTime;
  final Map<String, double> botBreakdown;
  final int maxOfflineHours;

  OfflineEarnings({
    required this.totalEarnings,
    required this.timeOffline,
    required this.lastSaveTime,
    required this.returnTime,
    required this.botBreakdown,
    this.maxOfflineHours = 24, // 24 hours max offline earnings
  });

  String get timeOfflineText {
    final hours = timeOffline.inHours;
    final minutes = timeOffline.inMinutes % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  double get earningsPerHour => totalEarnings / (timeOffline.inHours + 1);
}

/// Idle earnings notifier
class IdleEarningsNotifier extends StateNotifier<IdleEarningsState> {
  final Ref _ref;
  Timer? _earningsTimer;
  
  IdleEarningsNotifier(this._ref) : super(IdleEarningsState(
    totalEarningsPerSecond: 0.0,
    sessionEarnings: 0.0,
    sessionStart: DateTime.now(),
    isCalculating: false,
    botContributions: {},
  )) {
    _startEarningsCalculation();
    _checkForOfflineEarnings();
  }

  /// Start earnings calculation timer
  void _startEarningsCalculation() {
    _earningsTimer?.cancel();
    _earningsTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _calculateCurrentEarnings();
    });
  }

  /// Calculate current earnings per second
  void _calculateCurrentEarnings() {
    final gameState = _ref.read(gameStateProvider);
    final bots = gameState.ownedBots;
    
    if (bots.isEmpty) {
      state = state.copyWith(
        totalEarningsPerSecond: 0.0,
        botContributions: {},
      );
      return;
    }
    
    double totalEPS = 0.0;
    Map<String, double> contributions = {};
    
    for (final bot in bots) {
      if (bot.isActive) {
        final botEPS = bot.earningsPerSecond;
        totalEPS += botEPS;
        contributions[bot.id] = botEPS;
      }
    }
    
    // Apply prestige multiplier
    final prestigeMultiplier = 1.0 + (gameState.prestigeLevel * 0.25);
    totalEPS *= prestigeMultiplier;
    
    // Apply upgrade multipliers
    final upgradeMultipliers = gameState.upgradeMultipliers;
    final speedMultiplier = upgradeMultipliers[UpgradeType.speed] ?? 1.0;
    totalEPS *= speedMultiplier;
    
    // Update session earnings
    final sessionDuration = DateTime.now().difference(state.sessionStart);
    final sessionEarnings = totalEPS * sessionDuration.inSeconds;
    
    state = state.copyWith(
      totalEarningsPerSecond: totalEPS,
      sessionEarnings: sessionEarnings,
      botContributions: contributions,
    );
  }

  /// Check for offline earnings when app resumes
  void _checkForOfflineEarnings() {
    final gameState = _ref.read(gameStateProvider);
    final lastSaveTime = gameState.lastSaveTime;
    final now = DateTime.now();
    final timeOffline = now.difference(lastSaveTime);
    
    // Only calculate if offline for more than 5 minutes
    if (timeOffline.inMinutes > 5) {
      _calculateOfflineEarnings(lastSaveTime, now);
    }
  }

  /// Calculate offline earnings
  void _calculateOfflineEarnings(DateTime lastSaveTime, DateTime returnTime) {
    final gameState = _ref.read(gameStateProvider);
    final bots = gameState.ownedBots;
    
    if (bots.isEmpty) return;
    
    state = state.copyWith(isCalculating: true);
    
    final timeOffline = returnTime.difference(lastSaveTime);
    final maxOfflineHours = 24; // 24 hours max
    final effectiveHours = math.min(timeOffline.inHours, maxOfflineHours);
    final effectiveTime = Duration(hours: effectiveHours);
    
    double totalOfflineEarnings = 0.0;
    Map<String, double> botBreakdown = {};
    
    for (final bot in bots) {
      if (bot.isActive) {
        final botEarnings = bot.earningsPerSecond * effectiveTime.inSeconds;
        totalOfflineEarnings += botEarnings;
        botBreakdown[bot.name] = botEarnings;
      }
    }
    
    // Apply prestige multiplier
    final prestigeMultiplier = 1.0 + (gameState.prestigeLevel * 0.25);
    totalOfflineEarnings *= prestigeMultiplier;
    
    // Apply upgrade multipliers
    final upgradeMultipliers = gameState.upgradeMultipliers;
    final speedMultiplier = upgradeMultipliers[UpgradeType.speed] ?? 1.0;
    totalOfflineEarnings *= speedMultiplier;
    
    // Set offline earnings for welcome screen
    if (totalOfflineEarnings > 0) {
      _ref.read(offlineEarningsProvider.notifier).state = OfflineEarnings(
        totalEarnings: totalOfflineEarnings,
        timeOffline: timeOffline,
        lastSaveTime: lastSaveTime,
        returnTime: returnTime,
        botBreakdown: botBreakdown,
        maxOfflineHours: maxOfflineHours,
      );
      
      // Add earnings to game state
      _ref.read(gameStateProvider.notifier).addCash(totalOfflineEarnings);
    }
    
    state = state.copyWith(isCalculating: false);
  }

  /// Claim offline earnings (dismiss welcome screen)
  void claimOfflineEarnings() {
    _ref.read(offlineEarningsProvider.notifier).state = null;
  }

  /// Reset session earnings
  void resetSessionEarnings() {
    state = state.copyWith(
      sessionEarnings: 0.0,
      sessionStart: DateTime.now(),
    );
  }

  /// Get earnings projection for next N hours
  double getEarningsProjection(int hours) {
    return state.totalEarningsPerSecond * 3600 * hours;
  }

  /// Get time to afford specific amount
  Duration getTimeToAfford(double amount) {
    if (state.totalEarningsPerSecond <= 0) {
      return Duration(days: 365); // Never
    }
    
    final seconds = amount / state.totalEarningsPerSecond;
    return Duration(seconds: seconds.round());
  }

  /// Get bot efficiency ranking
  List<MapEntry<String, double>> getBotEfficiencyRanking() {
    final gameState = _ref.read(gameStateProvider);
    final bots = gameState.ownedBots;
    
    final efficiency = <String, double>{};
    
    for (final bot in bots) {
      if (bot.isActive) {
        final eps = bot.earningsPerSecond;
        final cost = bot.type.baseCost * bot.level;
        efficiency[bot.name] = eps / cost; // Efficiency = EPS per cost
      }
    }
    
    final sorted = efficiency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return sorted;
  }

  /// Get recommended next action
  String getRecommendedAction(double availableCash) {
    final gameState = _ref.read(gameStateProvider);
    final bots = gameState.ownedBots;
    
    if (bots.isEmpty) {
      return 'Hire your first bot to start earning offline!';
    }
    
    // Check for affordable upgrades
    final affordableUpgrades = bots.where((bot) => bot.upgradeCost <= availableCash);
    if (affordableUpgrades.isNotEmpty) {
      final cheapestUpgrade = affordableUpgrades.reduce((a, b) => 
        a.upgradeCost < b.upgradeCost ? a : b);
      return 'Upgrade ${cheapestUpgrade.name} for \$${cheapestUpgrade.upgradeCost.toStringAsFixed(0)}';
    }
    
    // Check for affordable new bots
    final affordableBots = BotType.values.where((type) => type.baseCost <= availableCash);
    if (affordableBots.isNotEmpty) {
      final cheapestBot = affordableBots.reduce((a, b) => 
        a.baseCost < b.baseCost ? a : b);
      return 'Hire ${cheapestBot.displayName} for \$${cheapestBot.baseCost.toStringAsFixed(0)}';
    }
    
    // Need to save up
    final nextBot = BotType.values.reduce((a, b) => 
      a.baseCost < b.baseCost ? a : b);
    final timeToAfford = getTimeToAfford(nextBot.baseCost - availableCash);
    
    return 'Save up for ${nextBot.displayName} (${_formatDuration(timeToAfford)} to go)';
  }

  /// Format duration to human readable
  String _formatDuration(Duration duration) {
    if (duration.inHours > 24) {
      return '${duration.inDays}d ${duration.inHours % 24}h';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else {
      return '${duration.inMinutes}m';
    }
  }

  @override
  void dispose() {
    _earningsTimer?.cancel();
    super.dispose();
  }
}

/// Idle earnings service for advanced calculations
class IdleEarningsService {
  static final IdleEarningsService _instance = IdleEarningsService._internal();
  factory IdleEarningsService() => _instance;
  IdleEarningsService._internal();

  /// Calculate optimal idle strategy
  IdleStrategy calculateOptimalStrategy(GameState gameState, double timeHorizon) {
    final availableCash = gameState.vaultCash;
    final currentEPS = gameState.totalEarningsPerSecond;
    final bots = gameState.ownedBots;
    
    // Calculate ROI for each possible action
    final actions = <IdleAction>[];
    
    // Bot upgrades
    for (final bot in bots) {
      if (bot.upgradeCost <= availableCash) {
        final currentEarnings = bot.earningsPerSecond;
        final upgradedEarnings = currentEarnings * 1.2; // 20% increase
        final earningsIncrease = upgradedEarnings - currentEarnings;
        final roi = (earningsIncrease * timeHorizon) / bot.upgradeCost;
        
        actions.add(IdleAction(
          type: IdleActionType.upgradeBot,
          description: 'Upgrade ${bot.name}',
          cost: bot.upgradeCost,
          earningsIncrease: earningsIncrease,
          roi: roi,
          botId: bot.id,
        ));
      }
    }
    
    // New bots
    for (final botType in BotType.values) {
      if (botType.baseCost <= availableCash) {
        final earningsIncrease = botType.baseProfitPerHour / 3600; // Per second
        final roi = (earningsIncrease * timeHorizon) / botType.baseCost;
        
        actions.add(IdleAction(
          type: IdleActionType.hireBotType,
          description: 'Hire ${botType.displayName}',
          cost: botType.baseCost,
          earningsIncrease: earningsIncrease,
          roi: roi,
          botType: botType,
        ));
      }
    }
    
    // Sort by ROI
    actions.sort((a, b) => b.roi.compareTo(a.roi));
    
    return IdleStrategy(
      currentEPS: currentEPS,
      timeHorizon: timeHorizon,
      recommendedActions: actions.take(5).toList(),
      totalPotentialIncrease: actions.fold(0.0, (sum, action) => sum + action.earningsIncrease),
    );
  }

  /// Calculate prestige timing
  PrestigeAnalysis calculatePrestigeTiming(GameState gameState) {
    final currentEPS = gameState.totalEarningsPerSecond;
    final currentTokens = gameState.starkTokens;
    final prestigeLevel = gameState.prestigeLevel;
    
    // Calculate potential tokens from prestige
    final potentialTokens = _calculatePrestigeTokens(gameState);
    
    // Calculate new multiplier after prestige
    final newMultiplier = 1.0 + ((prestigeLevel + 1) * 0.25);
    
    // Calculate time to rebuild current EPS
    final rebuildTime = _calculateRebuildTime(currentEPS, newMultiplier);
    
    // Calculate break-even point
    final breakEvenTime = _calculateBreakEvenTime(currentEPS, newMultiplier);
    
    return PrestigeAnalysis(
      currentEPS: currentEPS,
      potentialTokens: potentialTokens,
      newMultiplier: newMultiplier,
      rebuildTime: rebuildTime,
      breakEvenTime: breakEvenTime,
      recommended: breakEvenTime.inHours < 24, // Recommend if break-even < 24h
    );
  }

  int _calculatePrestigeTokens(GameState gameState) {
    final cashMilestone = gameState.vaultCash >= 1000000 ? 1 : 0;
    final tradeMilestone = gameState.stats.totalTrades >= 1000 ? 1 : 0;
    final winRateMilestone = gameState.stats.winRate >= 0.6 ? 1 : 0;
    
    return cashMilestone + tradeMilestone + winRateMilestone;
  }

  Duration _calculateRebuildTime(double currentEPS, double newMultiplier) {
    // Simplified calculation - in reality would depend on specific rebuild strategy
    final rebuildFactor = currentEPS / newMultiplier;
    final hours = math.log(rebuildFactor) * 10; // Logarithmic rebuild
    return Duration(hours: math.max(1, hours.round()));
  }

  Duration _calculateBreakEvenTime(double currentEPS, double newMultiplier) {
    // Time when new multiplied earnings exceed current earnings
    final breakEvenFactor = 1.0 / newMultiplier;
    final hours = math.log(breakEvenFactor) * -20; // Negative log for growth
    return Duration(hours: math.max(1, hours.round()));
  }
}

/// Idle strategy recommendation
class IdleStrategy {
  final double currentEPS;
  final double timeHorizon;
  final List<IdleAction> recommendedActions;
  final double totalPotentialIncrease;

  IdleStrategy({
    required this.currentEPS,
    required this.timeHorizon,
    required this.recommendedActions,
    required this.totalPotentialIncrease,
  });
}

/// Idle action recommendation
class IdleAction {
  final IdleActionType type;
  final String description;
  final double cost;
  final double earningsIncrease;
  final double roi;
  final String? botId;
  final BotType? botType;

  IdleAction({
    required this.type,
    required this.description,
    required this.cost,
    required this.earningsIncrease,
    required this.roi,
    this.botId,
    this.botType,
  });
}

enum IdleActionType {
  upgradeBot,
  hireBotType,
  purchaseUpgrade,
}

/// Prestige analysis
class PrestigeAnalysis {
  final double currentEPS;
  final int potentialTokens;
  final double newMultiplier;
  final Duration rebuildTime;
  final Duration breakEvenTime;
  final bool recommended;

  PrestigeAnalysis({
    required this.currentEPS,
    required this.potentialTokens,
    required this.newMultiplier,
    required this.rebuildTime,
    required this.breakEvenTime,
    required this.recommended,
  });
}

/// Provider for idle earnings service
final idleEarningsServiceProvider = Provider((ref) => IdleEarningsService());