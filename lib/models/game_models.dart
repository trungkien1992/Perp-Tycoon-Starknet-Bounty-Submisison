/// Core game models for Perp Tycoon casino idle game
import 'dart:convert';

/// Represents the overall game state
class GameState {
  final double vaultCash;
  final int starkTokens;
  final int prestigeLevel;
  final List<TradingBot> ownedBots;
  final List<Upgrade> ownedUpgrades;
  final DateTime lastSaveTime;
  final Map<String, dynamic> achievements;
  final GameStats stats;

  GameState({
    required this.vaultCash,
    required this.starkTokens,
    required this.prestigeLevel,
    required this.ownedBots,
    required this.ownedUpgrades,
    required this.lastSaveTime,
    required this.achievements,
    required this.stats,
  });

  /// Create initial game state for new players
  factory GameState.initial() {
    return GameState(
      vaultCash: 1000.0, // Starting with $1000
      starkTokens: 0,
      prestigeLevel: 0,
      ownedBots: [],
      ownedUpgrades: [],
      lastSaveTime: DateTime.now(),
      achievements: {},
      stats: GameStats.initial(),
    );
  }

  /// Calculate total earnings per second from all bots
  double get totalEarningsPerSecond {
    double totalEPS = 0.0;
    for (final bot in ownedBots) {
      totalEPS += bot.earningsPerSecond;
    }
    
    // Apply prestige multiplier
    final prestigeMultiplier = 1.0 + (prestigeLevel * 0.25); // +25% per prestige
    return totalEPS * prestigeMultiplier;
  }

  /// Calculate total upgrade multipliers
  Map<UpgradeType, double> get upgradeMultipliers {
    final multipliers = <UpgradeType, double>{
      UpgradeType.winRate: 1.0,
      UpgradeType.pnlBoost: 1.0,
      UpgradeType.speed: 1.0,
      UpgradeType.cosmetic: 1.0,
    };

    for (final upgrade in ownedUpgrades) {
      multipliers[upgrade.type] = (multipliers[upgrade.type] ?? 1.0) + upgrade.effect;
    }

    return multipliers;
  }

  /// Copy with modifications
  GameState copyWith({
    double? vaultCash,
    int? starkTokens,
    int? prestigeLevel,
    List<TradingBot>? ownedBots,
    List<Upgrade>? ownedUpgrades,
    DateTime? lastSaveTime,
    Map<String, dynamic>? achievements,
    GameStats? stats,
  }) {
    return GameState(
      vaultCash: vaultCash ?? this.vaultCash,
      starkTokens: starkTokens ?? this.starkTokens,
      prestigeLevel: prestigeLevel ?? this.prestigeLevel,
      ownedBots: ownedBots ?? this.ownedBots,
      ownedUpgrades: ownedUpgrades ?? this.ownedUpgrades,
      lastSaveTime: lastSaveTime ?? this.lastSaveTime,
      achievements: achievements ?? this.achievements,
      stats: stats ?? this.stats,
    );
  }

  /// Convert to JSON for persistence
  Map<String, dynamic> toJson() => {
    'vaultCash': vaultCash,
    'starkTokens': starkTokens,
    'prestigeLevel': prestigeLevel,
    'ownedBots': ownedBots.map((bot) => bot.toJson()).toList(),
    'ownedUpgrades': ownedUpgrades.map((upgrade) => upgrade.toJson()).toList(),
    'lastSaveTime': lastSaveTime.toIso8601String(),
    'achievements': achievements,
    'stats': stats.toJson(),
  };

  /// Create from JSON
  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      vaultCash: (json['vaultCash'] as num).toDouble(),
      starkTokens: json['starkTokens'] as int,
      prestigeLevel: json['prestigeLevel'] as int,
      ownedBots: (json['ownedBots'] as List)
          .map((botJson) => TradingBot.fromJson(botJson))
          .toList(),
      ownedUpgrades: (json['ownedUpgrades'] as List)
          .map((upgradeJson) => Upgrade.fromJson(upgradeJson))
          .toList(),
      lastSaveTime: DateTime.parse(json['lastSaveTime']),
      achievements: Map<String, dynamic>.from(json['achievements']),
      stats: GameStats.fromJson(json['stats']),
    );
  }
}

/// Represents a trading bot that earns money while idle
class TradingBot {
  final String id;
  final BotType type;
  final String name;
  final String market;
  final double baseProfitPerHour;
  final double speed; // Trades per hour
  final int level;
  final DateTime hiredAt;
  final bool isActive;

