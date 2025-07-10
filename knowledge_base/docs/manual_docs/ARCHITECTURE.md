# Perp Tycoon - Casino Idle Game Architecture

## 🏗️ High-Level Architecture

Perp Tycoon is an **idle casino trading game** that transforms leveraged trading into an addictive mobile gaming experience. The architecture combines proven idle game mechanics with real blockchain trading integration.

### 🎮 Game Architecture Overview
```
┌─────────────────────────────────────────────────────────────────┐
│                    Perp Tycoon - Casino Game                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────┐  │
│  │                 │    │                 │    │             │  │
│  │   Casino Floor  │◄──►│   Trading Bots  │◄──►│ Real Trades │  │
│  │ (Tap-to-Trade)  │    │ (Idle Earnings) │    │ (1/day Max) │  │
│  │                 │    │                 │    │             │  │
│  └─────────────────┘    └─────────────────┘    └─────────────┘  │
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────┐  │
│  │                 │    │                 │    │             │  │
│  │  Upgrade Shop   │◄──►│ Prestige System │◄──►│ Blockchain  │  │
│  │ (Multipliers)   │    │ (Stark Tokens)  │    │ (XP + NFTs) │  │
│  │                 │    │                 │    │             │  │
│  └─────────────────┘    └─────────────────┘    └─────────────┘  │
│                                                                 │
│  Core Loop: Tap → Earn → Upgrade → Automate → Prestige         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 🛠️ Technical Infrastructure
```
┌─────────────────────────────────────────────────────────────────┐
│                 Existing Infrastructure (100% Ready)           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────┐  │
│  │                 │    │                 │    │             │  │
│  │   Flutter App   │◄──►│ Smart Contracts │◄──►│  Extended   │  │
│  │ (Game Frontend) │    │ (XP + NFTs)     │    │  Exchange   │  │
│  │                 │    │                 │    │ (Real API)  │  │
│  └─────────────────┘    └─────────────────┘    └─────────────┘  │
│                                                                 │
│  Ready: Blockchain • Trading API • Gasless Transactions        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 🎯 Core Game Components

### 1. Casino Floor System (`/lib/screens/casino_floor_screen.dart`)

**Primary responsibility**: Main game interaction loop with tap-to-trade mechanics

**Game mechanics**:
- **Tap-to-Trade**: Each tap simulates a leveraged trade (long/short coin flip)
- **Slot Machine UI**: Visual slot reels with crypto symbols
- **PnL Animations**: Coin showers for wins, glitch effects for losses
- **Real-time Volatility**: Uses actual market data for realistic outcomes
- **XP Progression**: Visual XP bar with level-up celebrations

**Architecture pattern**: Real-time reactive UI with immediate feedback
```dart
// Game loop flow
Tap Input → Volatility Calculation → Trade Simulation → PnL Result → UI Animation
     ↖                                                              ↙
       XP Update → Level Progression → Unlock Checks
```

### 2. Trading Bot System (`/lib/providers/bot_provider.dart`)

**Primary responsibility**: Automated idle earnings while offline

**Bot mechanics**:
- **Market Specialization**: Each bot trades specific markets (ETH, BTC, MEME, etc.)
- **Profit Calculation**: `earnings = Σ(botYields * timeElapsed)`
- **Upgrade System**: Bots can be upgraded for speed, accuracy, profit multipliers
- **Visual Representation**: Each bot has unique avatars and animations

**Architecture pattern**: Stream-based periodic execution
```dart
// Bot automation flow
Stream.periodic() → Market Volatility Check → Simulated Trade → Earnings Update
     ↖                                                                ↙
       SQLite Persistence ← Offline Calculation ← Time Delta
```

### 3. Upgrade Shop System (`/lib/screens/upgrade_shop_screen.dart`)

**Primary responsibility**: Player progression through purchased improvements

**Upgrade categories**:
- **Win Rate Boosts**: Increase probability of successful trades
- **PnL Multipliers**: Amplify profit from successful trades
- **Speed Enhancements**: Faster bot trading intervals
- **Cosmetic Upgrades**: Visual casino floor improvements

**Architecture pattern**: Purchase validation with immediate effect application
```dart
// Upgrade flow
Purchase Request → Cost Validation → SQLite Update → Provider Refresh → UI Update
```

