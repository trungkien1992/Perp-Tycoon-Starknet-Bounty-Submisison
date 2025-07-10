# Perp Tycoon - Development TODO

## 🎮 Current Development Phase

**Phase**: 🎯 **Phase 2 - UI Screens & Enhanced Features**  
**Status**: 🔄 **Ready to Begin**  
**Timeline**: 15-20 hours remaining  
**Priority**: Build upgrade shop, bot management, and prestige UI screens  

## ✅ PHASE 1 – Core Game Loop (COMPLETED)

### ✅ Screen Conversion - COMPLETED
- [x] **Convert trading_screen.dart → casino_floor_screen.dart**
  - [x] Replace order forms & charts with coin toss interface
  - [x] Add LONG/SHORT selection buttons (Heads/Tails)
  - [x] Implement coin toss animation with physics and weight
  - [x] Add coin progression system (Copper → Silver → Gold)
  - [x] Add haptic feedback (metallic sounds pending)
  - [x] Implement PnL burst animations and coin rains
  - [x] Add win/loss outcome displays
  - [x] Ensure XP bar + vault cash always visible
  - **Completed**: January 2025

### 🎯 High Priority - New Game Screens
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

### 🎯 High Priority - Game State Providers
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

### 🎯 High Priority - Game Models
- [ ] **Create game data models**
  - TradingBot model (market type, profit multiplier, trade interval)
  - Upgrade model (types, costs, effects)
  - GameState model (overall progress tracking)
  - **Estimate**: 4-5 hours

- [ ] **Implement SQLite save/load system**
  - Use existing sqflite dependency
  - Game state persistence
  - **Estimate**: 3-4 hours

### 🎨 Medium Priority - Animations
- [ ] **Implement Lottie/Rive animations**
  - Slot machine reels for trades
  - Fire effects for big wins
  - Bot action animations
  - **Estimate**: 6-8 hours

**Phase 1 Total**: 60-80 hours

## 🎯 PHASE 2 – Automation & Idle (Week 1-2)

### 🔄 Tap-to-Trade Engine
- [ ] **Create tap_trade_service.dart**
  - Implement coin toss mechanics (50/50 chance)
  - Use ExtendedExchangeFormat real-time volatility for PnL magnitude
  - Calculate PnL based on volatility and multipliers
  - Add coin progression system (Copper/Silver/Gold)
  - **Estimate**: 6-8 hours

- [ ] **Integrate volatility data**
  - Connect to existing market data feeds
  - Real-time volatility calculation
  - **Estimate**: 3-4 hours

### 🤖 Bot System Implementation
- [ ] **Create trading_bot.dart + bot_provider.dart**
  - Individual bot properties and behavior
  - Market specialization logic
  - Profit multiplier calculations
  - **Estimate**: 6-8 hours

- [ ] **Implement Stream.periodic() bot trading**
  - Automated trade execution while idle
  - Background processing
  - **Estimate**: 4-5 hours

### 📈 Upgrade System
- [ ] **Define UpgradeType enum**
  - WinRate, PnLBoost, Speed, Cosmetic categories
  - **Estimate**: 1 hour

- [ ] **Implement upgrade ownership in SQLite**
  - Store purchase history
  - Update multipliers in providers
  - **Estimate**: 3-4 hours

### 🎮 Game Loop & Offline Calculation
- [ ] **Create game_loop_service.dart**
  - Offline earnings calculation: earnings = Σ(botYields * timeElapsed)
  - Last login time persistence
  - Welcome back earnings display
  - **Estimate**: 5-6 hours

**Phase 2 Total**: 28-36 hours

## ⛓ PHASE 3 – Real Trading Integration (Week 2-3)

### 💰 Real Daily Trade
- [ ] **Add "One Real Trade" button to casino floor**
  - Daily limit enforcement
  - Special UI treatment
  - **Estimate**: 2-3 hours

