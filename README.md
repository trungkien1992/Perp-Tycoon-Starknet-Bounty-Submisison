# Perp Tycoon - Casino Idle Game

## 🎮 Quick Start for New Claude Sessions

**IMPORTANT: At the start of each new chat session, please read these core files:**

1. **[project-rules/docs/CONTEXT_PRIME.md](project-rules/docs/CONTEXT_PRIME.md)** - Complete game vision and context
2. **[project-rules/docs/PROJECT_STATUS.md](project-rules/docs/PROJECT_STATUS.md)** - Current progress and system status
3. **[project-rules/docs/TODO.md](project-rules/docs/TODO.md)** - Active game development tasks
4. **[project-rules/docs/ARCHITECTURE.md](project-rules/docs/ARCHITECTURE.md)** - Casino game architecture
5. **[project-rules/docs/GAME_PIVOT_PLAN.md](project-rules/docs/GAME_PIVOT_PLAN.md)** - 4-phase development roadmap

## 🎯 Project Overview

**Perp Tycoon** is a casino-themed idle mobile game that transforms leveraged trading into an addictive gaming experience with real blockchain integration.

### 🎮 The Casino Experience
Transform your phone into a trading casino where every tap is a leveraged trade:
- **Tap-to-Trade**: Slot machine mechanics with crypto symbols
- **Idle Earnings**: Trading bots earn money while you're offline
- **Real Integration**: One actual trade per day with Extended Exchange API
- **Blockchain Rewards**: NFTs and Stark Tokens for achievements

### 🏗️ Game Architecture Stack
```
Flutter Casino Game (Frontend)
    ↕
Game State Management (Riverpod Providers)
    ↕
Local Persistence (SQLite) + Blockchain Sync (Starknet)
    ↕
Real Trading Integration (Extended Exchange API)
```

## 🎮 Core Game Components

### 1. Casino Floor System
**Main game loop**: Tap-to-trade with slot machine animations
- Visual slot reels with crypto symbols
- PnL burst animations (coin showers for wins)
- Real-time volatility for authentic outcomes
- XP progression with level-up celebrations

### 2. Trading Bot System  
**Idle earnings**: Automated trading while offline
- Market specialization (ETH, BTC, MEME coins)
- Profit formula: `earnings = Σ(botYields * timeElapsed)`
- Visual bot avatars with unique personalities

### 3. Upgrade Shop System
**Player progression**: Purchase improvements
- Win rate boosts and PnL multipliers
- Speed enhancements for faster trading
- Cosmetic casino floor upgrades

### 4. Prestige System
**Reset mechanics**: "Retire Rich" for permanent benefits
- Stark Token rewards (on-chain NFT tokens)
- Progressive multiplier bonuses
- Achievement NFTs for major milestones

### 5. Real Trading Integration
**Daily feature**: One actual trade per day
- Extended Exchange API integration
- Gasless transactions via AVNU paymaster
- Real rewards and achievement tracking

## 🎮 Game Development Phases

### 🧱 PHASE 1 – Core Game Loop (Week 1)
**Goal**: Transform trading interface into casino game
- Convert `trading_screen.dart` → `casino_floor_screen.dart`
- Add slot machine animations and PnL burst effects
- Implement XP bar and vault cash display
- Create upgrade shop, bot management, and prestige screens

### 🎯 PHASE 2 – Automation & Idle (Week 1-2)
**Goal**: Implement idle game mechanics
- Tap-to-trade engine using real market volatility
- Trading bot system with automated earnings
- Upgrade system with SQLite persistence
- Offline earnings calculation and welcome back screen

### ⛓ PHASE 3 – Real Trading Integration (Week 2-3)
**Goal**: Connect game to real blockchain and trading
- Daily "One Real Trade" button with Extended Exchange API
- XP contract sync on milestones (10 wins, 1M cash, 7-day streak)
- NFT minting for achievements using existing contracts
- Prestige reset with Stark Token rewards

### 🌐 PHASE 4 – Social & Viral (Week 3)
**Goal**: Add retention and viral mechanics
- Global leaderboards using blockchain contracts
- Daily login bonuses and volatility surge events
- Social sharing for achievements and progress
- Community chat and competitive elements

## 🏗️ Infrastructure Status (100% Complete)

### ✅ Ready for Game Development
- **Flutter App Foundation** - Complete mobile app framework
- **Starknet Integration** - Wallet connection, contract interaction
- **Extended Exchange API** - Real trading backend ready
- **Smart Contracts** - XP tracking, NFT minting, gasless transactions
- **RAG Knowledge Base** - Development tool for context retrieval
- **Cross-Platform Utilities** - Shared types and utilities

## 🛠️ Quick Commands

```bash
# Start RAG Backend (Development Tool)
cd knowledge_base/backend
source venv/bin/activate
python main.py

# Start Flutter Casino Game
flutter run

# Start Python Trading Service (Real Trading Integration)
cd python_trading_service
source venv/bin/activate
python main.py

# Run Tests
flutter test
```

## 📊 Current Status

**Project Status**: 🎮 **Pivoted to Casino Idle Game - Ready for Development**  
**Infrastructure**: ✅ **100% Complete**  
**Game Development**: 📋 **Phase 1 Ready to Begin**  

