/// Test configuration and setup for Perp Tycoon Phase 1 tests
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../lib/models/game_models.dart';

class TestSetup {
  /// Initialize test environment
  static void initializeTestEnvironment() {
    // Initialize FFI for SQLite testing
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    
    // Set up test-specific configurations
    TestWidgetsFlutterBinding.ensureInitialized();
  }
  
  /// Create a fresh ProviderContainer for testing
  static ProviderContainer createTestContainer() {
    return ProviderContainer();
  }
  
  /// Create test game state with default values
  static GameState createTestGameState({
    double vaultCash = 1000.0,
    List<Upgrade> ownedUpgrades = const [],
    List<TradingBot> ownedBots = const [],
    int prestigeLevel = 0,
    int starkTokens = 0,
  }) {
    return GameState(
      vaultCash: vaultCash,
      ownedUpgrades: ownedUpgrades,
      ownedBots: ownedBots,
      stats: TradingStats(
        totalTrades: 0,
        totalWinnings: 0.0,
        totalLosses: 0.0,
        winRate: 0.0,
      ),
      prestigeLevel: prestigeLevel,
      starkTokens: starkTokens,
      lastSaveTime: DateTime.now(),
    );
  }
  
  /// Create test trading bot
  static TradingBot createTestBot({
    String id = 'test_bot',
    BotType type = BotType.ethEnthusiast,
    String name = 'Test Bot',
    double baseProfitPerHour = 100.0,
    int level = 1,
    bool isActive = true,
  }) {
    return TradingBot(
      id: id,
      type: type,
      name: name,
      market: type.market,
      baseProfitPerHour: baseProfitPerHour,
      speed: 1.0,
      level: level,
      hiredAt: DateTime.now(),
      isActive: isActive,
    );
  }
  
  /// Create test upgrade
  static Upgrade createTestUpgrade({
    String id = 'test_upgrade',
    UpgradeType type = UpgradeType.pnlBoost,
    String name = 'Test Upgrade',
    String description = 'Test upgrade description',
    double cost = 1000.0,
    double effect = 0.5,
    int level = 1,
  }) {
    return Upgrade(
      id: id,
      type: type,
      name: name,
      description: description,
      cost: cost,
      effect: effect,
      level: level,
      purchasedAt: DateTime.now(),
    );
  }
  
  /// Wait for animations to complete
  static Future<void> waitForAnimations(WidgetTester tester) async {
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 3)); // Wait for coin toss animation
  }
  
  /// Assert floating point equality with tolerance
  static void expectFloatEquals(double actual, double expected, {double tolerance = 0.001}) {
    expect((actual - expected).abs(), lessThan(tolerance),
        reason: 'Expected $actual to equal $expected within tolerance $tolerance');
  }
  
  /// Create upgrade definition for testing
  static UpgradeDefinition createTestUpgradeDefinition({
    String id = 'test_upgrade_def',
    UpgradeType type = UpgradeType.pnlBoost,
    String name = 'Test Upgrade Def',
    String description = 'Test upgrade definition',
    double baseCost = 1000.0,
    double effect = 0.1,
    int maxLevel = 5,
    String category = 'Test',
    String emoji = '🧪',
  }) {
    return UpgradeDefinition(
      id: id,
      type: type,
      name: name,
      description: description,
      baseCost: baseCost,
      effect: effect,
      maxLevel: maxLevel,
      category: category,
      emoji: emoji,
    );
  }
}

/// Common test data and constants
class TestData {
  // Default game values
  static const double defaultStartingCash = 1000.0;
  static const int copperXP = 1;
  static const int silverXP = 2;
  static const int goldXP = 3;
  
  // Bot costs (should match actual bot definitions)
  static const Map<BotType, double> botCosts = {
    BotType.ethEnthusiast: 2500.0,
    BotType.btcMaximalist: 5000.0,
    BotType.altcoinHunter: 1500.0,
    BotType.defiExplorer: 7500.0,
    BotType.nftCollector: 10000.0,
  };
  
  // Upgrade costs (should match actual upgrade definitions)
  static const Map<String, double> upgradeCosts = {
    'unlock_eth': 2000.0,
    'unlock_strk': 3500.0,
    'unlock_meme': 5000.0,
    'leverage_2x': 2000.0,
    'leverage_5x': 10000.0,
    'leverage_10x': 50000.0,
    'quantum_charts': 5000.0,
    'market_intel': 7500.0,
    'flash_execution': 1500.0,
    'lightning_speed': 7500.0,
    'neon_lights': 3000.0,
    'vip_area': 15000.0,
    'diamond_buttons': 25000.0,
  };
  
  // Market volatility ranges (should match game implementation)
  static const Map<String, double> marketVolatility = {
    'BTC-USD': 50.0,
    'ETH-USD': 40.0,
    'AVAX-USD': 30.0,
    'DOGE-USD': 25.0,
    'USDC-USD': 5.0,
  };
  
  // Test scenarios for different cash amounts
  static const List<double> testCashAmounts = [
    0.0,      // No cash
    100.0,    // Very low cash
    1000.0,   // Starting amount
    5000.0,   // Moderate amount
    25000.0,  // High amount
    100000.0, // Very high amount
  ];
  
  // Test scenarios for different XP amounts
  static const List<int> testXPAmounts = [
    0,     // Starting XP
    50,    // Mid-level
    99,    // Almost level up
    100,   // Level up
    250,   // Multiple levels
    1000,  // High level
  ];
}

