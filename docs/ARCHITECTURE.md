# Perp Tycoon - Casino Idle Game Architecture

## 🏗️ High-Level System Architecture

Perp Tycoon is an **idle casino trading game** that transforms leveraged trading into an addictive mobile gaming experience with real blockchain integration.

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

### 🛠️ Technical Stack
```
┌─────────────────────────────────────────────────────────────────┐
│                 Technical Infrastructure                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────┐  │
│  │                 │    │                 │    │             │  │
│  │   Flutter App   │◄──►│ Smart Contracts │◄──►│  Extended   │  │
│  │ (Game Frontend) │    │ (XP + NFTs)     │    │  Exchange   │  │
│  │                 │    │                 │    │ (Real API)  │  │
│  └─────────────────┘    └─────────────────┘    └─────────────┘  │
│                                                                 │
│  Infrastructure: Flutter • Starknet • Extended Exchange API    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 🎯 Core Game Systems

### 1. Casino Floor System
**Purpose**: Main game interaction loop with tap-to-trade mechanics
- **Location**: `/lib/screens/casino_floor_screen.dart`
- **Mechanics**: Tap-to-trade with slot machine animations
- **Features**: Real-time volatility, PnL animations, XP progression
- **Pattern**: Real-time reactive UI with immediate feedback

### 2. Trading Bot System
**Purpose**: Automated idle earnings while offline
- **Location**: `/lib/providers/bot_provider.dart`
- **Mechanics**: Market specialization, profit calculation
- **Formula**: `earnings = Σ(botYields * timeElapsed)`
- **Pattern**: Stream-based periodic execution

### 3. Upgrade Shop System
**Purpose**: Player progression through purchased improvements
- **Location**: `/lib/screens/upgrade_shop_screen.dart`
- **Categories**: Win rate boosts, PnL multipliers, speed enhancements
- **Pattern**: Purchase validation with immediate effect application

### 4. Prestige System
**Purpose**: Reset progression for permanent benefits
- **Location**: `/lib/providers/prestige_provider.dart`
- **Mechanics**: Stark Token rewards, progress reset, multiplier bonuses
- **Pattern**: Blockchain integration with local state management

## 🔄 Data Flow Architecture

### Core Game Loop (Tap-to-Trade)
```
1. User taps → 2. Volatility fetch → 3. Win/loss calculation
     ↓                ↓                    ↓
6. UI animations ← 5. XP/cash update ← 4. PnL determination
     ↓
7. Achievement checks → 8. Level progression → 9. Unlock validation
```

### Idle Earnings Loop (Bots)
```
1. App minimized → 2. Timestamp saved → 3. Background calculation
     ↓                     ↓                     ↓
8. Welcome back ← 7. UI update ← 6. Earnings ← 5. Bot simulation
     ↓                              ↓
4. Time delta → Bot performance → Market volatility
```

## 🧩 Component Architecture

### Game State Management
```dart
lib/providers/
├── game_state_provider.dart     # Core: XP, cash, level progression
├── idle_earnings_provider.dart  # Offline bot earnings calculation  
├── bot_provider.dart            # Trading bot management & automation
├── upgrade_provider.dart        # Player progression & multipliers
├── prestige_provider.dart       # Reset mechanics & Stark Tokens
└── tap_trade_provider.dart      # Manual trade simulation engine
```

### Screen Architecture
```dart
lib/screens/
├── casino_floor_screen.dart     # Main game interface
├── upgrade_shop_screen.dart     # Upgrade purchases
├── bot_management_screen.dart   # Bot hiring/management
├── prestige_screen.dart         # Reset and rewards
└── leaderboard_screen.dart      # Global rankings
```

### Services Architecture
```dart
lib/services/
├── tap_trade_service.dart       # Trade simulation
├── game_loop_service.dart       # Idle calculations
├── volatility_service.dart      # Market data integration
├── contract_service.dart        # Blockchain interactions
└── real_starknet_service.dart   # Real trading integration
```

## 🔐 Security & Performance

### Trade Simulation Integrity
- **Deterministic Outcomes**: Random seed based on market volatility + timestamp
- **Fair Probability**: Win rates clearly displayed and mathematically enforced
- **Audit Trail**: Complete log of all simulated trades for analysis

### Performance Optimization
- **60fps Target**: Smooth animations throughout all interactions
- **Memory Efficiency**: Efficient bot simulation without memory leaks
- **Battery Optimization**: Minimal background processing when inactive

## 🌐 Integration Points

### Blockchain Integration
- **Smart Contracts**: XP tracking, NFT minting, gasless transactions
- **Starknet**: Deployed on mainnet with real token rewards
- **AVNU Paymaster**: Gasless transaction sponsorship

### Real Trading Integration
- **Extended Exchange API**: Real cryptocurrency trading capability
- **Daily Limits**: Strict 1 real trade per day maximum
- **Safety**: Small position sizes and comprehensive error handling

## 📊 Infrastructure Status

### ✅ 100% Complete Infrastructure
- **Flutter App Foundation** - Complete mobile app framework
- **Starknet Integration** - Wallet connection, contract interaction  
- **Extended Exchange API** - Real trading backend ready
- **Smart Contracts** - XP tracking, NFT minting, gasless transactions
- **RAG Knowledge Base** - Development tool for context retrieval
- **Cross-Platform Utilities** - Shared types and utilities

### 🎮 Ready for Game Development
All technical infrastructure is operational and ready for Phase 1 implementation:
- Game state management systems
- Blockchain integration
- Real trading API connections
- Local persistence with SQLite
- Animation frameworks for casino effects

## 🔗 Cross-References

For detailed implementation guidance, see:
- **[PROJECT_STATUS.md](PROJECT_STATUS.md)** - Current development status
- **[GAME_DESIGN.md](GAME_DESIGN.md)** - Casino game mechanics
- **[TODO.md](TODO.md)** - Active development tasks
- **[project-rules/docs/ARCHITECTURE.md](../project-rules/docs/ARCHITECTURE.md)** - Detailed technical architecture

---

**Last Updated**: 2025-01-10  
**Architecture Version**: Casino Idle Game v1.0  
**Status**: Infrastructure Complete - Game Development Ready