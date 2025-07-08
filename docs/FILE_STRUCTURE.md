# File Structure - Complete Project Organization

## 📁 Project Root Structure

```
streetcred-minimal/
├── 📱 lib/                          # Flutter mobile application
├── 🐍 rag_backend/                  # Python RAG system
├── 📜 contracts/                    # Cairo smart contracts
├── 📚 docs/                         # Project documentation
├── ⚙️ project-rules/                # Project guidelines
├── 🔧 Configuration files           # Root config files
└── 📖 README.md                     # Main project README
```

## 📱 Flutter Application (`/lib/`)

### Core Application Files
```
lib/
├── main.dart                        # App entry point with routing
├── app_mode.dart                    # Mock/Real mode configuration
└── widgets/                         # Reusable UI components
    └── common/                      # Common widgets
```

### Data Layer
```
lib/data/
├── datasources/                     # External data sources
│   ├── extended_api_client.dart     # Extended Exchange API client
│   └── rag_api_client.dart          # RAG backend API client
├── models/                          # Data models
│   ├── auth_state.dart              # Authentication state model
│   ├── trade_model.dart             # Trading data models
│   └── search_model.dart            # Search result models
└── providers/                       # Data providers
    ├── extended_provider.dart       # Trading service providers
    └── rag_provider.dart            # RAG service providers
```

### Business Logic Layer
```
lib/providers/
├── auth_provider.dart               # Authentication state management
├── rag_provider.dart                # SDK knowledge base provider
├── starknet_provider.dart           # Starknet wallet management
├── paymaster_provider.dart          # Paymaster state management
├── trading_provider.dart            # Trading state management
└── xp_provider.dart                 # XP system provider
```

### Presentation Layer
```
lib/screens/
├── auth/
│   ├── login_screen.dart            # Mock login interface
│   └── profile_screen.dart          # User profile management
├── trading/
│   ├── trading_screen.dart          # Real ETH-USD trading interface
│   ├── result_screen.dart           # Trade result and order details
│   └── portfolio_screen.dart        # Portfolio overview
├── knowledge/
│   ├── rag_search_screen.dart       # SDK knowledge search
│   └── documentation_screen.dart    # Documentation viewer
└── social/
    ├── leaderboard_screen.dart      # Social rankings
    └── achievements_screen.dart     # Achievement display
```

### Service Layer
```
lib/services/
├── starknet_service.dart            # Blockchain account & signing
├── paymaster_service.dart           # Gasless transaction service
├── rag_client_service.dart          # RAG knowledge base client
├── trading_service.dart             # Trading API integration
└── notification_service.dart        # Push notifications
```

### Configuration & Utilities
```
lib/config/
├── app_config.dart                  # Application configuration
├── api_config.dart                  # API endpoint configuration
└── theme_config.dart                # UI theme configuration

lib/utils/
├── crypto_utils.dart                # Cryptographic utilities
├── format_utils.dart                # Data formatting utilities
└── validation_utils.dart            # Input validation utilities
```

## 🐍 RAG Backend (`/rag_backend/`)

### Core Application Files
```
rag_backend/
├── main.py                          # FastAPI server entry point
├── requirements.txt                 # Python dependencies
├── .env                             # Environment configuration
├── start_rag.sh                     # Startup script
├── test_rag.py                      # System test suite
└── setup_enhanced.py                # Enhanced setup script
```

### Core Modules
```
rag_backend/
├── categorization_system.py         # AI-powered document categorization
├── sdk_enhanced_indexer.py          # Multi-platform SDK indexer
├── optimization_manager.py          # Performance optimization
└── api/                             # API modules
    ├── search_api.py                # Search endpoints
    ├── categories_api.py             # Category management
    └── metrics_api.py               # System metrics
```

