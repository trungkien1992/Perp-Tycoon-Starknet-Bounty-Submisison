# Perp Tycoon - Casino Idle Game Project Structure

## 📁 Casino Game Codebase Structure

The Perp Tycoon project is organized as a **casino idle game** that transforms leveraged trading into an addictive mobile gaming experience:

```
tycoon-project/
├── README.md                        # Main project documentation
├── pubspec.yaml                     # Flutter dependencies (includes sqflite, riverpod)
├── analysis_options.yaml           # Dart analysis configuration
│
├── lib/                            # Flutter casino game application
│   ├── main.dart                   # Casino game entry point
│   ├── app_mode.dart              # Mock/real mode configuration
│   │
│   ├── screens/                    # Game screens
│   │   ├── game/                  # Core game interfaces
│   │   │   ├── casino_floor_screen.dart    # Main tap-to-trade interface
│   │   │   ├── upgrade_shop_screen.dart    # Purchase improvements
│   │   │   ├── bot_management_screen.dart  # Hire & manage bots
│   │   │   ├── prestige_screen.dart        # Reset for Stark Tokens
│   │   │   └── welcome_back_screen.dart    # Offline earnings display
│   │   ├── social/                # Social features
│   │   │   ├── leaderboard_screen.dart     # Global rankings
│   │   │   └── achievement_screen.dart     # NFT collection
│   │   └── trading/               # Real trading integration
│   │       ├── real_trade_screen.dart      # Daily real trade
│   │       └── result_screen.dart          # Results & sharing
│   │
│   ├── providers/                  # Game state management (Riverpod)
│   │   ├── game_state_provider.dart        # Core game progress
│   │   ├── idle_earnings_provider.dart     # Offline bot earnings
│   │   ├── bot_provider.dart               # Trading bot management
│   │   ├── upgrade_provider.dart           # Player progression
│   │   ├── prestige_provider.dart          # Reset mechanics
│   │   ├── tap_trade_provider.dart         # Manual trade simulation
│   │   └── xp_provider.dart                # XP with blockchain sync
│   │
│   ├── models/                     # Game data models
│   │   ├── game_state.dart                 # Overall progress tracking
│   │   ├── trading_bot.dart                # Bot properties & behavior
│   │   ├── upgrade.dart                    # Upgrade definitions
│   │   ├── prestige_tier.dart              # Prestige benefits
│   │   └── trade_result.dart               # Tap trade outcomes
│   │
│   ├── services/                   # Game logic services
│   │   ├── tap_trade_service.dart          # Mock trade simulation
│   │   ├── game_loop_service.dart          # Idle earnings calculation
│   │   ├── volatility_service.dart         # Market data integration
│   │   ├── save_game_service.dart          # SQLite persistence
│   │   └── animation_service.dart          # Game animations
│   │
│   ├── widgets/                    # Game UI components
│   │   ├── slot_machine_widget.dart        # Slot machine animations
│   │   ├── coin_shower_widget.dart         # Win celebration effects
│   │   ├── pnl_burst_widget.dart           # PnL display animations
│   │   └── bot_avatar_widget.dart          # Trading bot visuals
│   │
│   └── config/                     # Game configuration
│       ├── game_config.dart                # Game balance & progression
│       ├── animation_config.dart           # Animation parameters
│       └── bot_config.dart                 # Bot behavior settings
│
├── python_trading_service/          # Real trading backend
│   ├── main.py                     # FastAPI trading service
│   ├── extended_exchange_format.py # Extended Exchange integration
│   ├── real_starknet_service.py    # Blockchain service
│   └── requirements.txt            # Python dependencies
│
├── shared/                         # Cross-platform utilities
│   ├── types/                      # Unified type definitions
│   │   ├── trading_types.dart      # Trading data structures
│   │   ├── game_types.dart         # Game-specific types
│   │   └── blockchain_types.dart   # Blockchain interaction types
│   ├── utils/                      # Shared utilities
│   │   ├── crypto_utils.dart       # Cryptographic functions
│   │   └── validation_utils.dart   # Input validation
│   └── constants/                  # Configuration constants
│       ├── game_constants.dart     # Game balance constants
│       └── api_endpoints.dart      # API endpoint definitions
│
├── contracts/                      # Cairo smart contracts
│   ├── streetcred_xp/             # XP tracking & leaderboards
│   │   ├── src/xp_system.cairo    # Main XP contract
│   │   └── tests/                 # Contract tests
│   ├── streetcred_paymaster/      # AVNU gasless transactions
│   │   ├── src/avnu_paymaster.cairo # Paymaster contract
│   │   └── tests/                 # Paymaster tests
│   └── street_art_nft/           # Achievement NFTs
│       ├── src/achievement_nft.cairo # NFT contract
│       └── tests/                 # NFT tests
│
├── knowledge_base/                 # RAG system (dev tool only)
│   ├── backend/                   # FastAPI RAG server
│   ├── docs/                      # Documentation repository
│   └── manage_knowledge_base.sh   # Management script
│
├── docs/                          # Project documentation
│   ├── GAME_PIVOT_PLAN.md         # Casino game development plan
│   ├── PERP_TYCOON_PROJEC.md      # Game concept & mechanics
│   ├── PROJECT_STATUS.md          # Current development status
│   ├── TODO.md                    # Phase 1-4 development tasks
│   ├── ARCHITECTURE.md            # Casino game architecture
│   ├── FILE_STRUCTURE.md          # Project organization
│   └── *.md                       # Other documentation
│
└── scripts/                       # Development scripts
    ├── deployment/                # Contract deployment
    └── utilities/                 # Development utilities
```

