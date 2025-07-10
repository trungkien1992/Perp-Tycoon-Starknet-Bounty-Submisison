# Perp Tycoon - Casino Idle Game Knowledge Base

## 🎮 Game Mechanics Knowledge Repository

This knowledge base contains all the essential information about Perp Tycoon's casino idle game mechanics, formulas, and implementation patterns.

## 🧠 Core Game Knowledge

### **Idle Game Theory**
Perp Tycoon follows proven idle game principles:
- **Exponential Growth** - Each upgrade provides meaningful but balanced progression
- **Offline Progress** - Players earn while away, creating return incentive  
- **Prestige Systems** - Reset mechanics provide long-term progression goals
- **Multiple Currencies** - Cash, XP, and Stark Tokens create layered progression

### **Trading Simulation Science**
- **Volatility-Based Outcomes** - Real market data drives realistic trade results
- **Risk/Reward Balance** - Higher volatility markets = greater potential returns
- **Fair Probability** - Win rates clearly displayed and mathematically enforced
- **Progressive Difficulty** - Later upgrades require exponentially more resources

## 🎰 Casino Game Mechanics

### **Tap-to-Trade System**
```dart
// Core formula for trade simulation
bool isWin = Random().nextDouble() < baseWinRate + upgradeBonus;
double pnl = (isWin ? 1 : -1) * volatility * multiplier * leverage;
```

**Key Variables**:
- `baseWinRate`: Starting probability (typically 45-55%)
- `upgradeBonus`: Purchased improvements to win rate (+1-5% per upgrade)
- `volatility`: Real market volatility percentage (0.01-0.20)
- `multiplier`: Profit multiplier from upgrades (1.0-10.0x)
- `leverage`: Simulated leverage level (1x-100x)

### **Bot Automation System**
```dart
// Idle earnings calculation
double calculateOfflineEarnings(Duration timeOffline) {
  return bots.fold(0.0, (total, bot) => 
    total + (bot.earningsPerSecond * timeOffline.inSeconds * bot.efficiency));
}
```

**Bot Types & Specializations**:
- **ETH Bot**: Stable earnings, moderate volatility
- **BTC Bot**: High volatility, bigger swings
- **MEME Bot**: Extreme volatility, highest risk/reward
- **STRK Bot**: Medium volatility, blockchain-themed
- **Stable Bot**: Low volatility, consistent small returns

### **Upgrade Economics**
```dart
// Exponential cost scaling
double calculateUpgradeCost(int currentLevel) {
  return baseCost * pow(1.15, currentLevel);
}

// Upgrade effect calculation
double calculateUpgradeBonus(int level, UpgradeType type) {
  switch (type) {
    case UpgradeType.WinRate: return level * 0.01; // +1% per level
    case UpgradeType.PnLBoost: return level * 0.1;  // +10% per level
    case UpgradeType.Speed: return level * 0.05;    // +5% speed per level
  }
}
```

### **Prestige Mathematics**
```dart
// Stark Token rewards calculation
int calculateStarkTokens(double totalEarnings, int currentPrestige) {
  double baseTokens = sqrt(totalEarnings / 1000000); // 1M cash = 1 token base
  return (baseTokens * (1 + currentPrestige * 0.1)).floor();
}

// Prestige bonus application
double applyPrestigeBonus(double baseValue, int starkTokens) {
  return baseValue * (1 + starkTokens * 0.05); // +5% per Stark Token
}
```

## 📊 Game Balance Knowledge

### **Progression Curve Design**
- **Early Game (0-10 minutes)**: Fast progression, immediate satisfaction
- **Mid Game (10-60 minutes)**: Steady growth, first bot unlocks
- **Late Game (1+ hours)**: Exponential scaling, prestige consideration
- **Endgame (multiple prestiges)**: Stark Token accumulation, leaderboard competition

### **Resource Scaling**
```
Level 1 Upgrade: $100
Level 2 Upgrade: $115
Level 3 Upgrade: $132
Level 10 Upgrade: $405
Level 20 Upgrade: $1,637
```

### **Bot Efficiency Standards**
- **Tier 1 Bot**: $0.10/second base rate
- **Tier 2 Bot**: $0.50/second base rate  
- **Tier 3 Bot**: $2.50/second base rate
- **Premium Bot**: $10.00/second base rate

## 🎨 UX/UI Knowledge

### **Animation Timing Standards**
- **Slot Machine Spin**: 1.5 seconds total duration
- **PnL Reveal**: 0.5 seconds after spin complete
- **Coin Shower**: 2.0 seconds for win celebration
- **XP Bar Fill**: 0.3 seconds smooth interpolation

### **Haptic Feedback Patterns**
```dart
// Different haptic responses for different events
void triggerHaptic(GameEvent event) {
  switch (event) {
    case GameEvent.tapTrade: HapticFeedback.lightImpact();
    case GameEvent.bigWin: HapticFeedback.heavyImpact();
    case GameEvent.levelUp: HapticFeedback.mediumImpact();
    case GameEvent.purchase: HapticFeedback.selectionClick();
  }
}
```