### Data & Storage
```
rag_backend/
├── chroma_db/                       # ChromaDB vector database
│   ├── chroma.sqlite3               # SQLite database file
│   └── [uuid]/                      # Collection data
├── cache/                           # Cached embeddings and data
├── logs/                            # Application logs
└── data/                            # Raw documentation data
    ├── extended_exchange/           # Extended Exchange docs
    ├── x10_python/                  # X10 Python SDK docs
    ├── cairo_contracts/             # Cairo development docs
    └── starknet_dart/               # Starknet.dart docs
```

### Configuration & Scripts
```
rag_backend/
├── config/
│   ├── embedding_config.py          # Embedding model configuration
│   ├── database_config.py           # Database configuration
│   └── api_config.py                # API configuration
├── scripts/
│   ├── index_documents.py           # Document indexing script
│   ├── optimize_database.py         # Database optimization
│   └── health_check.py              # System health monitoring
└── tests/
    ├── test_search.py               # Search functionality tests
    ├── test_categorization.py       # Categorization tests
    └── test_performance.py          # Performance tests
```

### Virtual Environment
```
rag_backend/venv/                    # Python virtual environment
├── bin/                             # Executables
├── lib/                             # Python packages
├── include/                         # Header files
└── pyvenv.cfg                       # Virtual environment config
```

## 📜 Smart Contracts (`/contracts/`)

### XP System Contract
```
contracts/streetcred_xp/
├── src/
│   ├── xp_system.cairo              # Main XP tracking contract
│   ├── lib.cairo                    # Library functions
│   └── interfaces/
│       └── ixp_system.cairo         # Interface definitions
├── tests/
│   ├── test_xp_system.cairo         # Contract tests
│   └── test_lib.cairo               # Library tests
├── Scarb.toml                       # Cairo project configuration
└── deployment.json                  # Deployment configuration
```

### Paymaster Contract
```
contracts/streetcred_paymaster/
├── src/
│   ├── paymaster.cairo              # Main paymaster contract
│   ├── lib.cairo                    # Library functions
│   └── interfaces/
│       └── ipaymaster.cairo         # Interface definitions
├── tests/
│   ├── test_paymaster.cairo         # Contract tests
│   └── test_sponsorship.cairo       # Sponsorship tests
├── Scarb.toml                       # Cairo project configuration
└── deployment.json                  # Deployment configuration
```

### Achievement NFT Contract
```
contracts/street_art_nft/
├── src/
│   ├── achievement_nft.cairo        # Main NFT contract
│   ├── metadata.cairo               # NFT metadata handling
│   └── interfaces/
│       └── iachievement_nft.cairo   # Interface definitions
├── tests/
│   ├── test_nft.cairo               # NFT functionality tests
│   └── test_metadata.cairo          # Metadata tests
├── Scarb.toml                       # Cairo project configuration
└── deployment.json                  # Deployment configuration
```

### Deployment Scripts
```
contracts/scripts/
├── deploy_xp_system.py              # XP system deployment
├── deploy_paymaster.py              # Paymaster deployment
├── deploy_nft_system.py             # NFT system deployment
└── utils/
    ├── contract_utils.py             # Contract utilities
    └── deployment_utils.py           # Deployment utilities
```

## 📚 Documentation (`/docs/`)

### Core Documentation
```
docs/
├── ARCHITECTURE.md                  # ✅ System architecture overview
├── MACHINE_INFO.md                  # ✅ Environment & setup information
├── PROJECT_STATUS.md                # ✅ Current progress & status
├── TODO.md                          # ✅ Active tasks & priorities
├── COLLABORATION_GUIDE.md           # ✅ Working protocols for Claude
├── MEMORIES.md                      # ✅ Important context & decisions
├── TROUBLESHOOTING.md               # ✅ Known issues & solutions
└── FILE_STRUCTURE.md                # ✅ This file - complete organization
```

### Technical Documentation
```
docs/
├── WRAP_UP_PROTOCOL.md              # 📋 Session conclusion procedures
├── API_REFERENCE.md                 # 📋 Complete API documentation
├── DEPLOYMENT_GUIDE.md              # 📋 Deployment instructions
└── SECURITY_GUIDE.md                # 📋 Security best practices
```

