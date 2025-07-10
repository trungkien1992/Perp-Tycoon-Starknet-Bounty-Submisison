/// Upgrade shop screen for Perp Tycoon casino game
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/game_state_provider.dart';
import '../providers/upgrade_provider.dart';

class UpgradeShopScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    final availableUpgrades = ref.watch(upgradeProvider);
    final upgradeService = ref.read(upgradeServiceProvider);
    
    // Group upgrades by category
    final categories = availableUpgrades
        .map((upgrade) => upgrade.category)
        .toSet()
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '🛒 UPGRADE SHOP',
          style: TextStyle(
            color: Color(0xFF00FF41),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          // Cash display
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.account_balance, color: Color(0xFFFFD700), size: 16),
                SizedBox(width: 4),
                Text(
                  '\$${gameState.vaultCash.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0A1A),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Shop header
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFF00FF41).withOpacity(0.6)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '⚡ TRADING UPGRADES',
                        style: TextStyle(
                          color: Color(0xFF00FF41),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Enhance your trading power with specialized upgrades',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Categories tabs
                Container(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Chip(
                          label: Text(
                            category,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Color(0xFF00FF41).withOpacity(0.2),
                          side: BorderSide(color: Color(0xFF00FF41)),
                        ),
                      );
                    },
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Upgrades list
                Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, categoryIndex) {
                      final category = categories[categoryIndex];
                      final categoryUpgrades = availableUpgrades
                          .where((upgrade) => upgrade.category == category)
                          .toList();
                      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category header
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: Color(0xFF00FFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          
                          // Category upgrades
                          ...categoryUpgrades.map((upgrade) {
                            final currentLevel = upgradeService.getUpgradeLevel(
                              gameState.ownedUpgrades, 
                              upgrade.id,
                            );
                            final cost = upgradeService.getUpgradeCost(upgrade, currentLevel);
                            final canAfford = upgradeService.canPurchaseUpgrade(
                              upgrade, 
                              gameState.ownedUpgrades, 
                              gameState.vaultCash,
                            );
                            final isMaxLevel = currentLevel >= upgrade.maxLevel;
                            
                            return _buildUpgradeCard(
                              context,
                              ref,
                              upgrade,
                              currentLevel,
                              cost,
                              canAfford,
                              isMaxLevel,
                            );
                          }).toList(),
                          
                          SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpgradeCard(
    BuildContext context,
    WidgetRef ref,
    UpgradeDefinition upgrade,
    int currentLevel,
    double cost,
    bool canAfford,
    bool isMaxLevel,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: canAfford && !isMaxLevel 
              ? Color(0xFF00FF41).withOpacity(0.6)
              : Colors.white.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Text(
                upgrade.emoji,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      upgrade.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      upgrade.description,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Level indicator
              if (currentLevel > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF00FF41).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Lv. $currentLevel',
                    style: TextStyle(
                      color: Color(0xFF00FF41),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          
          SizedBox(height: 12),
          
          // Progress bar for multi-level upgrades
          if (upgrade.maxLevel > 1) ...[
            Row(
              children: [
                Text(
                  'Progress: ',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Expanded(
                  child: LinearProgressIndicator(
                    value: currentLevel / upgrade.maxLevel,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation(Color(0xFF00FF41)),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '$currentLevel/${upgrade.maxLevel}',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 12),
          ],
          
          // Buy button
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: isMaxLevel ? null : (canAfford ? () {
                    _purchaseUpgrade(context, ref, upgrade);
                  } : null),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isMaxLevel 
                        ? Colors.grey.withOpacity(0.3)
                        : (canAfford ? Color(0xFF00FF41) : Colors.red.withOpacity(0.3)),
                    foregroundColor: isMaxLevel 
                        ? Colors.white54
                        : (canAfford ? Colors.black : Colors.white54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isMaxLevel 
                        ? 'MAX LEVEL'
                        : (canAfford 
                            ? 'BUY - \$${cost.toStringAsFixed(0)}'
                            : 'NEED \$${cost.toStringAsFixed(0)}'),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _purchaseUpgrade(BuildContext context, WidgetRef ref, UpgradeDefinition upgrade) async {
    final upgradeService = ref.read(upgradeServiceProvider);
    
    HapticFeedback.mediumImpact();
    
    final success = await upgradeService.purchaseUpgrade(ref, upgrade);
    
    if (success) {
      HapticFeedback.heavyImpact();
      
      // Show success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Text(upgrade.emoji, style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Text('${upgrade.name} upgraded!'),
            ],
          ),
          backgroundColor: Color(0xFF00FF41),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      HapticFeedback.lightImpact();
      
      // Show error feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Not enough cash!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}