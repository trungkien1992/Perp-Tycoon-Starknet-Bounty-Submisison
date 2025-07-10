# Perp Tycoon - Casino Idle Game Development TODO

## 🎮 Game Development Status

**Project**: Perp Tycoon - An Idle Trading Casino  
**Current Phase**: Pre-Development (Infrastructure Complete)  
**Next Phase**: Phase 1 - Core Game Loop  
**Last Updated**: 2025-01-10  

## 🧱 PHASE 1 – Idle Core Game Loop (Week 1)

### ✅ Screens & UI (based on `lib/screens/`)

#### High Priority - Convert Existing Screens
- [ ] **Convert trading_screen.dart → casino_floor_screen.dart**
  - Replace order forms & charts with tap-to-trade buttons
  - Add slot machine animation framework
  - Implement PnL burst animations and coin rains
  - Add "MOON/RUG" outcome displays
  - Ensure XP bar + vault cash always visible
  - **Estimate**: 6-8 hours

#### High Priority - Add New Game Screens  
- [ ] **Create upgrade_shop_screen.dart**
  - Trading tools, leverage upgrades, visual enhancements
  - Buy/upgrade interface with clear value propositions
  - **Estimate**: 4-6 hours

- [ ] **Create bot_management_screen.dart**
  - Bot roster with visual avatars
  - Hire new bots interface
  - Bot stats and performance display
  - **Estimate**: 4-6 hours

- [ ] **Create prestige_screen.dart**
  - Reset progress interface
  - Stark Token rewards display
  - Prestige perks and benefits
  - **Estimate**: 3-4 hours

- [ ] **Create leaderboard_screen.dart**
  - Global rankings by net worth, XP, alpha score
  - Friend comparisons
  - Social sharing features
  - **Estimate**: 3-4 hours

#### Medium Priority - Animations
- [ ] **Implement Lottie/Rive animations**
  - Slot machine reels for trades
  - Fire effects for big wins
  - Bot action animations
  - **Estimate**: 6-8 hours

### ✅ Providers (based on `lib/providers/`)

#### High Priority - Core Game State
- [ ] **Create game_state_provider.dart**
  - Track XP, vault cash, Stark Tokens
  - Level progression system
  - Achievement tracking
  - **Estimate**: 4-6 hours

- [ ] **Create idle_earnings_provider.dart**
  - Passive cash calculation from bots
  - Offline earnings computation
  - Time-based accumulation
  - **Estimate**: 4-5 hours

- [ ] **Create upgrade_provider.dart**
  - Trading tool upgrades and multipliers
  - Leverage improvements
  - Visual enhancement unlocks
  - **Estimate**: 3-4 hours

- [ ] **Create bot_provider.dart**
  - Individual bot management
  - Per-market profit rates
  - Bot specialization logic
  - **Estimate**: 5-6 hours

- [ ] **Create prestige_provider.dart**
  - Reset logic and Stark Token rewards
  - Prestige perk calculations
  - Progress milestone tracking
  - **Estimate**: 3-4 hours

#### Medium Priority - Existing Provider Updates
- [ ] **Modify xp_provider.dart**
  - Compute XP locally with optional on-chain sync
  - Connect to streetcred_xp Cairo contract
  - **Estimate**: 2-3 hours

### ✅ Game Models (based on `lib/models/`)

#### High Priority - Core Models
- [ ] **Create TradingBot model**
  - Bot properties: market type, profit multiplier, trade interval
  - Serialization for local storage
  - **Estimate**: 2 hours

- [ ] **Create Upgrade model**
  - Upgrade types, costs, effects
  - Ownership tracking
  - **Estimate**: 2 hours

- [ ] **Create PrestigeTier model**
  - Tier benefits and requirements
  - Stark Token rewards
  - **Estimate**: 1-2 hours

- [ ] **Create GameState model**
  - Overall game progress tracking
  - Save/load state management
  - **Estimate**: 2-3 hours

#### Medium Priority - Local Storage
- [ ] **Implement SQLite save/load system**
  - Use existing sqflite dependency
  - Game state persistence
  - **Estimate**: 3-4 hours

**Phase 1 Total Estimate**: 60-80 hours (2 weeks with focused development)

---

## 🎮 PHASE 2 – Tap Logic, Bots, and Offline Earnings (Week 1-2)

### ✅ Tap-to-Trade Engine

#### High Priority - Core Trading Logic
- [ ] **Create tap_trade_service.dart**
  - Use ExtendedExchangeFormat real-time volatility
  - Implement win/loss simulation formula
  - PnL calculation based on volatility and multipliers
  - **Estimate**: 6-8 hours

- [ ] **Integrate volatility data**
  - Connect to existing market data feeds
  - Real-time volatility calculation
  - **Estimate**: 3-4 hours

### ✅ Bot System Implementation

#### High Priority - Automated Trading
- [ ] **Create trading_bot.dart + bot_provider.dart**
  - Individual bot properties and behavior
  - Market specialization logic
  - Profit multiplier calculations
  - **Estimate**: 6-8 hours

- [ ] **Implement Stream.periodic() bot trading**
  - Automated trade execution while idle
  - Background processing
  - **Estimate**: 4-5 hours

### ✅ Upgrade System

#### High Priority - Player Progression
- [ ] **Define UpgradeType enum**
  - WinRate, PnLBoost, Speed, Cosmetic categories
  - **Estimate**: 1 hour

- [ ] **Implement upgrade ownership in SQLite**
  - Store purchase history
  - Update multipliers in providers
  - **Estimate**: 3-4 hours