### User Documentation
```
docs/
├── USER_GUIDE.md                    # 📋 End-user instructions
├── DEVELOPER_GUIDE.md               # 📋 Developer setup guide
└── CONTRIBUTING.md                  # 📋 Contribution guidelines
```

## ⚙️ Project Rules (`/project-rules/`)

### Development Guidelines
```
project-rules/
├── code_style.md                    # Code formatting standards
├── testing_requirements.md          # Testing protocols
├── security_guidelines.md           # Security requirements
└── performance_standards.md         # Performance criteria
```

## 🔧 Configuration Files

### Root Configuration
```
streetcred-minimal/
├── .gitignore                       # Git ignore patterns
├── .env.example                     # Environment variable template
├── pubspec.yaml                     # Flutter dependencies
├── analysis_options.yaml            # Dart analysis configuration
└── README.md                        # Main project documentation
```

### Flutter Configuration
```
streetcred-minimal/
├── android/                         # Android platform configuration
├── ios/                             # iOS platform configuration
├── web/                             # Web platform configuration
├── linux/                           # Linux platform configuration
├── macos/                           # macOS platform configuration
└── windows/                         # Windows platform configuration
```

### Development Tools
```
streetcred-minimal/
├── .vscode/                         # VS Code configuration
│   ├── launch.json                  # Debug configuration
│   └── settings.json                # Editor settings
├── .github/                         # GitHub Actions (future)
│   └── workflows/                   # CI/CD workflows
└── scripts/                         # Development scripts
    ├── build.sh                     # Build script
    ├── test.sh                      # Test script
    └── deploy.sh                    # Deployment script
```

## 📊 File Categories

### 🔧 Core Functionality (Critical)
- `lib/main.dart` - Application entry point
- `lib/providers/` - State management
- `lib/services/` - Business logic
- `rag_backend/main.py` - RAG server
- `rag_backend/categorization_system.py` - Document categorization
- `contracts/*/src/*.cairo` - Smart contracts

### 📱 User Interface (Important)
- `lib/screens/` - User interface screens
- `lib/widgets/` - Reusable components
- `lib/config/theme_config.dart` - UI theming

### 🗄️ Data Management (Important)
- `lib/data/` - Data layer
- `rag_backend/chroma_db/` - Vector database
- `rag_backend/cache/` - Cached data

### 🧪 Testing (Important)
- `test/` - Flutter tests
- `rag_backend/tests/` - Backend tests
- `contracts/*/tests/` - Contract tests

### 📚 Documentation (Supporting)
- `docs/` - All documentation
- `README.md` - Main documentation
- `project-rules/` - Guidelines

### ⚙️ Configuration (Supporting)
- `pubspec.yaml` - Flutter dependencies
- `rag_backend/requirements.txt` - Python dependencies
- `contracts/*/Scarb.toml` - Cairo configurations
- `.env` files - Environment variables

## 🔍 Navigation Tips

### Finding Files by Purpose
- **API Integration**: `lib/data/datasources/` or `lib/services/`
- **User Interface**: `lib/screens/` or `lib/widgets/`
- **Business Logic**: `lib/providers/`
- **Database**: `rag_backend/chroma_db/`
- **Documentation**: `docs/` or `README.md`
- **Configuration**: Root level or `lib/config/`

### Common File Patterns
- **Models**: `*_model.dart` in `lib/data/models/`
- **Providers**: `*_provider.dart` in `lib/providers/`
- **Screens**: `*_screen.dart` in `lib/screens/`
- **Services**: `*_service.dart` in `lib/services/`
- **Tests**: `test_*.py` or `*_test.dart`
- **Configs**: `*_config.dart` or `*.toml`

### File Naming Conventions
- **Dart**: `snake_case.dart`
- **Python**: `snake_case.py`
- **Cairo**: `snake_case.cairo`
- **Documentation**: `UPPER_CASE.md`
- **Configuration**: `lowercase.yaml/.toml/.json`

---

**Last Updated**: 2025-01-08  
**Total Files**: ~150+ files across all directories  
**Next Review**: When significant structural changes are made