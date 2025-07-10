import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../lib/providers/game_state_provider.dart';
import '../../lib/providers/xp_provider.dart';
import '../../lib/models/game_models.dart';

void main() {
  group('Basic Provider Integration Tests', () {
    test('Game state provider should work correctly', () {
      final container = ProviderContainer();
      
      final gameState = container.read(gameStateProvider);
      
      expect(gameState.vaultCash, greaterThanOrEqualTo(0));
      expect(gameState.starkTokens, greaterThanOrEqualTo(0));
      expect(gameState.prestigeLevel, greaterThanOrEqualTo(0));
      expect(gameState.ownedBots, isNotNull);
      expect(gameState.ownedUpgrades, isNotNull);
      expect(gameState.achievements, isNotNull);
      expect(gameState.stats, isNotNull);
      
      container.dispose();
    });

    test('Game state should support copyWith operations', () {
      final container = ProviderContainer();
      
      final initialState = container.read(gameStateProvider);
      final newCash = initialState.vaultCash + 1000;
      
      final updatedState = initialState.copyWith(vaultCash: newCash);
      
      expect(updatedState.vaultCash, newCash);
      expect(updatedState.starkTokens, initialState.starkTokens);
      expect(updatedState.prestigeLevel, initialState.prestigeLevel);
      
      container.dispose();
    });

    test('Bot creation and earnings calculation should work', () {
      final bot = TradingBot(
        id: 'test-bot',
        type: BotType.ethEnthusiast,
        name: 'Test ETH Bot',
        market: 'ETH-USD',
        baseProfitPerHour: 3600, // 1 per second base
        speed: 1.0,
        level: 1,
        hiredAt: DateTime.now(),
      );
      
      expect(bot.earningsPerSecond, greaterThan(0));
      expect(bot.upgradeCost, greaterThan(0));
      expect(bot.type, BotType.ethEnthusiast);
      expect(bot.market, 'ETH-USD');
    });

    test('Game stats should calculate correctly', () {
      final stats = GameStats(
        totalTrades: 10,
        successfulTrades: 6,
        totalPnL: 500.0,
        maxSingleProfit: 100.0,
        maxSingleLoss: 50.0,
        totalXPGained: 60,
        totalPlayTime: Duration(hours: 1),
        prestigeCount: 0,
      );
      
      expect(stats.winRate, 0.6);
      expect(stats.totalTrades, 10);
      expect(stats.successfulTrades, 6);
      expect(stats.totalPnL, 500.0);
    });

    test('Upgrade type extensions should work', () {
      expect(UpgradeType.winRate.displayName, 'Win Rate');
      expect(UpgradeType.pnlBoost.displayName, 'Profit Multiplier');
      expect(UpgradeType.speed.displayName, 'Trading Speed');
      expect(UpgradeType.cosmetic.displayName, 'Cosmetic');
      
      expect(UpgradeType.winRate.description, isNotEmpty);
      expect(UpgradeType.pnlBoost.description, isNotEmpty);
    });

    test('Bot type extensions should provide consistent data', () {
      for (final botType in BotType.values) {
        expect(botType.displayName, isNotEmpty);
        expect(botType.emoji, isNotEmpty);
        expect(botType.market, isNotEmpty);
        expect(botType.baseCost, greaterThan(0));
        expect(botType.baseProfitPerHour, greaterThan(0));
      }
    });
  });
}