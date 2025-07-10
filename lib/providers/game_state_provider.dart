/// Core game state provider for Perp Tycoon casino game
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:math' as math;
import '../models/game_models.dart';

/// Provider for the main game state
final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  return GameStateNotifier();
});

/// Provider for current coin type
final coinTypeProvider = StateProvider<CoinType>((ref) => CoinType.copper);

/// Provider for selected trading direction
final tradingDirectionProvider = StateProvider<TradingDirection>((ref) => TradingDirection.long);

/// Coin types for progression system
enum CoinType {
  copper,
  silver,
  gold,
}

extension CoinTypeExtension on CoinType {
  String get displayName {
    switch (this) {
      case CoinType.copper:
        return 'Copper Coin';
      case CoinType.silver:
        return 'Silver Coin';
      case CoinType.gold:
        return 'Gold Coin';
    }
  }

  String get emoji {
    switch (this) {
      case CoinType.copper:
        return '🪙';
      case CoinType.silver:
        return '⚪';
      case CoinType.gold:
        return '🟡';
    }
  }

  double get baseMultiplier {
    switch (this) {
      case CoinType.copper:
        return 1.0;
      case CoinType.silver:
        return 2.0;
      case CoinType.gold:
        return 5.0;
    }
  }

  double get unlockCost {
    switch (this) {
      case CoinType.copper:
        return 0.0; // Free starting coin
      case CoinType.silver:
        return 5000.0;
      case CoinType.gold:
        return 25000.0;
    }
  }
}

/// Trading direction for coin toss
enum TradingDirection {
  long,  // Heads
  short, // Tails
}

extension TradingDirectionExtension on TradingDirection {
  String get displayName {
    switch (this) {
      case TradingDirection.long:
        return 'LONG (Heads)';
      case TradingDirection.short:
        return 'SHORT (Tails)';
    }
  }

  String get emoji {
    switch (this) {
      case TradingDirection.long:
        return '📈';
      case TradingDirection.short:
        return '📉';
    }
  }
}

/// Game state notifier that manages the core game state
class GameStateNotifier extends StateNotifier<GameState> {
  static const String _dbName = 'perp_tycoon.db';
  static const String _tableName = 'game_state';
  
  Database? _database;
  
  GameStateNotifier() : super(GameState.initial()) {
    _initializeDatabase();
  }

