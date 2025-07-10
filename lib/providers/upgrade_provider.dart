/// Trading upgrade provider for Perp Tycoon casino game
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import '../models/game_models.dart';
import 'game_state_provider.dart';

/// Provider for available upgrades
final upgradeProvider = StateNotifierProvider<UpgradeNotifier, List<UpgradeDefinition>>((ref) {
  return UpgradeNotifier();
});

/// Provider for owned upgrades
final ownedUpgradesProvider = StateProvider<List<Upgrade>>((ref) {
  final gameState = ref.watch(gameStateProvider);
  return gameState.ownedUpgrades;
});

/// Predefined upgrade definitions
class UpgradeDefinition {
  final String id;
  final UpgradeType type;
  final String name;
  final String description;
  final double baseCost;
  final double effect;
  final int maxLevel;
  final String category;
  final String emoji;

  UpgradeDefinition({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.baseCost,
    required this.effect,
    required this.maxLevel,
    required this.category,
    required this.emoji,
  });

  /// Calculate cost for specific level
  double getCostForLevel(int level) {
    if (level >= maxLevel) return double.infinity;
    return baseCost * (level + 1) * (level + 1); // Quadratic scaling
  }
}

/// Upgrade notifier that manages available upgrades
class UpgradeNotifier extends StateNotifier<List<UpgradeDefinition>> {
  UpgradeNotifier() : super(_getInitialUpgrades());

  /// Get initial upgrade definitions
  static List<UpgradeDefinition> _getInitialUpgrades() {
    return [
      // Market Access Upgrades
      UpgradeDefinition(
        id: 'unlock_eth',
        type: UpgradeType.cosmetic,
        name: 'Unlock ETH',
        description: 'Access to Ethereum trading',
        baseCost: 2000.0,
        effect: 0.0,
        maxLevel: 1,
        category: 'Market Access',
        emoji: '🔷',
      ),
      UpgradeDefinition(
        id: 'unlock_strk',
        type: UpgradeType.cosmetic,
        name: 'Unlock STRK',
        description: 'Access to Starknet token trading',
        baseCost: 3500.0,
        effect: 0.0,
        maxLevel: 1,
        category: 'Market Access',
        emoji: '⭐',
      ),
      UpgradeDefinition(
        id: 'unlock_meme',
        type: UpgradeType.cosmetic,
        name: 'Unlock Meme Coins',
        description: 'Access to various meme coin markets',
        baseCost: 5000.0,
        effect: 0.0,
        maxLevel: 1,
        category: 'Market Access',
        emoji: '🐕',
      ),

      // Trade Power Upgrades
      UpgradeDefinition(
        id: 'leverage_2x',
        type: UpgradeType.pnlBoost,
        name: 'Leverage 2x',
        description: 'Double profit/loss potential',
        baseCost: 2000.0,
        effect: 1.0, // 100% increase (2x total)
        maxLevel: 1,
        category: 'Trade Power',
        emoji: '📈',
      ),
      UpgradeDefinition(
        id: 'leverage_5x',
        type: UpgradeType.pnlBoost,
        name: 'Leverage 5x',
        description: '5x profit/loss potential',
        baseCost: 10000.0,
        effect: 4.0, // 400% increase (5x total)
        maxLevel: 1,
        category: 'Trade Power',
        emoji: '🚀',
      ),
      UpgradeDefinition(
        id: 'leverage_10x',
        type: UpgradeType.pnlBoost,
        name: 'Leverage 10x',
        description: '10x profit/loss potential',
        baseCost: 50000.0,
        effect: 9.0, // 900% increase (10x total)
        maxLevel: 1,
        category: 'Trade Power',
        emoji: '💥',
      ),
      UpgradeDefinition(
        id: 'quantum_charts',
        type: UpgradeType.pnlBoost,
        name: 'Quantum Charts',
        description: 'Increases maximum profit on winning trades by +10%',
        baseCost: 5000.0,
        effect: 0.1, // 10% increase
        maxLevel: 5,
        category: 'Trade Power',
        emoji: '📊',
      ),

      // Efficiency & Automation
      UpgradeDefinition(
        id: 'market_intel',
        type: UpgradeType.winRate,
        name: 'Market Intel Feed',
        description: 'Increases base probability of winning trades by +3%',
        baseCost: 7500.0,
        effect: 0.03, // 3% increase
        maxLevel: 10,
        category: 'Efficiency',
        emoji: '📡',
      ),
      UpgradeDefinition(
        id: 'flash_execution',
        type: UpgradeType.speed,
        name: 'Flash Execution',
        description: 'Increases trade speed of automated bots by +1 tap/sec',
        baseCost: 1500.0,
        effect: 1.0, // 1 extra tap per second
        maxLevel: 10,
        category: 'Efficiency',
        emoji: '⚡',
      ),
      UpgradeDefinition(
        id: 'lightning_speed',
        type: UpgradeType.speed,
        name: 'Lightning Speed',
        description: 'Reduces trade execution time by 1 second',
        baseCost: 7500.0,
        effect: 1.0, // 1 second reduction
        maxLevel: 3,
        category: 'Efficiency',
        emoji: '🌩️',
      ),

      // Cosmetic Upgrades
      UpgradeDefinition(
        id: 'neon_lights',
        type: UpgradeType.cosmetic,
        name: 'Neon Lights',
        description: 'Casino floor lighting effects',
        baseCost: 3000.0,
        effect: 0.0,
        maxLevel: 1,
        category: 'Cosmetic',
        emoji: '💡',
      ),
      UpgradeDefinition(
        id: 'vip_area',
        type: UpgradeType.cosmetic,
        name: 'VIP Area',
        description: 'Exclusive trading section',
        baseCost: 15000.0,
        effect: 0.0,
        maxLevel: 1,
        category: 'Cosmetic',
        emoji: '👑',
      ),
      UpgradeDefinition(
        id: 'diamond_buttons',
        type: UpgradeType.cosmetic,
        name: 'Diamond Buttons',
        description: 'Premium tap button appearance',
        baseCost: 25000.0,
        effect: 0.0,
        maxLevel: 1,
        category: 'Cosmetic',
        emoji: '💎',
      ),
    ];
  }