/// Test helpers for specific scenarios
class TestHelpers {
  /// Execute a coin toss and return the result
  static Future<TradeResult> executeCoinToss(
    WidgetTester tester,
    ProviderContainer container, {
    TradingDirection direction = TradingDirection.long,
    CoinType coinType = CoinType.copper,
    String market = 'BTC-USD',
  }) async {
    // Set trading parameters
    container.read(tradingDirectionProvider.notifier).state = direction;
    container.read(coinTypeProvider.notifier).state = coinType;
    
    // Execute coin toss
    final result = await container.read(gameStateProvider.notifier).executeCoinToss(
      direction: direction,
      coinType: coinType,
      market: market,
    );
    
    return result;
  }
  
  /// Purchase an upgrade and return success status
  static Future<bool> purchaseUpgrade(
    ProviderContainer container,
    UpgradeDefinition upgradeDef,
  ) async {
    final upgradeService = UpgradeService();
    return await upgradeService.purchaseUpgrade(
      container.read as WidgetRef,
      upgradeDef,
    );
  }
  
  /// Hire a bot and return success status
  static bool hireBot(
    ProviderContainer container,
    BotType botType,
  ) {
    return container.read(botProvider.notifier).hireBot(botType);
  }
  
  /// Verify game state consistency
  static void verifyGameStateConsistency(GameState gameState) {
    // Cash should never be negative
    expect(gameState.vaultCash, greaterThanOrEqualTo(0.0));
    
    // Stats should be consistent
    expect(gameState.stats.totalTrades, greaterThanOrEqualTo(0));
    expect(gameState.stats.totalWinnings, greaterThanOrEqualTo(0.0));
    expect(gameState.stats.totalLosses, greaterThanOrEqualTo(0.0));
    expect(gameState.stats.winRate, greaterThanOrEqualTo(0.0));
    expect(gameState.stats.winRate, lessThanOrEqualTo(1.0));
    
    // Prestige should be non-negative
    expect(gameState.prestigeLevel, greaterThanOrEqualTo(0));
    expect(gameState.starkTokens, greaterThanOrEqualTo(0));
    
    // Bots should have valid properties
    for (final bot in gameState.ownedBots) {
      expect(bot.level, greaterThan(0));
      expect(bot.baseProfitPerHour, greaterThan(0));
      expect(bot.speed, greaterThan(0));
    }
    
    // Upgrades should have valid properties
    for (final upgrade in gameState.ownedUpgrades) {
      expect(upgrade.level, greaterThan(0));
      expect(upgrade.cost, greaterThanOrEqualTo(0));
    }
  }
  
  /// Wait for idle earnings to be calculated
  static Future<void> waitForIdleEarnings(WidgetTester tester) async {
    // Wait for the idle earnings timer to trigger
    await tester.pump(Duration(seconds: 2));
  }
  
  /// Generate random test data for stress testing
  static List<TradeResult> generateRandomTradeResults(int count) {
    final random = DateTime.now().millisecondsSinceEpoch;
    final results = <TradeResult>[];
    
    for (int i = 0; i < count; i++) {
      final isWin = (random + i) % 2 == 0;
      final pnl = isWin ? 25.0 + (i % 50) : -(15.0 + (i % 30));
      
      results.add(TradeResult(
        isWin: isWin,
        pnl: pnl,
        xpGained: CoinType.copper.xpValue,
        direction: TradingDirection.long,
        coinType: CoinType.copper,
        market: 'BTC-USD',
        coinEmoji: isWin ? '🟢' : '🔴',
      ));
    }
    
    return results;
  }
}

/// Performance testing utilities
class PerformanceTestUtils {
  /// Measure execution time of a function
  static Future<Duration> measureExecutionTime(Future<void> Function() function) async {
    final startTime = DateTime.now();
    await function();
    final endTime = DateTime.now();
    return endTime.difference(startTime);
  }
  
  /// Run performance benchmark
  static Future<void> runPerformanceBenchmark(
    String testName,
    Future<void> Function() function, {
    Duration maxExpectedTime = const Duration(seconds: 1),
  }) async {
    print('⚡ Running performance test: $testName');
    
    final executionTime = await measureExecutionTime(function);
    
    print('   Execution time: ${executionTime.inMilliseconds}ms');
    print('   Max expected: ${maxExpectedTime.inMilliseconds}ms');
    
    if (executionTime <= maxExpectedTime) {
      print('   ✅ Performance test passed');
    } else {
      print('   ❌ Performance test failed');
    }
    
    expect(executionTime, lessThanOrEqualTo(maxExpectedTime),
        reason: '$testName exceeded maximum expected execution time');
  }
}

/// Mock data for testing edge cases
class MockData {
  /// Create a game state with maximum values
  static GameState createMaxGameState() {
    return GameState(
      vaultCash: double.maxFinite,
      ownedUpgrades: List.generate(10, (index) => TestSetup.createTestUpgrade(
        id: 'max_upgrade_$index',
        level: 999,
        effect: 10.0,
      )),
      ownedBots: List.generate(5, (index) => TestSetup.createTestBot(
        id: 'max_bot_$index',
        level: 999,
        baseProfitPerHour: 999999.0,
      )),
      stats: TradingStats(
        totalTrades: 999999,
        totalWinnings: double.maxFinite,
        totalLosses: 0.0,
        winRate: 1.0,
      ),
      prestigeLevel: 999,
      starkTokens: 999999,
      lastSaveTime: DateTime.now(),
    );
  }
  
  /// Create a game state with minimum values
  static GameState createMinGameState() {
    return GameState(
      vaultCash: 0.0,
      ownedUpgrades: [],
      ownedBots: [],
      stats: TradingStats(
        totalTrades: 0,
        totalWinnings: 0.0,
        totalLosses: 0.0,
        winRate: 0.0,
      ),
      prestigeLevel: 0,
      starkTokens: 0,
      lastSaveTime: DateTime.now(),
    );
  }
}