  /// Initialize SQLite database
  Future<void> _initializeDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, _dbName);
      
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE $_tableName (
              id INTEGER PRIMARY KEY,
              game_data TEXT NOT NULL,
              last_updated INTEGER NOT NULL
            )
          ''');
        },
      );
      
      // Load existing game state
      await _loadGameState();
    } catch (e) {
      print('Error initializing database: $e');
    }
  }

  /// Load game state from database
  Future<void> _loadGameState() async {
    if (_database == null) return;
    
    try {
      final results = await _database!.query(
        _tableName,
        limit: 1,
        orderBy: 'last_updated DESC',
      );
      
      if (results.isNotEmpty) {
        final gameData = jsonDecode(results.first['game_data'] as String);
        state = GameState.fromJson(gameData);
      }
    } catch (e) {
      print('Error loading game state: $e');
    }
  }

  /// Save game state to database
  Future<void> _saveGameState() async {
    if (_database == null) return;
    
    try {
      await _database!.insert(
        _tableName,
        {
          'game_data': jsonEncode(state.toJson()),
          'last_updated': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error saving game state: $e');
    }
  }

  /// Execute a coin toss trade
  Future<TradeResult> executeCoinToss({
    required TradingDirection direction,
    required CoinType coinType,
    required String market,
  }) async {
    // Simulate coin toss (50/50 chance)
    final random = math.Random();
    final coinResult = random.nextBool(); // true = heads, false = tails
    final isWin = (direction == TradingDirection.long && coinResult) || 
                  (direction == TradingDirection.short && !coinResult);
    
    // Calculate volatility-based PnL
    final volatility = _getMarketVolatility(market);
    final baseAmount = 50 + random.nextInt(100); // $50-150 base
    final coinMultiplier = coinType.baseMultiplier;
    final upgradeMultipliers = state.upgradeMultipliers;
    
    final pnlMultiplier = coinMultiplier * 
                         (upgradeMultipliers[UpgradeType.pnlBoost] ?? 1.0);
    
    final pnl = isWin 
        ? baseAmount * volatility * pnlMultiplier
        : -baseAmount * volatility * 0.5; // Losses are reduced
    
    final xpGained = 10 + random.nextInt(20); // 10-30 XP
    
    // Update game state
    final newVaultCash = math.max(0, state.vaultCash + pnl);
    final updatedStats = state.stats.copyWith(
      totalTrades: state.stats.totalTrades + 1,
      successfulTrades: isWin ? state.stats.successfulTrades + 1 : state.stats.successfulTrades,
      totalPnL: state.stats.totalPnL + pnl,
      maxSingleProfit: isWin ? math.max(state.stats.maxSingleProfit, pnl) : state.stats.maxSingleProfit,
      maxSingleLoss: !isWin ? math.max(state.stats.maxSingleLoss, pnl.abs()) : state.stats.maxSingleLoss,
      totalXPGained: state.stats.totalXPGained + xpGained,
    );
    
    state = state.copyWith(
      vaultCash: newVaultCash.toDouble(),
      stats: updatedStats,
      lastSaveTime: DateTime.now(),
    );
    
    // Save to database
    await _saveGameState();
    
    return TradeResult(
      isWin: isWin,
      pnl: pnl,
      xpGained: xpGained,
      coinResult: coinResult,
      market: market,
      direction: direction,
      coinType: coinType,
    );
  }

  /// Get market volatility for PnL calculation
  double _getMarketVolatility(String market) {
    switch (market.toUpperCase()) {
      case 'BTC-USD':
        return 0.8; // Low volatility
      case 'ETH-USD':
        return 1.2; // Medium volatility
      case 'AVAX-USD':
        return 1.8; // High volatility
      case 'DOGE-USD':
        return 2.5; // Extreme volatility
      case 'USDC-USD':
        return 0.1; // Minimal volatility
      default:
        return 1.0;
    }
  }

  /// Add cash to vault (from bot earnings, etc.)
  void addCash(double amount) {
    state = state.copyWith(
      vaultCash: state.vaultCash + amount,
      lastSaveTime: DateTime.now(),
    );
    _saveGameState();
  }

  /// Spend cash (for upgrades, bots, etc.)
  bool spendCash(double amount) {
    if (state.vaultCash >= amount) {
      state = state.copyWith(
        vaultCash: state.vaultCash - amount,
        lastSaveTime: DateTime.now(),
      );
      _saveGameState();
      return true;
    }
    return false;
  }

  /// Add Stark Tokens (from prestige)
  void addStarkTokens(int amount) {
    state = state.copyWith(
      starkTokens: state.starkTokens + amount,
      lastSaveTime: DateTime.now(),
    );
    _saveGameState();
  }

  /// Prestige reset
  void prestige() {
    // Calculate Stark Tokens earned
    final tokensEarned = _calculatePrestigeTokens();
    
    // Reset game state but preserve tokens and achievements
    state = GameState(
      vaultCash: 1000.0, // Reset to starting cash
      starkTokens: state.starkTokens + tokensEarned,
      prestigeLevel: state.prestigeLevel + 1,
      ownedBots: [], // Reset bots
      ownedUpgrades: [], // Reset upgrades
      lastSaveTime: DateTime.now(),
      achievements: state.achievements, // Preserve achievements
      stats: state.stats.copyWith(
        prestigeCount: state.stats.prestigeCount + 1,
      ),
    );
    
    _saveGameState();
  }

  /// Calculate Stark Tokens earned from prestige
  int _calculatePrestigeTokens() {
    final cashMilestone = state.vaultCash >= 1000000 ? 1 : 0;
    final tradeMilestone = state.stats.totalTrades >= 1000 ? 1 : 0;
    final winRateMilestone = state.stats.winRate >= 0.6 ? 1 : 0;
    
    return cashMilestone + tradeMilestone + winRateMilestone;
  }

  /// Check if player can afford an item
  bool canAfford(double cost) {
    return state.vaultCash >= cost;
  }

  /// Get current level based on total XP
  int get currentLevel {
    return (state.stats.totalXPGained ~/ 100) + 1;
  }

  /// Get XP progress in current level
  double get xpProgress {
    return (state.stats.totalXPGained % 100) / 100.0;
  }

  /// Dispose resources
  @override
  void dispose() {
    _database?.close();
    super.dispose();
  }
}

/// Result of a coin toss trade
class TradeResult {
  final bool isWin;
  final double pnl;
  final int xpGained;
  final bool coinResult; // true = heads, false = tails
  final String market;
  final TradingDirection direction;
  final CoinType coinType;

  TradeResult({
    required this.isWin,
    required this.pnl,
    required this.xpGained,
    required this.coinResult,
    required this.market,
    required this.direction,
    required this.coinType,
  });

  String get resultEmoji => isWin ? '🚀' : '💥';
  String get coinEmoji => coinResult ? '👑' : '🪙'; // Heads or Tails
  String get pnlText => isWin ? 'MOON! +\$${pnl.toStringAsFixed(0)}' : 'RUG! \$${pnl.abs().toStringAsFixed(0)}';
}