### 4. Prestige System (`/lib/providers/prestige_provider.dart`)

**Primary responsibility**: Reset progression for permanent benefits

**Prestige mechanics**:
- **Trigger Conditions**: Reach specific cash/XP milestones
- **Stark Token Rewards**: On-chain NFT tokens for permanent benefits
- **Progress Reset**: Wipe cash, bots, upgrades (keep Stark Tokens)
- **Multiplier Bonuses**: Permanent improvements based on Stark Token count

**Architecture pattern**: Blockchain integration with local state management
```dart
// Prestige flow
Milestone Check → Confirmation UI → Stark Token Mint → State Reset → Bonus Application
```

## 🔄 Game Data Flow Architecture

### Core Game Loop (Tap-to-Trade)
```
1. User taps trade button → 2. Volatility data fetch → 3. Win/loss calculation
                                     ↓                        ↓
6. UI animations trigger ← 5. XP/cash update ← 4. PnL determination
                                     ↓
7. Achievement checks → 8. Level progression → 9. Unlock validation
```

### Idle Earnings Loop (Bots)
```
1. App minimized → 2. Timestamp saved → 3. Background calculation
                                                ↓
8. Welcome back screen ← 7. UI update ← 6. Earnings distribution ← 5. Bot simulation
        ↓
4. Time delta calculation → Bot performance → Market volatility
```

### Real Trading Integration (Daily Limit)
```
1. "Real Trade" button → 2. Daily limit check → 3. Confirmation dialog
                                     ↓                ↓
8. NFT reward trigger ← 7. Result display ← 6. Extended Exchange API ← 4. Order placement
        ↓
5. Gasless transaction (AVNU Paymaster)
```

## 🧩 Component Interactions

### Game State Management
- **Local Storage**: SQLite for game progress, bot ownership, upgrade purchases
- **Blockchain Sync**: Periodic XP and achievement sync to smart contracts
- **Real-time Updates**: Immediate UI feedback for all player actions
- **Offline Persistence**: Complete game state preservation during app closure

### Trading Simulation Engine
- **Volatility Integration**: Real market data drives simulated trade outcomes
- **Risk/Reward Balance**: Higher volatility markets = higher potential returns
- **Player Choice**: Toggle between safe stable coins vs volatile assets
- **Realistic Outcomes**: Trade results feel authentic while maintaining fun

### Social Integration
- **Global Leaderboards**: Rankings by net worth, XP, trading performance
- **Achievement Sharing**: Export progress screenshots to social media
- **Daily Events**: Volatility surges, bonus periods, community challenges
- **Friend Systems**: Connect and compete with other players

## 🎮 Game-Specific Architecture Patterns

### Idle Game Loop Pattern
```dart
class IdleGameManager {
  // Core idle calculation
  double calculateOfflineEarnings(Duration timeOffline) {
    return bots.fold(0.0, (total, bot) => 
      total + (bot.earningsPerSecond * timeOffline.inSeconds));
  }
  
  // Welcome back experience
  void showWelcomeBackScreen(double earnings) {
    // Dramatic earnings reveal with animations
  }
}
```

### Tap Feedback Pattern
```dart
class TapTradeHandler {
  Future<TradeResult> executeTapTrade() {
    final volatility = await getMarketVolatility();
    final result = simulateTradeOutcome(volatility);
    
    // Immediate UI feedback
    triggerHapticFeedback();
    showSlotMachineAnimation();
    displayPnLBurst(result);
    updateXPProgress(result.xpGained);
    
    return result;
  }
}
```

### Progressive Upgrade Pattern
```dart
class UpgradeSystem {
  // Purchase validation with immediate effects
  bool purchaseUpgrade(UpgradeType type) {
    if (canAfford(type)) {
      deductCost(type);
      applyUpgradeEffects(type);
      saveToDatabase(type);
      triggerSuccessAnimation();
      return true;
    }
    return false;
  }
}
```

## 🔐 Security & Fairness Architecture