- [ ] **Connect existing real trading infrastructure**
  - Use real_starknet_service.dart
  - Integrate python_trading_service/main.py
  - **Estimate**: 4-6 hours

### 🏆 Blockchain Features
- [ ] **Implement XP Contract Sync**
  - Milestone-based sync (10 wins, 1M cash, 7-day streak)
  - contractService.addXPToContract() integration
  - **Estimate**: 3-4 hours

- [ ] **NFT Minting Integration**
  - Use existing street_art_nft/ contracts
  - Mint on achievements and milestones
  - **Estimate**: 4-6 hours

- [ ] **Prestige Reset with Stark Token Minting**
  - Use Cairo mint_stark_token() in prestige_provider.dart
  - Reset local game state while preserving Stark Tokens
  - **Estimate**: 4-5 hours

**Phase 3 Total**: 20-28 hours

## 🌐 PHASE 4 – Social & Viral (Week 3)

### 🔄 Retention Features
- [ ] **Daily Login Bonus System**
  - Free bot upgrades for daily logins
  - Streak tracking and rewards
  - **Estimate**: 3-4 hours

- [ ] **Hourly Volatility Surges**
  - 2× profits time windows
  - Push notifications for surge events
  - **Estimate**: 2-3 hours

### 👥 Social Features
- [ ] **Enhanced Leaderboard**
  - Use contractService.getLeaderboardFromContract()
  - Multiple ranking categories
  - **Estimate**: 3-4 hours

- [ ] **Share Functionality**
  - Export clips after prestige or jackpot
  - Social media integration
  - **Estimate**: 4-5 hours

### 📋 Documentation & Launch
- [ ] **Update all documentation**
  - README.md, PROJECT_STATUS.md updates
  - Create REAL_TRADING_STATUS.md
  - **Estimate**: 2-3 hours

- [ ] **Create demo video**
  - Showcase game mechanics and progression
  - **Estimate**: 3-4 hours

**Phase 4 Total**: 22-30 hours

## 📊 Development Summary

### Timeline Overview
- **Phase 1**: 60-80 hours (Core Game Loop)
- **Phase 2**: 28-36 hours (Automation & Idle)
- **Phase 3**: 20-28 hours (Real Trading Integration)
- **Phase 4**: 22-30 hours (Social & Viral)

**Total Development Time**: 130-174 hours (4-5 weeks)

### Current Status
- **Infrastructure**: ✅ 100% Complete
- **Phase 1**: ✅ Core Game Loop Completed
- **Testing**: ✅ Clean Test Suite (18 tests passing)
- **Codebase**: ✅ Cleaned up (removed 8+ outdated files)
- **Blockers**: None - ready for Phase 2 UI development

### Recent Completed (January 2025)
1. ✅ **Phase 1 Core Implementation** - Casino floor, game mechanics, providers
2. ✅ **Test Suite Cleanup** - Removed outdated tests, fixed model compatibility
3. ✅ **Codebase Cleanup** - Removed duplicate files, empty directories
4. ✅ **Documentation Update** - Updated project status and context

### Next Actions
1. **Build UI Screens** for upgrade shop, bot management, and prestige
2. **Enhance animations** with Lottie/Rive components
3. **Add sound effects** and enhanced haptic feedback
4. **Update documentation** as features are completed

## 🔗 Cross-References

- **[ARCHITECTURE.md](ARCHITECTURE.md)** - System design and components
- **[PROJECT_STATUS.md](PROJECT_STATUS.md)** - Current development status
- **[COLLABORATION_GUIDE.md](COLLABORATION_GUIDE.md)** - Development protocols
- **[project-rules/docs/TODO.md](../project-rules/docs/TODO.md)** - Detailed task breakdown

---

**Last Updated**: 2025-01-10  
**Development Phase**: Phase 1 - Core Game Loop  
**Status**: Ready to Begin Implementation  
**Next Priority**: Convert trading_screen.dart to casino_floor_screen.dart