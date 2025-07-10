# Perp Tycoon - Casino Idle Game File Structure

## 📁 Project Root Structure

```
tycoon-project/
├── 🎮 lib/                          # Flutter casino game application
├── 🐍 python_trading_service/       # Real trading backend
├── 🔧 shared/                       # Cross-platform utilities
├── 📜 contracts/                    # Cairo smart contracts
├── 🧠 knowledge_base/               # RAG system (dev tool only)
├── 📚 docs/                         # Project documentation
└── 📖 README.md                     # Main project README
```

## 🎮 Flutter Casino Game (`/lib/`)

### Core Game Files
```
lib/
├── main.dart                        # App entry point with game routing
├── app_mode.dart                    # Mock/Real mode configuration
└── widgets/                         # Reusable game UI components
    ├── slot_machine_widget.dart     # Slot machine animation
    ├── coin_shower_widget.dart      # Win celebration effects
    ├── pnl_burst_widget.dart        # PnL display animations
    └── bot_avatar_widget.dart       # Trading bot visualizations
```

### Game Screens Layer
```
lib/screens/
├── auth/
│   ├── login_screen.dart            # Wallet connection
│   └── profile_screen.dart          # Player profile & stats
├── game/
│   ├── casino_floor_screen.dart     # Main tap-to-trade interface
│   ├── upgrade_shop_screen.dart     # Purchase trading improvements
│   ├── bot_management_screen.dart   # Hire & manage trading bots
│   ├── prestige_screen.dart         # Reset progress for Stark Tokens
│   └── welcome_back_screen.dart     # Offline earnings display
├── social/
│   ├── leaderboard_screen.dart      # Global rankings
│   └── achievement_screen.dart      # NFT collection & milestones
└── trading/
    ├── real_trade_screen.dart       # Daily real trade interface
    └── result_screen.dart           # Trade results & sharing
```

### Game State Management
```
lib/providers/
├── game_state_provider.dart         # Core game progress (XP, cash, level)
├── idle_earnings_provider.dart      # Offline bot earnings calculation
├── bot_provider.dart                # Trading bot management
├── upgrade_provider.dart            # Player progression & multipliers
├── prestige_provider.dart           # Reset mechanics & Stark Tokens
├── tap_trade_provider.dart          # Manual trade simulation
├── starknet_provider.dart           # Wallet & blockchain integration
└── xp_provider.dart                 # XP system with on-chain sync
```

### Game Models
```
lib/models/
├── game_state.dart                  # Overall game progress
├── trading_bot.dart                 # Bot properties & behavior
├── upgrade.dart                     # Upgrade definitions & effects
├── prestige_tier.dart               # Prestige benefits & requirements
├── trade_result.dart                # Tap trade outcomes
├── volatility_data.dart             # Market volatility information
└── achievement.dart                 # NFT achievements & rewards
```

### Game Services
```
lib/services/
├── tap_trade_service.dart           # Mock trade simulation engine
├── game_loop_service.dart           # Idle earnings & offline calculation
├── volatility_service.dart          # Real market data integration
├── save_game_service.dart           # SQLite persistence
├── animation_service.dart           # Coordinated game animations
├── real_trading_service.dart        # Daily real trade integration
└── notification_service.dart        # Push notifications & alerts
```

### Game Data Layer
```
lib/data/
├── datasources/
│   ├── market_data_source.dart      # Real-time market volatility
│   ├── extended_api_client.dart     # Real trading API client
│   └── rag_api_client.dart          # Knowledge base client
├── models/
│   ├── market_data.dart             # Live market information
│   ├── bot_config.dart              # Bot configuration data
│   └── upgrade_config.dart          # Upgrade system data
└── repositories/
    ├── game_repository.dart         # Game state persistence
    ├── bot_repository.dart          # Bot data management
    └── achievement_repository.dart  # Achievement tracking
```

### Game Configuration & Utils
```
lib/config/
├── game_config.dart                 # Game balance & progression
├── animation_config.dart            # Animation timing & effects
├── bot_config.dart                  # Bot behavior parameters
└── upgrade_config.dart              # Upgrade costs & effects

lib/utils/
├── game_math.dart                   # Idle calculations & formulas
├── animation_utils.dart             # Animation helpers
├── format_utils.dart                # Currency & number formatting
└── haptic_utils.dart                # Haptic feedback patterns
```

## 🐍 Real Trading Backend (`/python_trading_service/`)

### Core Trading Files
```
python_trading_service/
├── main.py                          # FastAPI trading service
├── extended_exchange_format.py      # Extended Exchange integration
├── real_starknet_service.py         # Starknet blockchain service
├── requirements.txt                 # Python dependencies
└── .env                             # Environment configuration
```