  TradingBot({
    required this.id,
    required this.type,
    required this.name,
    required this.market,
    required this.baseProfitPerHour,
    required this.speed,
    required this.level,
    required this.hiredAt,
    this.isActive = true,
  });

  /// Earnings per second calculation
  double get earningsPerSecond {
    final levelMultiplier = 1.0 + (level * 0.2); // +20% per level
    return (baseProfitPerHour * levelMultiplier) / 3600; // Convert to per second
  }

  /// Cost to upgrade this bot to next level
  double get upgradeCost {
    return 1000 * (level + 1) * (level + 1); // Quadratic scaling
  }

  /// Copy with modifications
  TradingBot copyWith({
    String? id,
    BotType? type,
    String? name,
    String? market,
    double? baseProfitPerHour,
    double? speed,
    int? level,
    DateTime? hiredAt,
    bool? isActive,
  }) {
    return TradingBot(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      market: market ?? this.market,
      baseProfitPerHour: baseProfitPerHour ?? this.baseProfitPerHour,
      speed: speed ?? this.speed,
      level: level ?? this.level,
      hiredAt: hiredAt ?? this.hiredAt,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.toString().split('.').last,
    'name': name,
    'market': market,
    'baseProfitPerHour': baseProfitPerHour,
    'speed': speed,
    'level': level,
    'hiredAt': hiredAt.toIso8601String(),
    'isActive': isActive,
  };

  /// Create from JSON
  factory TradingBot.fromJson(Map<String, dynamic> json) {
    return TradingBot(
      id: json['id'],
      type: BotType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      name: json['name'],
      market: json['market'],
      baseProfitPerHour: (json['baseProfitPerHour'] as num).toDouble(),
      speed: (json['speed'] as num).toDouble(),
      level: json['level'],
      hiredAt: DateTime.parse(json['hiredAt']),
      isActive: json['isActive'],
    );
  }
}

/// Bot types with different specializations
enum BotType {
  ethEnthusiast,
  btcMaximalist,
  avaxAdventurer,
  memeCoinManiac,
  stablecoinSage,
}

extension BotTypeExtension on BotType {
  String get displayName {
    switch (this) {
      case BotType.ethEnthusiast:
        return 'ETH Enthusiast';
      case BotType.btcMaximalist:
        return 'BTC Maximalist';
      case BotType.avaxAdventurer:
        return 'AVAX Adventurer';
      case BotType.memeCoinManiac:
        return 'Meme Coin Maniac';
      case BotType.stablecoinSage:
        return 'Stablecoin Sage';
    }
  }

  String get emoji {
    switch (this) {
      case BotType.ethEnthusiast:
        return '🔷';
      case BotType.btcMaximalist:
        return '₿';
      case BotType.avaxAdventurer:
        return '🏔️';
      case BotType.memeCoinManiac:
        return '🐕';
      case BotType.stablecoinSage:
        return '💎';
    }
  }

  String get market {
    switch (this) {
      case BotType.ethEnthusiast:
        return 'ETH-USD';
      case BotType.btcMaximalist:
        return 'BTC-USD';
      case BotType.avaxAdventurer:
        return 'AVAX-USD';
      case BotType.memeCoinManiac:
        return 'DOGE-USD';
      case BotType.stablecoinSage:
        return 'USDC-USD';
    }
  }

  double get baseCost {
    switch (this) {
      case BotType.ethEnthusiast:
        return 1000.0;
      case BotType.btcMaximalist:
        return 2500.0;
      case BotType.avaxAdventurer:
        return 1500.0;
      case BotType.memeCoinManiac:
        return 5000.0;
      case BotType.stablecoinSage:
        return 500.0;
    }
  }

  double get baseProfitPerHour {
    switch (this) {
      case BotType.ethEnthusiast:
        return 100.0;
      case BotType.btcMaximalist:
        return 200.0;
      case BotType.avaxAdventurer:
        return 150.0;
      case BotType.memeCoinManiac:
        return 300.0;
      case BotType.stablecoinSage:
        return 50.0;
    }
  }
}

/// Represents upgrades that enhance trading performance
class Upgrade {
  final String id;
  final UpgradeType type;
  final String name;
  final String description;
  final double cost;
  final double effect;
  final int level;
  final DateTime purchasedAt;

  Upgrade({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.cost,
    required this.effect,
    required this.level,
    required this.purchasedAt,
  });

