import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/game_models.dart';

void main() {
  group('GameState', () {
    test('should create initial game state correctly', () {
      final gameState = GameState.initial();
      
      expect(gameState.vaultCash, 1000.0);
      expect(gameState.starkTokens, 0);
      expect(gameState.prestigeLevel, 0);
      expect(gameState.ownedBots, isEmpty);
      expect(gameState.ownedUpgrades, isEmpty);
      expect(gameState.achievements, isEmpty);
      expect(gameState.stats.totalTrades, 0);
      expect(gameState.stats.successfulTrades, 0);
      expect(gameState.stats.totalPnL, 0.0);
    });

    test('should calculate total earnings per second correctly', () {
      final bot1 = TradingBot(
        id: 'bot1',
        type: BotType.ethEnthusiast,
        name: 'ETH Bot',
        market: 'ETH-USD',
        baseProfitPerHour: 3600, // 1 per second
        speed: 1.0,
        level: 1,
        hiredAt: DateTime.now(),
      );
      
      final bot2 = TradingBot(
        id: 'bot2',
        type: BotType.btcMaximalist,
        name: 'BTC Bot',
        market: 'BTC-USD',
        baseProfitPerHour: 7200, // 2 per second
        speed: 1.0,
        level: 1,
        hiredAt: DateTime.now(),
      );
      
      final gameState = GameState.initial().copyWith(
        ownedBots: [bot1, bot2],
      );
      
      expect(gameState.totalEarningsPerSecond, greaterThan(0));
    });

    test('should apply prestige multiplier correctly', () {
      final bot = TradingBot(
        id: 'bot1',
        type: BotType.ethEnthusiast,
        name: 'ETH Bot',
        market: 'ETH-USD',
        baseProfitPerHour: 3600,
        speed: 1.0,
        level: 1,
        hiredAt: DateTime.now(),
      );
      
      final gameState = GameState.initial().copyWith(
        ownedBots: [bot],
        prestigeLevel: 1,
      );
      
      // Should have 25% bonus from prestige level 1
      expect(gameState.totalEarningsPerSecond, greaterThan(bot.earningsPerSecond));
    });
  });

  group('TradingBot', () {
    test('should calculate earnings per second correctly', () {
      final bot = TradingBot(
        id: 'test',
        type: BotType.ethEnthusiast,
        name: 'Test Bot',
        market: 'ETH-USD',
        baseProfitPerHour: 3600, // Should be 1 per second at level 1
        speed: 1.0,
        level: 1,
        hiredAt: DateTime.now(),
      );
      
      expect(bot.earningsPerSecond, closeTo(1.2, 0.1)); // 1 * 1.2 level multiplier
    });

    test('should calculate upgrade cost correctly', () {
      final bot = TradingBot(
        id: 'test',
        type: BotType.ethEnthusiast,
        name: 'Test Bot',
        market: 'ETH-USD',
        baseProfitPerHour: 100,
        speed: 1.0,
        level: 1,
        hiredAt: DateTime.now(),
      );
      
      expect(bot.upgradeCost, 4000); // 1000 * (1+1) * (1+1)
    });
  });

  group('GameStats', () {
    test('should calculate win rate correctly', () {
      final stats = GameStats(
        totalTrades: 10,
        successfulTrades: 7,
        totalPnL: 100.0,
        maxSingleProfit: 50.0,
        maxSingleLoss: 25.0,
        totalXPGained: 100,
        totalPlayTime: Duration(hours: 2),
        prestigeCount: 1,
      );
      
      expect(stats.winRate, 0.7);
    });

    test('should handle zero trades correctly', () {
      final stats = GameStats.initial();
      expect(stats.winRate, 0.0);
      expect(stats.totalTrades, 0);
      expect(stats.successfulTrades, 0);
    });
  });

  group('BotType Extension', () {
    test('should provide correct display names', () {
      expect(BotType.ethEnthusiast.displayName, 'ETH Enthusiast');
      expect(BotType.btcMaximalist.displayName, 'BTC Maximalist');
      expect(BotType.avaxAdventurer.displayName, 'AVAX Adventurer');
      expect(BotType.memeCoinManiac.displayName, 'Meme Coin Maniac');
      expect(BotType.stablecoinSage.displayName, 'Stablecoin Sage');
    });

    test('should provide correct markets', () {
      expect(BotType.ethEnthusiast.market, 'ETH-USD');
      expect(BotType.btcMaximalist.market, 'BTC-USD');
      expect(BotType.avaxAdventurer.market, 'AVAX-USD');
      expect(BotType.memeCoinManiac.market, 'DOGE-USD');
      expect(BotType.stablecoinSage.market, 'USDC-USD');
    });

    test('should provide reasonable base costs', () {
      expect(BotType.ethEnthusiast.baseCost, 1000.0);
      expect(BotType.btcMaximalist.baseCost, 2500.0);
      expect(BotType.stablecoinSage.baseCost, 500.0);
      expect(BotType.memeCoinManiac.baseCost, 5000.0);
    });
  });

  group('JSON Serialization', () {
    test('should serialize and deserialize GameState correctly', () {
      final original = GameState.initial();
      final json = original.toJson();
      final deserialized = GameState.fromJson(json);
      
      expect(deserialized.vaultCash, original.vaultCash);
      expect(deserialized.starkTokens, original.starkTokens);
      expect(deserialized.prestigeLevel, original.prestigeLevel);
      expect(deserialized.ownedBots.length, original.ownedBots.length);
      expect(deserialized.ownedUpgrades.length, original.ownedUpgrades.length);
    });

    test('should serialize and deserialize TradingBot correctly', () {
      final original = TradingBot(
        id: 'test',
        type: BotType.ethEnthusiast,
        name: 'Test Bot',
        market: 'ETH-USD',
        baseProfitPerHour: 100.0,
        speed: 1.0,
        level: 1,
        hiredAt: DateTime.now(),
      );
      
      final json = original.toJson();
      final deserialized = TradingBot.fromJson(json);
      
      expect(deserialized.id, original.id);
      expect(deserialized.type, original.type);
      expect(deserialized.name, original.name);
      expect(deserialized.market, original.market);
      expect(deserialized.baseProfitPerHour, original.baseProfitPerHour);
      expect(deserialized.level, original.level);
    });
  });
}