### Trading Modules
```
python_trading_service/
├── services/
│   ├── trading_engine.py            # Core trading logic
│   ├── volatility_calculator.py     # Market volatility analysis
│   ├── position_manager.py          # Position sizing & management
│   └── risk_manager.py              # Risk assessment & limits
├── models/
│   ├── trade_order.py               # Trading order structures
│   ├── market_data.py               # Market data models
│   └── user_account.py              # Account management
└── utils/
    ├── signature_utils.py           # StarkEx signature generation
    ├── api_utils.py                 # HTTP client utilities
    └── logging_utils.py             # Structured logging
```

## 🔧 Shared Utilities (`/shared/`)

### Cross-Platform Code
```
shared/
├── types/
│   ├── trading_types.dart           # Dart trading type definitions
│   ├── trading_types.py             # Python trading type definitions
│   ├── game_types.dart              # Game-specific data structures
│   └── blockchain_types.dart        # Blockchain interaction types
├── utils/
│   ├── crypto_utils.dart            # Cryptographic functions
│   ├── crypto_utils.py              # Python crypto utilities
│   ├── validation_utils.dart        # Input validation
│   └── error_handling.dart          # Unified error management
└── constants/
    ├── api_endpoints.dart            # API endpoint definitions
    ├── game_constants.dart          # Game balance constants
    └── blockchain_constants.dart     # Contract addresses & ABIs
```

## 📜 Smart Contracts (`/contracts/`)

### XP System Contract
```
contracts/streetcred_xp/
├── src/
│   ├── xp_system.cairo              # XP tracking & leaderboards
│   ├── achievement_tracker.cairo    # Milestone & achievement logic
│   └── interfaces/
│       └── ixp_system.cairo         # Interface definitions
├── tests/
│   ├── test_xp_tracking.cairo       # XP accumulation tests
│   └── test_achievements.cairo      # Achievement unlock tests
└── Scarb.toml                       # Cairo project configuration
```

### AVNU Paymaster Contract
```
contracts/streetcred_paymaster/
├── src/
│   ├── avnu_paymaster.cairo         # AVNU-compatible paymaster
│   ├── daily_limits.cairo           # Daily transaction limits
│   └── interfaces/
│       └── ipaymaster.cairo         # Paymaster interface
├── tests/
│   ├── test_gasless_transactions.cairo  # Gasless transaction tests
│   └── test_daily_limits.cairo      # Daily limit enforcement tests
└── Scarb.toml                       # Cairo project configuration
```

### Achievement NFT Contract
```
contracts/street_art_nft/
├── src/
│   ├── achievement_nft.cairo        # Game achievement NFTs
│   ├── prestige_tokens.cairo        # Stark Token rewards
│   ├── metadata_manager.cairo       # NFT metadata handling
│   └── interfaces/
│       └── iachievement_nft.cairo   # NFT interface definitions
├── tests/
│   ├── test_nft_minting.cairo       # NFT creation tests
│   └── test_prestige_tokens.cairo   # Stark Token tests
└── Scarb.toml                       # Cairo project configuration
```

## 🧠 Knowledge Base RAG (`/knowledge_base/`) - DEV TOOL ONLY

### RAG System Files
```
knowledge_base/
├── backend/
│   ├── main.py                      # FastAPI RAG server
│   ├── categorization_system.py     # Document categorization
│   ├── sdk_enhanced_indexer.py      # Multi-platform indexer
│   └── optimization_manager.py      # Performance optimization
├── chroma_db/                       # Vector database storage
├── data/                            # Indexed documentation
└── scripts/                         # Management scripts
```

**⚠️ NOTE**: This is a development tool for Claude context retrieval only, NOT part of the game.

## 📚 Documentation (`/docs/`)

### Game Documentation
```
docs/
├── GAME_PIVOT_PLAN.md               # ✅ Casino game development plan
├── PERP_TYCOON_PROJEC.md           # ✅ Game concept & mechanics
├── PROJECT_STATUS.md                # ✅ Current development status
├── TODO.md                          # ✅ Phase 1-4 development tasks
├── ARCHITECTURE.md                  # ✅ Casino game architecture
├── FILE_STRUCTURE.md                # ✅ This file - project organization
├── PROJECT_STRUCTURE.md             # 📋 High-level project structure
├── CONTEXT_PRIME.md                 # 📋 Game context & vision
└── KNOWLEDGE_BASE.md                # 📋 Game mechanics documentation
```

### Technical Documentation
```
docs/
├── LOW_LEVEL_INSTRUCTIONS.md        # ✅ Preserved development instructions
├── SECURITY.md                      # ✅ Security best practices
├── TROUBLESHOOTING.md               # ✅ Known issues & solutions
├── CAIRO_CONTRACTS_README.md        # ✅ Smart contract documentation
└── COLLABORATION_GUIDE.md           # ✅ Development collaboration guide
```

