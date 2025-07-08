# StreetCred Minimal - Multi-Platform RAG System

## 🚀 Quick Start for New Claude Sessions

**IMPORTANT: At the start of each new chat session, please read these files in order:**

1. **[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)** - Complete system architecture overview
2. **[docs/MACHINE_INFO.md](docs/MACHINE_INFO.md)** - Machine environment and setup details
3. **[docs/PROJECT_STATUS.md](docs/PROJECT_STATUS.md)** - Current progress and completed work
4. **[docs/TODO.md](docs/TODO.md)** - Active tasks and priorities
5. **[docs/COLLABORATION_GUIDE.md](docs/COLLABORATION_GUIDE.md)** - Working protocols and guidelines
6. **[docs/MEMORIES.md](docs/MEMORIES.md)** - Important decisions and context from past sessions
7. **[docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)** - Known issues and solutions

**Additional Resources:**
- **[docs/FILE_STRUCTURE.md](docs/FILE_STRUCTURE.md)** - Complete file organization
- **[docs/WRAP_UP_PROTOCOL.md](docs/WRAP_UP_PROTOCOL.md)** - Session conclusion procedures

## 📋 Project Overview

StreetCred Minimal is a production-ready gamified mobile trading app targeting Gen-Z users for the **StarkWare Bounty Program**, enhanced with a comprehensive multi-platform RAG (Retrieval-Augmented Generation) system that provides intelligent search and knowledge management across multiple SDKs and platforms.

### 🎯 StarkWare Bounty Submission
**Mission**: Create the most addictive mobile trading game for Gen-Z users (18-28) with up to $1M funding potential.
**Target**: Swipe-based trading with ecosystem growth, achievement NFTs, and viral social features.

### 🧠 Enhanced RAG System
- **Extended Exchange API** - Perpetual futures trading platform documentation
- **X10 Python SDK** - Python client for Extended Exchange
- **Cairo Smart Contracts** - Starknet blockchain development guides
- **Starknet.dart** - Flutter/Dart mobile SDK integration

## 🏗️ Architecture

### Core Components

1. **Flutter Frontend** (`/lib/`) - Mobile-first UI with advanced search capabilities
2. **Python RAG Backend** (`/rag_backend/`) - FastAPI-based RAG service with ChromaDB
3. **Smart Contracts** (`/contracts/`) - Cairo contracts for XP, paymaster, and NFTs
4. **Documentation System** (`/docs/`) - Comprehensive project documentation

### Key Features

- **Multi-platform search** across 4 different SDK platforms
- **AI-powered categorization** with 18 categories
- **Performance optimization** with automated cleanup
- **Real-time health monitoring** and metrics
- **Advanced filtering** and suggestion system
- **Gamified trading** with swipe-based interface
- **Blockchain integration** with gasless transactions

## 🚀 Core Features

### Trading & Blockchain
- **Real Trading**: ETH-USD perpetual futures via Extended Exchange API
- **Starknet Integration**: Blockchain-powered authentication with cryptographic signatures
- **🔥 GASLESS TRANSACTIONS**: Zero gas fees via Starknet paymaster for mass adoption
- **Live Market Data**: Real-time WebSocket price feeds
- **Smart Contracts**: Cairo-based XP system and achievement NFTs

### Mobile Gaming Experience
- **Swipe Trading**: TikTok-style up/down swipe mechanics
- **Ecosystem Growth**: Personal castle/garden that grows with trading success
- **Achievement System**: Collectible NFT milestones for trading accomplishments
- **XP & Streaks**: Gamified progression with daily streak rewards
- **Social Features**: Leaderboards, friend battles, and shareable wins

### Advanced SDK Knowledge Base
- **Multi-Platform RAG**: Intelligent search across 4 major SDKs
- **Extended Exchange API**: Complete trading documentation and examples
- **X10 Python SDK**: Client library integration and best practices
- **Cairo Smart Contracts**: Development guides and OpenZeppelin patterns
- **Starknet.dart**: Mobile integration and Flutter development

## 🛠️ Quick Commands

```bash
# Start RAG Backend
cd rag_backend
source venv/bin/activate
python main.py

# Test RAG System
cd rag_backend
source venv/bin/activate
python test_rag.py

# Start Flutter App
flutter run

# Run Tests
flutter test
```