  /// Get upgrades by category
  List<UpgradeDefinition> getUpgradesByCategory(String category) {
    return state.where((upgrade) => upgrade.category == category).toList();
  }

  /// Get all categories
  List<String> get categories {
    return state.map((upgrade) => upgrade.category).toSet().toList();
  }
}

/// Upgrade service for handling purchases and management
class UpgradeService {
  static final UpgradeService _instance = UpgradeService._internal();
  factory UpgradeService() => _instance;
  UpgradeService._internal();

  /// Purchase an upgrade
  Future<bool> purchaseUpgrade(
    WidgetRef ref,
    UpgradeDefinition upgradeDef,
  ) async {
    final gameStateNotifier = ref.read(gameStateProvider.notifier);
    final currentUpgrades = ref.read(gameStateProvider).ownedUpgrades;
    
    // Check if upgrade already owned and at max level
    final existingUpgrade = currentUpgrades.firstWhere(
      (u) => u.id == upgradeDef.id,
      orElse: () => Upgrade(
        id: upgradeDef.id,
        type: upgradeDef.type,
        name: upgradeDef.name,
        description: upgradeDef.description,
        cost: 0,
        effect: 0,
        level: 0,
        purchasedAt: DateTime.now(),
      ),
    );
    
    final nextLevel = existingUpgrade.level + 1;
    final cost = upgradeDef.getCostForLevel(existingUpgrade.level);
    
    // Check if can afford and not at max level
    if (nextLevel > upgradeDef.maxLevel || !gameStateNotifier.canAfford(cost)) {
      return false;
    }
    
    // Purchase upgrade
    if (gameStateNotifier.spendCash(cost)) {
      final newUpgrade = Upgrade(
        id: upgradeDef.id,
        type: upgradeDef.type,
        name: upgradeDef.name,
        description: upgradeDef.description,
        cost: cost,
        effect: upgradeDef.effect,
        level: nextLevel,
        purchasedAt: DateTime.now(),
      );
      
      // Update owned upgrades
      final updatedUpgrades = [...currentUpgrades];
      final existingIndex = updatedUpgrades.indexWhere((u) => u.id == upgradeDef.id);
      
      if (existingIndex >= 0) {
        updatedUpgrades[existingIndex] = newUpgrade;
      } else {
        updatedUpgrades.add(newUpgrade);
      }
      
      // Update game state
      final currentState = ref.read(gameStateProvider);
      ref.read(gameStateProvider.notifier).state = currentState.copyWith(
        ownedUpgrades: updatedUpgrades,
        lastSaveTime: DateTime.now(),
      );
      
      return true;
    }
    
    return false;
  }

  /// Get current level of an upgrade
  int getUpgradeLevel(List<Upgrade> ownedUpgrades, String upgradeId) {
    final upgrade = ownedUpgrades.firstWhere(
      (u) => u.id == upgradeId,
      orElse: () => Upgrade(
        id: upgradeId,
        type: UpgradeType.winRate,
        name: '',
        description: '',
        cost: 0,
        effect: 0,
        level: 0,
        purchasedAt: DateTime.now(),
      ),
    );
    return upgrade.level;
  }

  /// Check if upgrade is owned
  bool isUpgradeOwned(List<Upgrade> ownedUpgrades, String upgradeId) {
    return ownedUpgrades.any((u) => u.id == upgradeId && u.level > 0);
  }

  /// Get total multiplier for an upgrade type
  double getTotalMultiplier(List<Upgrade> ownedUpgrades, UpgradeType type) {
    double total = 1.0;
    for (final upgrade in ownedUpgrades) {
      if (upgrade.type == type) {
        total += upgrade.effect;
      }
    }
    return total;
  }

  /// Get upgrade cost for next level
  double getUpgradeCost(UpgradeDefinition upgradeDef, int currentLevel) {
    return upgradeDef.getCostForLevel(currentLevel);
  }

  /// Check if upgrade can be purchased
  bool canPurchaseUpgrade(
    UpgradeDefinition upgradeDef,
    List<Upgrade> ownedUpgrades,
    double availableCash,
  ) {
    final currentLevel = getUpgradeLevel(ownedUpgrades, upgradeDef.id);
    final cost = upgradeDef.getCostForLevel(currentLevel);
    
    return currentLevel < upgradeDef.maxLevel && availableCash >= cost;
  }
}

/// Provider for upgrade service
final upgradeServiceProvider = Provider((ref) => UpgradeService());