### Legacy Documentation (To Be Updated/Removed)
```
docs/
├── EXTENDED_EXCHANGE_SUPPORT_MESSAGE.md  # 📋 Trading API support
├── SESSION_PROGRESS_2025_01_09.md        # 📋 Legacy session notes
└── STARKNET_developer_docs.md            # 📋 Blockchain integration docs
```

## 🎮 Game-Specific File Categories

### 🎯 Core Game Loop (Critical)
- `lib/screens/casino_floor_screen.dart` - Main game interface
- `lib/providers/game_state_provider.dart` - Core game state
- `lib/services/tap_trade_service.dart` - Trade simulation engine
- `lib/models/trading_bot.dart` - Bot system core
- `lib/services/game_loop_service.dart` - Idle calculations

### 🤖 Automation System (Important)
- `lib/providers/bot_provider.dart` - Bot management
- `lib/providers/idle_earnings_provider.dart` - Offline earnings
- `lib/screens/bot_management_screen.dart` - Bot UI
- `lib/models/upgrade.dart` - Progression system

### 💎 Progression & Prestige (Important)
- `lib/providers/prestige_provider.dart` - Reset mechanics
- `lib/screens/upgrade_shop_screen.dart` - Player progression
- `lib/screens/prestige_screen.dart` - Prestige interface
- `contracts/street_art_nft/src/prestige_tokens.cairo` - Stark Tokens

### 🎨 Visual & Animation (Important)
- `lib/widgets/slot_machine_widget.dart` - Main game animations
- `lib/widgets/coin_shower_widget.dart` - Win celebrations
- `lib/services/animation_service.dart` - Animation coordination
- `lib/config/animation_config.dart` - Animation parameters

### ⛓️ Blockchain Integration (Supporting)
- `contracts/streetcred_xp/` - XP tracking contracts
- `contracts/streetcred_paymaster/` - Gasless transactions
- `python_trading_service/` - Real trading backend
- `lib/providers/starknet_provider.dart` - Wallet integration

### 📊 Data & Persistence (Supporting)
- `lib/services/save_game_service.dart` - Game state persistence
- `lib/data/repositories/` - Data management
- `shared/types/` - Cross-platform data structures
- `lib/config/game_config.dart` - Game balance

## 🔍 Navigation Tips for Game Development

### Finding Game Files by Feature
- **Tap Trading**: `lib/screens/casino_floor_screen.dart` + `lib/services/tap_trade_service.dart`
- **Idle Bots**: `lib/providers/bot_provider.dart` + `lib/models/trading_bot.dart`
- **Upgrades**: `lib/screens/upgrade_shop_screen.dart` + `lib/providers/upgrade_provider.dart`
- **Prestige**: `lib/screens/prestige_screen.dart` + `lib/providers/prestige_provider.dart`
- **Animations**: `lib/widgets/*_widget.dart` + `lib/services/animation_service.dart`
- **Real Trading**: `python_trading_service/` + `lib/screens/real_trade_screen.dart`

### Game Development Patterns
- **Game Screens**: `*_screen.dart` in `lib/screens/game/`
- **Game Providers**: `*_provider.dart` in `lib/providers/`
- **Game Models**: `*_model.dart` or `*.dart` in `lib/models/`
- **Game Services**: `*_service.dart` in `lib/services/`
- **Game Widgets**: `*_widget.dart` in `lib/widgets/`
- **Game Config**: `*_config.dart` in `lib/config/`

### Development Phase File Priorities

#### Phase 1 - Core Game Loop
1. `lib/screens/casino_floor_screen.dart`
2. `lib/providers/game_state_provider.dart`
3. `lib/services/tap_trade_service.dart`
4. `lib/widgets/slot_machine_widget.dart`
5. `lib/models/game_state.dart`

#### Phase 2 - Bots & Idle
1. `lib/providers/bot_provider.dart`
2. `lib/services/game_loop_service.dart`
3. `lib/screens/bot_management_screen.dart`
4. `lib/models/trading_bot.dart`
5. `lib/providers/idle_earnings_provider.dart`

#### Phase 3 - Real Trading
1. `lib/screens/real_trade_screen.dart`
2. `python_trading_service/main.py`
3. `contracts/streetcred_xp/src/xp_system.cairo`
4. `lib/providers/prestige_provider.dart`
5. `contracts/street_art_nft/src/achievement_nft.cairo`

#### Phase 4 - Social & Polish
1. `lib/screens/leaderboard_screen.dart`
2. `lib/services/animation_service.dart`
3. `lib/widgets/coin_shower_widget.dart`
4. `lib/screens/achievement_screen.dart`
5. Social sharing utilities

---

**Last Updated**: 2025-01-10  
**Game Version**: Perp Tycoon Casino Idle Game  
**Total Files**: ~200+ files across all directories  
**Next Review**: After Phase 1 implementation begins