  /// Copy with modifications
  Upgrade copyWith({
    String? id,
    UpgradeType? type,
    String? name,
    String? description,
    double? cost,
    double? effect,
    int? level,
    DateTime? purchasedAt,
  }) {
    return Upgrade(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      description: description ?? this.description,
      cost: cost ?? this.cost,
      effect: effect ?? this.effect,
      level: level ?? this.level,
      purchasedAt: purchasedAt ?? this.purchasedAt,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.toString().split('.').last,
    'name': name,
    'description': description,
    'cost': cost,
    'effect': effect,
    'level': level,
    'purchasedAt': purchasedAt.toIso8601String(),
  };

  /// Create from JSON
  factory Upgrade.fromJson(Map<String, dynamic> json) {
    return Upgrade(
      id: json['id'],
      type: UpgradeType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      name: json['name'],
      description: json['description'],
      cost: (json['cost'] as num).toDouble(),
      effect: (json['effect'] as num).toDouble(),
      level: json['level'],
      purchasedAt: DateTime.parse(json['purchasedAt']),
    );
  }
}

/// Types of upgrades available
enum UpgradeType {
  winRate,
  pnlBoost,
  speed,
  cosmetic,
}

extension UpgradeTypeExtension on UpgradeType {
  String get displayName {
    switch (this) {
      case UpgradeType.winRate:
        return 'Win Rate';
      case UpgradeType.pnlBoost:
        return 'Profit Multiplier';
      case UpgradeType.speed:
        return 'Trading Speed';
      case UpgradeType.cosmetic:
        return 'Cosmetic';
    }
  }

  String get description {
    switch (this) {
      case UpgradeType.winRate:
        return 'Increases chance of successful trades';
      case UpgradeType.pnlBoost:
        return 'Multiplies profit from successful trades';
      case UpgradeType.speed:
        return 'Reduces time between trades';
      case UpgradeType.cosmetic:
        return 'Visual enhancements for casino floor';
    }
  }
}

/// Game statistics tracking
class GameStats {
  final int totalTrades;
  final int successfulTrades;
  final double totalPnL;
  final double maxSingleProfit;
  final double maxSingleLoss;
  final int totalXPGained;
  final Duration totalPlayTime;
  final int prestigeCount;

  GameStats({
    required this.totalTrades,
    required this.successfulTrades,
    required this.totalPnL,
    required this.maxSingleProfit,
    required this.maxSingleLoss,
    required this.totalXPGained,
    required this.totalPlayTime,
    required this.prestigeCount,
  });

  factory GameStats.initial() {
    return GameStats(
      totalTrades: 0,
      successfulTrades: 0,
      totalPnL: 0.0,
      maxSingleProfit: 0.0,
      maxSingleLoss: 0.0,
      totalXPGained: 0,
      totalPlayTime: Duration.zero,
      prestigeCount: 0,
    );
  }

  double get winRate {
    if (totalTrades == 0) return 0.0;
    return successfulTrades / totalTrades;
  }

  GameStats copyWith({
    int? totalTrades,
    int? successfulTrades,
    double? totalPnL,
    double? maxSingleProfit,
    double? maxSingleLoss,
    int? totalXPGained,
    Duration? totalPlayTime,
    int? prestigeCount,
  }) {
    return GameStats(
      totalTrades: totalTrades ?? this.totalTrades,
      successfulTrades: successfulTrades ?? this.successfulTrades,
      totalPnL: totalPnL ?? this.totalPnL,
      maxSingleProfit: maxSingleProfit ?? this.maxSingleProfit,
      maxSingleLoss: maxSingleLoss ?? this.maxSingleLoss,
      totalXPGained: totalXPGained ?? this.totalXPGained,
      totalPlayTime: totalPlayTime ?? this.totalPlayTime,
      prestigeCount: prestigeCount ?? this.prestigeCount,
    );
  }

  Map<String, dynamic> toJson() => {
    'totalTrades': totalTrades,
    'successfulTrades': successfulTrades,
    'totalPnL': totalPnL,
    'maxSingleProfit': maxSingleProfit,
    'maxSingleLoss': maxSingleLoss,
    'totalXPGained': totalXPGained,
    'totalPlayTime': totalPlayTime.inSeconds,
    'prestigeCount': prestigeCount,
  };

  factory GameStats.fromJson(Map<String, dynamic> json) {
    return GameStats(
      totalTrades: json['totalTrades'],
      successfulTrades: json['successfulTrades'],
      totalPnL: (json['totalPnL'] as num).toDouble(),
      maxSingleProfit: (json['maxSingleProfit'] as num).toDouble(),
      maxSingleLoss: (json['maxSingleLoss'] as num).toDouble(),
      totalXPGained: json['totalXPGained'],
      totalPlayTime: Duration(seconds: json['totalPlayTime']),
      prestigeCount: json['prestigeCount'],
    );
  }
}