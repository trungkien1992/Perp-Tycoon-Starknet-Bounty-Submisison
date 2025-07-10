# 🎮 Perp Tycoon - Casino Idle Game Context Prime

> **Purpose**: This file maintains the complete project context for Claude Code sessions focused on casino idle game development.

## 🎯 Project Overview

**Perp Tycoon** is a casino-themed idle mobile game that transforms leveraged trading into an addictive gaming experience with real blockchain integration.

### **Core Identity**
- **Type**: Flutter mobile casino idle game with Cairo smart contracts
- **Theme**: High-stakes trading casino with slot machine mechanics
- **Blockchain**: Starknet integration for XP tracking, NFTs, and gasless transactions
- **Trading**: Mock trades for gameplay + one real trade per day via Extended Exchange
- **State**: Infrastructure 100% complete, ready for game development

## 🎮 Game Vision & Core Loop

### **The Perp Tycoon Experience**
Players enter a neon-lit underground trading casino where leveraged trading becomes a slot machine game:

1. **Tap to Trade** - Each tap triggers a slot machine animation simulating a leveraged trade
2. **Earn & Upgrade** - Successful trades earn cash to buy better trading tools and multipliers
3. **Automate** - Hire trading bots that earn money while offline (idle game mechanics)
4. **Prestige** - Reset all progress to earn Stark Tokens (permanent blockchain rewards)
5. **Real Integration** - One actual trade per day with Extended Exchange API

### **Game Mechanics Mapping**
| Idle Game Element | Perp Tycoon Implementation |
|-------------------|----------------------------|
| **Tap to earn** | Tap = mock leveraged trade (long/short coin flip) |
| **Upgrade system** | Better trading tools (faster execution, higher leverage, win rate boosts) |
| **Automation** | Trading bots that simulate trades while idle |
| **Prestige reset** | "Retire Rich" to earn Stark Tokens and reset progress |
| **Social features** | Global leaderboards, achievement sharing, daily events |

## 🏗️ Technical Architecture

### **Game Architecture Stack**
```
Flutter Casino Game (Frontend)
    ↕
Game State Management (Riverpod Providers)
    ↕
Local Persistence (SQLite) + Blockchain Sync (Starknet)
    ↕
Real Trading Integration (Extended Exchange API)
```

### **Core Game Components**
1. **Casino Floor System** - Main tap-to-trade interface with slot machine UI
2. **Trading Bot System** - Automated idle earnings while offline
3. **Upgrade Shop System** - Player progression through purchased improvements
4. **Prestige System** - Reset mechanics with permanent Stark Token rewards
5. **Real Trading Integration** - Daily real trade with NFT rewards

### **Game State Architecture**
```
lib/providers/
├── game_state_provider.dart         # Core: XP, cash, level progression
├── idle_earnings_provider.dart      # Offline bot earnings calculation  
├── bot_provider.dart                # Trading bot management & automation
├── upgrade_provider.dart            # Player progression & multipliers
├── prestige_provider.dart           # Reset mechanics & Stark Tokens
├── tap_trade_provider.dart          # Manual trade simulation engine
└── xp_provider.dart                 # XP system with blockchain sync
```

## 🔧 Infrastructure Status (100% Ready)

### **Existing Infrastructure Leveraged**
- ✅ **Flutter App Foundation** - Complete mobile app framework
- ✅ **Starknet Integration** - Wallet connection, contract interaction
- ✅ **Extended Exchange API** - Real trading backend ready
- ✅ **Smart Contracts** - XP tracking, NFT minting, gasless transactions
- ✅ **RAG Knowledge Base** - Development tool for context retrieval
- ✅ **Cross-Platform Utilities** - Shared types and utilities

### **Game-Specific Requirements**
- **SQLite Integration** - Already included in pubspec.yaml
- **Animation Framework** - Lottie/Rive for slot machine effects
- **Market Data** - Real-time volatility for trade simulation
- **Haptic Feedback** - Native mobile feedback for game interactions

## 🎮 Game Development Phases

### **🧱 PHASE 1 – Core Game Loop (Week 1)**
**Goal**: Transform trading interface into casino game

**Key Conversions**:
- `trading_screen.dart` → `casino_floor_screen.dart` with slot machine UI
- Add slot machine animations, PnL burst effects, coin showers
- Implement XP bar and vault cash display
- Create upgrade shop, bot management, and prestige screens

**New Providers**:
- `game_state_provider.dart` - Track XP, cash, Stark Tokens
- `idle_earnings_provider.dart` - Passive cash from bots
- `upgrade_provider.dart` - Trading tools and multipliers
- `bot_provider.dart` - Idle bot management

### **🎮 PHASE 2 – Automation & Idle (Week 1-2)**
**Goal**: Implement idle game mechanics

**Core Features**:
- Tap-to-trade engine using real market volatility
- Trading bot system with `Stream.periodic()` automation
- Upgrade system with SQLite persistence
- Offline earnings calculation and welcome back screen

**Formula**: `earnings = Σ(botYields * timeElapsed)`