### Infrastructure Complete
- ✅ **Flutter App Foundation** - Ready for casino game conversion
- ✅ **Extended Exchange API** - Real trading integration ready  
- ✅ **Smart Contracts** - XP system and NFT minting deployed
- ✅ **AVNU Paymaster** - Gasless transactions operational
- ✅ **RAG Knowledge Base** - Development context system active
- ✅ **Multi-Market Support** - 6 markets ready for bot specialization

### Game Development Status
- 🎯 **Phase 1**: Core game loop design complete, ready for implementation
- 🎯 **Phase 2**: Idle mechanics and bot system architecture planned
- 🎯 **Phase 3**: Real trading integration path established
- 🎯 **Phase 4**: Social features and viral mechanics outlined

## 🔧 Development Environment

- **Platform**: macOS (Darwin 24.5.0)
- **Python**: 3.x with virtual environment
- **Flutter**: Latest stable
- **Database**: ChromaDB vector database
- **API**: FastAPI with sentence transformers

## 📁 Project Structure

```
perp-tycoon/
├── lib/                         # Flutter casino game
│   ├── main.dart               # App entry point
│   ├── app_mode.dart           # Mock/Real mode configuration
│   ├── screens/                # Game screens (casino floor, upgrades, bots)
│   ├── providers/              # Game state management (XP, cash, bots)
│   └── services/               # Game logic services
├── python_trading_service/     # Real trading integration
│   ├── main.py                 # FastAPI trading server
│   ├── starkex_crypto.py       # StarkEx signature generation
│   ├── extended_exchange_format.py # Extended Exchange API client
│   └── venv/                   # Virtual environment
├── contracts/                  # Cairo smart contracts
│   ├── streetcred_xp/         # XP tracking system
│   ├── streetcred_paymaster/  # Gasless transaction sponsor
│   └── street_art_nft/        # Achievement NFT system
├── shared/                     # Shared utilities
│   ├── services/              # Cross-platform services
│   ├── types/                 # Unified type definitions
│   └── utils/                 # Common utilities
├── knowledge_base/             # RAG system for development
│   ├── backend/               # FastAPI RAG server
│   └── data/                  # SDK documentation
└── project-rules/             # Project guidelines and documentation
    ├── docs/                  # Game development documentation
    ├── CONTEXT_PRIME.md       # Complete game vision
    ├── PROJECT_STATUS.md      # Current development status
    ├── TODO.md               # Active game development tasks
    └── [Game documentation]   # Architecture, plans, guides
```

## 📚 Game Development Documentation

The `/project-rules/docs/` directory contains all game development documentation:

- **CONTEXT_PRIME.md** - Complete casino idle game vision and core loop
- **PROJECT_STATUS.md** - Current development status and infrastructure readiness
- **TODO.md** - Active game development tasks with time estimates
- **ARCHITECTURE.md** - Casino game architecture and component design
- **GAME_PIVOT_PLAN.md** - 4-phase development roadmap (130-174 hours)
- **KNOWLEDGE_BASE.md** - Game mechanics formulas and implementation patterns
- **FILE_STRUCTURE.md** - Project organization and component mapping

## 🤝 Game Development Protocol

1. **Start each session** by reading project-rules documentation
2. **Use TodoWrite tool** for tracking game development progress
3. **Follow 4-phase development plan** outlined in GAME_PIVOT_PLAN.md
4. **Test game mechanics** thoroughly after each implementation
5. **Update documentation** as game features are completed

## 🎯 Getting Started with Game Development

### Prerequisites
- Flutter 3.10+ with mobile support
- Dart 3.0+
- Python 3.10+ (for real trading integration)
- Lottie/Rive for animations

### Quick Setup

1. **Install Flutter Dependencies**
   ```bash
   flutter pub get
   ```

2. **Start RAG Backend (Development Tool)**
   ```bash
   cd knowledge_base/backend
   source venv/bin/activate
   python main.py
   ```

3. **Run Casino Game**
   ```bash
   flutter run
   ```

4. **Start Real Trading Service (Phase 3)**
   ```bash
   cd python_trading_service
   source venv/bin/activate
   python main.py
   ```

## 🎮 Next Steps

**Current Priority**: Begin Phase 1 - Core Game Loop implementation
- Convert `trading_screen.dart` to casino floor with slot machine mechanics
- Implement tap-to-trade engine with volatility-based outcomes
- Add XP progression and vault cash display
- Create upgrade shop and bot management screens

See [project-rules/docs/TODO.md](project-rules/docs/TODO.md) for detailed Phase 1 tasks.

## 🔄 Development Status

**Project Status**: 🎮 **Casino Idle Game - Ready for Development**  
**Infrastructure**: ✅ **100% Complete**  
**Game Development**: 📋 **Phase 1 Ready to Begin**  
**Timeline**: 130-174 hours across 4 development phases  

---

**Last Updated**: 2025-01-10
**Version**: Perp Tycoon v1.0
**Status**: Infrastructure Complete - Casino Game Development Ready
**Next Phase**: Phase 1 - Core Game Loop Implementation