### Trade Simulation Integrity
- **Deterministic Outcomes**: Random seed based on market volatility + timestamp
- **Fair Probability**: Win rates clearly displayed and mathematically enforced
- **No Hidden Manipulation**: All upgrade effects transparently applied
- **Audit Trail**: Complete log of all simulated trades for analysis

### Real Trading Safety
- **Daily Limits**: Strict 1 real trade per day maximum
- **Amount Limits**: Small position sizes to minimize risk
- **Confirmation Gates**: Multiple confirmation steps for real trades
- **Error Handling**: Comprehensive failure recovery for real API calls

### Data Protection
- **Local First**: Game progress stored locally, not transmitted
- **Blockchain Minimal**: Only XP milestones and achievements on-chain
- **API Security**: Secure signature-based authentication for real trades
- **Privacy**: No personal data collection beyond wallet addresses

## 🚀 Performance Architecture

### Game Performance Optimization
- **60fps Target**: Smooth animations throughout all game interactions
- **Memory Efficiency**: Efficient bot simulation without memory leaks
- **Battery Optimization**: Minimal background processing when app inactive
- **Startup Speed**: Fast app launch with cached game state

### Animation Performance
- **Lottie/Rive**: Hardware-accelerated animations for slot machines
- **Particle Effects**: Efficient coin shower and explosion animations
- **Haptic Feedback**: Precise haptic patterns for different game events
- **Sound Design**: Layered audio for immersive casino atmosphere

## 🔧 Development Architecture

### Game Development Phases
1. **Phase 1**: Core game loop with tap-to-trade mechanics
2. **Phase 2**: Bot system and idle earnings implementation
3. **Phase 3**: Real trading integration and blockchain features
4. **Phase 4**: Social features and viral mechanics

### Testing Strategy
- **Game Balance**: Mathematical validation of upgrade costs and benefits
- **Idle Calculations**: Verification of offline earnings accuracy
- **Real Trading**: Safe testing with minimal amounts
- **User Experience**: Extensive UI/UX testing for addictive gameplay

### Code Organization
```
lib/
├── screens/
│   ├── casino_floor_screen.dart     # Main game interface
│   ├── upgrade_shop_screen.dart     # Upgrade purchases
│   ├── bot_management_screen.dart   # Bot hiring/management
│   └── prestige_screen.dart         # Reset and rewards
├── providers/
│   ├── game_state_provider.dart     # Core game state
│   ├── bot_provider.dart            # Automated earnings
│   ├── upgrade_provider.dart        # Player progression
│   └── prestige_provider.dart       # Reset mechanics
├── models/
│   ├── trading_bot.dart             # Bot data structures
│   ├── upgrade.dart                 # Upgrade definitions
│   └── game_state.dart              # Progress tracking
└── services/
    ├── tap_trade_service.dart       # Trade simulation
    ├── game_loop_service.dart       # Idle calculations
    └── volatility_service.dart      # Market data integration
```

## 🌐 Deployment Architecture

### Mobile App Distribution
- **Flutter Build**: Native iOS and Android compilation
- **App Store**: Standard mobile app store deployment
- **Update Strategy**: Over-the-air updates for game balance changes
- **Analytics**: Player behavior tracking for game optimization

### Backend Services
- **RAG System**: Development tool only (not deployed to production)
- **Market Data**: Real-time volatility feeds for trade simulation
- **Blockchain**: Smart contracts deployed to Starknet mainnet
- **APIs**: Extended Exchange integration for real trading

## 🔮 Future Architecture Considerations

### Planned Game Features
- **Clan Systems**: Team-based competition and shared goals
- **Seasonal Events**: Limited-time bonus periods and special rewards
- **Advanced Bots**: AI-driven bots with machine learning capabilities
- **Cross-Platform**: Web version with shared progress
- **VR Integration**: Immersive casino floor experience

### Scaling for Viral Growth
- **Global Leaderboards**: Real-time rankings across all players
- **Social Sharing**: Viral mechanics for achievement broadcasts
- **Referral Systems**: Friend invitation rewards
- **Community Features**: User-generated content and trading tips
- **Esports**: Competitive trading tournaments and leagues

---

**Last Updated**: 2025-01-10  
**Game Version**: Perp Tycoon v1.0  
**Architecture Version**: Casino Idle Game  
**Next Review**: After Phase 1 implementation