### **⛓ PHASE 3 – Real Trading Integration (Week 2-3)**
**Goal**: Connect game to real blockchain and trading

**Integration Points**:
- Daily "One Real Trade" button with Extended Exchange API
- XP contract sync on milestones (10 wins, 1M cash, 7-day streak)
- NFT minting for achievements using existing `street_art_nft/` contracts
- Prestige reset with Stark Token rewards

### **🌐 PHASE 4 – Social & Viral (Week 3)**
**Goal**: Add retention and viral mechanics

**Features**:
- Global leaderboards using `streetcred_xp` contract
- Daily login bonuses and volatility surge events
- Social sharing for achievements and progress
- Community chat and competitive elements

## 🎨 Visual & UX Design

### **Casino Aesthetic**
- **Theme**: Cyberpunk casino with neon lights and dark backgrounds
- **Colors**: Electric green/red for PnL, cyan/magenta accents
- **Sounds**: Slot machine spins, cash register dings, explosion effects
- **Animations**: Coin showers for wins, glitch effects for losses

### **User Experience Principles**
- **Instant Gratification** - Immediate feedback for every tap
- **60fps Smooth** - Hardware-accelerated animations throughout
- **Haptic Feedback** - Tactile responses for major events
- **Visual Hierarchy** - Clear focus on tap button and earnings display

### **Screen Flow**
```
Casino Floor (Main) → Upgrade Shop → Bot Management → Prestige
     ↓                    ↓              ↓              ↓
Real Trade Daily → Achievement Gallery → Leaderboards → Share
```

## 🔄 Game Economy & Balance

### **Core Progression Loop**
1. **Manual Trading** - Tap to earn initial cash and XP
2. **First Upgrades** - Improve win rate and profit multipliers
3. **Bot Unlocks** - Purchase first automated traders
4. **Idle Growth** - Earn money while offline through bots
5. **Advanced Upgrades** - Higher tier improvements and new markets
6. **Prestige Trigger** - Reset for permanent Stark Token benefits

### **Monetization Strategy** (Future)
- **Cosmetic NFTs** - Visual casino floor improvements
- **Starter Packs** - Optional boost packages for new players
- **Premium Bots** - Special bot types with unique abilities
- **Social Features** - Clan memberships and tournament entries

## 🧪 Development Strategy

### **Code Organization Principles**
- **Game-First Architecture** - All code organized around game mechanics
- **Performance Optimized** - 60fps target with efficient memory usage
- **Testable Components** - Mathematical validation of game balance
- **Modular Design** - Easy to add new bot types, upgrades, and features

### **Testing Approach**
- **Game Balance Testing** - Mathematical validation of progression curves
- **Idle Calculation Testing** - Accurate offline earnings computation
- **Real Trading Testing** - Safe integration with minimal amounts
- **Performance Testing** - Frame rate and memory usage optimization

### **Deployment Strategy**
- **Mobile-First** - Native iOS and Android app store deployment
- **Progressive Updates** - Over-the-air updates for game balance
- **Blockchain Integration** - Seamless Starknet mainnet deployment
- **Analytics Integration** - Player behavior tracking for optimization

## 🎯 Success Metrics & KPIs

### **Engagement Metrics**
- **Daily Active Users** - Target: Growing player base
- **Session Duration** - Target: 5+ minutes average
- **Retention Rates** - Target: 50% Day 1, 20% Day 7, 10% Day 30
- **Progression Rate** - Target: 80% reach first bot unlock

### **Game Economy Health**
- **Idle Earnings Balance** - Offline vs active play ratio
- **Upgrade Purchase Rate** - Player progression spending patterns
- **Prestige Frequency** - How often players reset for tokens
- **Real Trade Adoption** - Daily real trade feature usage

### **Technical Performance**
- **60fps Consistency** - Smooth gameplay across devices
- **Load Time Performance** - <3 second app startup
- **Offline Accuracy** - Precise idle earnings calculation
- **Crash Rate** - <0.1% session crash rate

## 🚀 Ready for Development

### **Infrastructure Complete**
All technical infrastructure is 100% ready:
- Flutter app framework with Riverpod state management
- Starknet blockchain integration with deployed contracts
- Extended Exchange trading API integration
- Local SQLite database support
- Real-time market data integration

### **Development Environment**
- **Codebase**: Well-organized with clear separation of concerns
- **Documentation**: Comprehensive architecture and planning docs
- **Tools**: RAG knowledge base for efficient development
- **Testing**: Framework ready for game balance validation

### **Immediate Next Steps**
1. Begin Phase 1 implementation with casino floor screen conversion
2. Implement tap-to-trade simulation engine
3. Add slot machine animations and visual feedback
4. Create basic upgrade shop and bot management interfaces

---

**Project Status**: 🎮 **Ready for Casino Game Development**  
**Infrastructure**: ✅ **100% Complete**  
**Next Action**: 🚀 **Begin Phase 1 - Core Game Loop**  
**Last Updated**: 2025-01-10