## 📊 Current Status

- ✅ **RAG Backend**: Fully operational on http://localhost:8000
- ✅ **Multi-platform integration**: Complete (4 platforms)
- ✅ **Search functionality**: Working with 14ms average response time
- ✅ **Categorization system**: Active with 18 categories
- ✅ **Flutter frontend**: Implemented with full UI
- ✅ **Smart contracts**: Built and ready for deployment
- 📋 **Documentation indexing**: Ready to execute

## 🔧 Development Environment

- **Platform**: macOS (Darwin 24.5.0)
- **Python**: 3.x with virtual environment
- **Flutter**: Latest stable
- **Database**: ChromaDB vector database
- **API**: FastAPI with sentence transformers

## 📁 Project Structure

```
streetcred-minimal/
├── lib/                         # Flutter mobile app
│   ├── main.dart               # App entry point with routing
│   ├── app_mode.dart           # Mock/Real mode configuration
│   ├── data/                   # Data sources and models
│   ├── providers/              # State management
│   ├── screens/                # UI screens
│   └── services/               # Business logic
├── rag_backend/                # Python RAG system
│   ├── main.py                 # FastAPI RAG server
│   ├── categorization_system.py # AI categorization
│   ├── sdk_enhanced_indexer.py # Multi-platform indexer
│   ├── optimization_manager.py # Performance optimization
│   └── venv/                   # Virtual environment
├── contracts/                  # Cairo smart contracts
│   ├── streetcred_xp/         # XP tracking system
│   ├── streetcred_paymaster/  # Gasless transaction sponsor
│   └── street_art_nft/        # Achievement NFT system
└── docs/                      # Comprehensive documentation
    ├── ARCHITECTURE.md        # System design
    ├── TODO.md               # Current tasks
    └── [8 other doc files]   # Complete project context
```

## 📚 Documentation Structure

The `/docs/` directory contains complete project documentation:

- **ARCHITECTURE.md** - System design and component relationships
- **MACHINE_INFO.md** - Environment setup and dependencies
- **PROJECT_STATUS.md** - Completed work and current state
- **TODO.md** - Active tasks and upcoming work
- **COLLABORATION_GUIDE.md** - Working protocols for Claude sessions
- **MEMORIES.md** - Important decisions and context
- **TROUBLESHOOTING.md** - Known issues and solutions
- **FILE_STRUCTURE.md** - Complete file organization
- **WRAP_UP_PROTOCOL.md** - Session conclusion procedures

## 🤝 Collaboration Protocol

1. **Start each session** by reading the documentation files above
2. **Use TodoWrite tool** frequently to track progress
3. **Update relevant docs** as work progresses
4. **Test thoroughly** after each change
5. **Commit changes** with descriptive messages
6. **Follow wrap-up protocol** when concluding sessions

## 🎯 Getting Started

### Prerequisites
- Flutter 3.10+ with mobile and web support
- Dart 3.0+
- Python 3.10+ (for RAG backend)
- Extended Exchange API key (optional for real trading)

### Quick Setup

1. **Install Flutter Dependencies**
   ```bash
   flutter pub get
   ```

2. **Setup RAG Knowledge Base**
   ```bash
   cd rag_backend
   python setup_enhanced.py
   ./start_rag.sh
   ```

3. **Run Mobile App (Development)**
   ```bash
   flutter run
   ```

4. **Index SDK Documentation**
   ```bash
   curl -X POST http://localhost:8000/index -H "Content-Type: application/json" -d '{"platforms": ["all"]}'
   ```

## 📈 Next Steps

See [docs/TODO.md](docs/TODO.md) for current priorities and upcoming work.

## 🔄 Session Management

### For Claude Sessions
- **Always start** by reading documentation files
- **Update documentation** as you work
- **Use TodoWrite tool** for progress tracking
- **Follow collaboration guide** for consistency
- **Execute wrap-up protocol** when ending sessions

### For Development
- **Test frequently** after changes
- **Commit regularly** with good messages
- **Maintain documentation** currency
- **Follow established patterns** in codebase

---

**Last Updated**: 2025-01-08
**Version**: 1.0.0
**Status**: Active Development with Comprehensive Documentation
**Next Session**: Read docs/ files first, then check TODO.md for priorities