## 🎯 Directory Purposes (Casino Game Focus)

### **🎮 Core Game Application (`/lib/`)**
- **`screens/game/`** - Main casino game interfaces
  - `casino_floor_screen.dart` - Tap-to-trade slot machine interface
  - `upgrade_shop_screen.dart` - Purchase trading improvements
  - `bot_management_screen.dart` - Hire and manage automated traders
  - `prestige_screen.dart` - Reset progress for permanent benefits
- **`providers/`** - Game state management using Riverpod
  - `game_state_provider.dart` - XP, cash, level progression
  - `bot_provider.dart` - Automated trading bot management
  - `idle_earnings_provider.dart` - Offline earnings calculation
- **`models/`** - Game data structures
  - `trading_bot.dart` - Bot properties and behavior
  - `upgrade.dart` - Player progression upgrades
  - `game_state.dart` - Overall game progress

### **🤖 Automation System**
- **Bot Management** - Idle earnings while offline
- **Upgrade System** - Win rate, multipliers, speed improvements
- **Prestige Mechanics** - Reset progress for Stark Token rewards
- **Offline Calculations** - `earnings = Σ(botYields * timeElapsed)`

### **⛓️ Blockchain Integration (`/contracts/`)**
- **`streetcred_xp/`** - On-chain XP tracking for leaderboards
- **`streetcred_paymaster/`** - AVNU-compatible gasless transactions
- **`street_art_nft/`** - Achievement NFTs for milestones

### **🔄 Real Trading (`/python_trading_service/`)**
- **Daily Real Trades** - One actual trade per day maximum
- **Extended Exchange API** - Real market trading integration
- **Volatility Integration** - Market data for realistic simulations

### **🧠 Development Tools (`/knowledge_base/`)**
- **RAG System** - Development context retrieval (not deployed)
- **Documentation** - SDK reference for development efficiency

## 📊 Game Architecture Layers

### **1. Presentation Layer (UI/UX)**
```
Casino Floor Interface → Slot Machine Animations → PnL Burst Effects
     ↓                        ↓                       ↓
Upgrade Shop Interface → Bot Management UI → Leaderboard Display
```

### **2. Game Logic Layer**
```
Tap Trade Simulation → Bot Automation → Idle Earnings → Prestige Reset
     ↓                     ↓               ↓              ↓
Win/Loss Calculation → Background Trading → Offline Math → Token Rewards
```

### **3. Data Persistence Layer**
```
SQLite Local Storage → Blockchain Sync → Real Trading API
     ↓                      ↓               ↓
Game Progress Save → XP Milestones → Daily Trade Limit
```

### **4. Integration Layer**
```
Market Volatility Data → Real Trading Service → Blockchain Contracts
     ↓                        ↓                      ↓
Simulation Engine → Extended Exchange API → NFT Minting
```

## 🎮 Game Development Flow

### **Phase 1: Core Game Loop**
1. Convert `trading_screen.dart` → `casino_floor_screen.dart`
2. Implement tap-to-trade with slot machine animations
3. Add XP bar and vault cash display
4. Create upgrade shop and bot management screens

### **Phase 2: Automation & Idle**
1. Build trading bot system with automated earnings
2. Implement offline earnings calculation
3. Add upgrade system for win rates and multipliers
4. Create game loop service for idle mechanics

### **Phase 3: Real Trading Integration**
1. Add "One Real Trade" daily functionality
2. Integrate existing Extended Exchange infrastructure
3. Implement NFT rewards for achievements
4. Add prestige reset with Stark Token minting

### **Phase 4: Social & Polish**
1. Global leaderboards and social features
2. Daily login bonuses and streak mechanics
3. Share functionality for viral growth
4. UI/UX polish with animations and haptics

## 🔧 Key Technology Stack

### **Game Framework**
- **Flutter 3.10+** with mobile focus
- **Riverpod** for reactive state management
- **SQLite** for local game persistence
- **Lottie/Rive** for slot machine animations

### **Blockchain Integration**
- **Starknet** L2 blockchain for scalability
- **Cairo** smart contracts for XP and NFTs
- **AVNU Paymaster** for gasless game transactions

### **Trading Integration**
- **Extended Exchange API** for real daily trades
- **Real-time Market Data** for volatility simulation
- **StarkEx Signatures** for trade authentication

### **Development Tools**
- **RAG Knowledge Base** for context retrieval
- **Automated Testing** for game balance
- **Performance Monitoring** for 60fps gameplay

## 🎯 Success Metrics

### **Game Engagement**
- **Daily Active Users** - Players returning for idle earnings
- **Session Length** - Time spent in casino floor interface
- **Retention Rate** - Weekly and monthly player retention
- **Viral Coefficient** - Social sharing and friend invitations

### **Trading Integration**
- **Real Trade Adoption** - Players using daily real trade feature
- **NFT Collection** - Achievement NFT minting rates
- **Blockchain Interaction** - XP sync and gasless transaction usage

### **Technical Performance**
- **60fps Gameplay** - Smooth animations and interactions
- **Offline Accuracy** - Precise idle earnings calculations
- **Load Times** - Fast app startup and screen transitions

---

**Last Updated**: 2025-01-10  
**Project Type**: Casino Idle Game  
**Infrastructure Status**: 100% Ready for Game Development  
**Next Phase**: Phase 1 - Core Game Loop Implementation