### ✅ Game Loop & Offline Calculation

#### High Priority - Idle Mechanics
- [ ] **Create game_loop_service.dart**
  - Offline earnings calculation: earnings = Σ(botYields * timeElapsed)
  - Last login time persistence
  - Welcome back earnings display
  - **Estimate**: 5-6 hours

**Phase 2 Total Estimate**: 28-36 hours (1 week focused development)

---

## ⛓ PHASE 3 – Real Trading + On-Chain Integration (Week 2-3)

### ✅ Real Daily Trade Implementation

#### High Priority - Blockchain Integration
- [ ] **Add "One Real Trade" button to casino floor**
  - Daily limit enforcement
  - Special UI treatment
  - **Estimate**: 2-3 hours

- [ ] **Connect existing real trading infrastructure**
  - Use real_starknet_service.dart
  - Integrate python_trading_service/main.py
  - Connect extended_exchange_format.py
  - **Estimate**: 4-6 hours

- [ ] **Implement ExtendedApiClient.createOrder() integration**
  - Gasless paymaster logic (already integrated)
  - Error handling for real trades
  - **Estimate**: 3-4 hours

### ✅ Blockchain Features

#### High Priority - On-Chain Rewards
- [ ] **Implement XP Contract Sync**
  - Milestone-based sync (10 wins, 1M cash, 7-day streak)
  - contractService.addXPToContract() integration
  - **Estimate**: 3-4 hours

- [ ] **NFT Minting Integration**
  - Use existing street_art_nft/ contracts
  - Mint on: First Real Trade, Prestige trigger, Profit milestones
  - **Estimate**: 4-6 hours

- [ ] **Prestige Reset with Stark Token Minting**
  - Use Cairo mint_stark_token() in prestige_provider.dart
  - Reset local game state while preserving Stark Tokens
  - **Estimate**: 4-5 hours

**Phase 3 Total Estimate**: 20-28 hours (1 week focused development)

---

## 🌐 PHASE 4 – Retention, Social, and Presentation (Week 3)

### ✅ Retention Features

#### High Priority - Player Engagement
- [ ] **Daily Login Bonus System**
  - Free bot upgrades for daily logins
  - Streak tracking and rewards
  - **Estimate**: 3-4 hours

- [ ] **Hourly Volatility Surges**
  - 2× profits time windows
  - Push notifications for surge events
  - **Estimate**: 2-3 hours

- [ ] **XP Streak Mechanics**
  - Consecutive trading day bonuses
  - Streak preservation mechanics
  - **Estimate**: 2-3 hours

### ✅ Social Features

#### Medium Priority - Community
- [ ] **Global Chat Implementation**
  - WebSocket integration for real-time chat
  - Market event announcements ("BTC just mooned!")
  - **Estimate**: 6-8 hours

- [ ] **Enhanced Leaderboard**
  - Use contractService.getLeaderboardFromContract()
  - Multiple ranking categories
  - **Estimate**: 3-4 hours

- [ ] **Share Functionality**
  - Export clips after prestige or jackpot
  - Use result_screen.dart as base
  - Social media integration
  - **Estimate**: 4-5 hours

### ✅ Documentation & Launch Preparation

#### High Priority - Project Finalization
- [ ] **Update all documentation**
  - README.md, PROJECT_STATUS.md
  - Create REAL_TRADING_STATUS.md
  - **Estimate**: 2-3 hours

- [ ] **Create demo video**
  - Showcase tap loop, XP progression
  - Real trade execution + NFT mint
  - **Estimate**: 3-4 hours

**Phase 4 Total Estimate**: 22-30 hours (1 week focused development)

---

## 🎯 Total Project Estimate

**Total Development Time**: 130-174 hours (4-5 weeks full-time development)

**Infrastructure Status**: ✅ 100% Complete
- RAG Backend System
- Flutter Mobile Application Foundation  
- Smart Contract Infrastructure
- Python Trading Service
- Shared Module Architecture
- Documentation Framework

## 🚨 Current Blockers & Dependencies

### No Current Blockers
- ✅ All infrastructure is operational and ready
- ✅ Existing codebase provides solid foundation
- ✅ Real trading integration already tested
- ✅ Smart contracts deployed and functional

### External Dependencies
- **Design Assets**: Casino-themed UI elements and animations
- **Sound Effects**: Slot machine, coin, and notification sounds
- **Market Data**: Continued access to real-time volatility feeds

### Internal Dependencies
- **Code Architecture**: Existing providers and services ready for extension
- **Database**: SQLite already integrated in pubspec.yaml
- **Blockchain**: Contracts deployed and ready for game integration

## 📅 Sprint Schedule

### Week 1: Core Game Loop (Phase 1)
- Days 1-2: Screen conversions and new UI
- Days 3-4: Provider implementation
- Days 5-7: Models and local storage

### Week 2: Automation & Real Trading (Phases 2-3)
- Days 1-3: Tap engine and bot system
- Days 4-5: Real trading integration
- Days 6-7: Blockchain features

### Week 3: Social & Polish (Phase 4)
- Days 1-2: Retention mechanics
- Days 3-4: Social features
- Days 5-7: Documentation and demo

## 🎮 Ready to Begin Development

The project infrastructure is 100% complete and ready for game development to begin immediately. All phases have been planned with realistic estimates based on the existing codebase foundation.

---

**Last Updated**: 2025-01-10  
**Next Phase**: Phase 1 - Idle Core Game Loop  
**Development Status**: Ready to begin immediate implementation