### **Visual Feedback Guidelines**
- **Green Effects**: Profits, wins, positive outcomes
- **Red Effects**: Losses, failures, negative outcomes  
- **Gold Effects**: Level ups, achievements, special events
- **Purple Effects**: Prestige, Stark Tokens, rare rewards

## 🔧 Technical Implementation Knowledge

### **Performance Optimization**
- **60fps Target**: All animations must maintain smooth frame rates
- **Memory Efficiency**: Bot calculations should not create memory leaks
- **Battery Optimization**: Minimize background processing when app inactive
- **Startup Speed**: Game state should load in <2 seconds

### **SQLite Database Schema**
```sql
-- Core game state table
CREATE TABLE game_state (
  id INTEGER PRIMARY KEY,
  cash REAL NOT NULL,
  xp INTEGER NOT NULL,
  level INTEGER NOT NULL,
  stark_tokens INTEGER DEFAULT 0,
  prestige_count INTEGER DEFAULT 0,
  last_login TIMESTAMP
);

-- Trading bots table
CREATE TABLE trading_bots (
  id INTEGER PRIMARY KEY,
  bot_type TEXT NOT NULL,
  level INTEGER DEFAULT 1,
  earnings_per_second REAL NOT NULL,
  purchase_date TIMESTAMP
);

-- Upgrades table
CREATE TABLE upgrades (
  id INTEGER PRIMARY KEY,
  upgrade_type TEXT NOT NULL,
  level INTEGER DEFAULT 0,
  total_cost REAL DEFAULT 0
);
```

### **Real Trading Integration**
- **Daily Limit**: Strict 1 real trade per 24 hours
- **Position Sizing**: Maximum 10% of available balance
- **Risk Management**: Automatic stop-loss at 50% position value
- **Error Handling**: Graceful fallback to simulation mode on API failures

## 🎯 Game Balance Formulas

### **XP Progression**
```dart
// XP required for next level
int xpForLevel(int level) {
  return (100 * pow(1.2, level - 1)).round();
}

// XP gained from activities
int calculateXPGain(TradeResult result) {
  int baseXP = result.isWin ? 10 : 5;
  int multiplier = result.isRealTrade ? 5 : 1;
  return baseXP * multiplier;
}
```

### **Market Volatility Integration**
```dart
// Convert real market volatility to game multiplier
double volatilityToMultiplier(double marketVolatility) {
  // Clamp volatility between 1% and 20%
  double clampedVol = marketVolatility.clamp(0.01, 0.20);
  
  // Scale to game-appropriate range (0.5x to 3.0x)
  return 0.5 + (clampedVol / 0.20) * 2.5;
}
```

## 🧪 Testing & Validation Knowledge

### **Game Balance Testing**
- **Progression Validation**: Players should reach first bot in 5-10 minutes
- **Idle Efficiency**: Offline earnings should match 70% of active play
- **Prestige Timing**: First prestige should occur after 2-4 hours
- **Retention Targets**: 50% Day 1, 20% Day 7, 10% Day 30

### **Mathematical Verification**
```dart
// Verify upgrade cost scaling doesn't break economy
void validateUpgradeEconomy() {
  for (int level = 1; level <= 50; level++) {
    double cost = calculateUpgradeCost(level);
    double benefit = calculateUpgradeBonus(level);
    double roi = benefit / cost;
    
    assert(roi > 0.01); // ROI should always be positive
    assert(cost < 1e12); // Prevent overflow scenarios
  }
}
```

## 🌐 Social & Viral Mechanics

### **Leaderboard Categories**
- **Net Worth**: Total cash accumulated across all prestiges
- **XP Ranking**: Lifetime experience points earned
- **Prestige Count**: Number of successful resets completed
- **Real Trade Profit**: Performance on actual trades
- **Achievement Score**: NFT collection completeness

### **Sharing Templates**
```dart
// Generate shareable achievement text
String generateShareText(Achievement achievement) {
  return "Just ${achievement.action} in Perp Tycoon! "
         "${achievement.description} "
         "💰 Current worth: \${formatCurrency(currentWorth)} "
         "#PerpTycoon #CryptoGaming";
}
```

## 🚀 Deployment & Analytics Knowledge

### **Key Performance Indicators**
- **ARPU**: Average Revenue Per User (future monetization)
- **LTV**: Lifetime Value based on engagement patterns
- **Viral K-Factor**: User-to-user referral effectiveness
- **Retention Cohorts**: Weekly retention tracking

### **A/B Testing Framework**
- **Game Balance**: Test different progression curves
- **UI Elements**: Compare button placements and colors
- **Reward Systems**: Optimize reward frequencies and amounts
- **Social Features**: Test sharing mechanics effectiveness

---

**Knowledge Base Version**: 1.0  
**Game Type**: Casino Idle Game  
**Last Updated**: 2025-01-10  
**Next Review**: After Phase 1 implementation