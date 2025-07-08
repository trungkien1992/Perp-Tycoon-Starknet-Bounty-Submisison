# Machine Environment & Setup Information

## 🖥️ System Information

**Working Directory**: `/Users/admin/streetcred-minimal/`  
**Platform**: macOS (Darwin 24.5.0)  
**Git Repository**: Yes, active repository  
**Current Branch**: main  
**Main Branch**: main  

## 📊 Repository Status

**Git Status**: Clean working directory (no uncommitted changes)

**Recent Commits**:
- `e59acd8` - Update the project
- `be8df41` - Contract deployment  
- `cd2049a` - Cairo NFT integration
- `808e31f` - Test the integrations
- `295c80e` - Extended API integration and paymaster support

## 🐍 Python Environment

**Location**: `/Users/admin/streetcred-minimal/rag_backend/`  
**Virtual Environment**: `venv/` (active)  
**Python Version**: 3.x  
**Package Manager**: pip  

### Core Dependencies
```
fastapi>=0.100.0
uvicorn>=0.20.0
chromadb>=0.4.0
sentence-transformers>=2.2.0
torch>=2.0.0
transformers>=4.30.0
langchain>=0.1.0
requests>=2.30.0
pandas>=2.0.0
numpy>=1.24.0
pydantic>=2.0.0
```

### RAG Backend Status
- **Server**: Running on http://localhost:8000
- **Health**: ✅ Operational
- **Vector Database**: ChromaDB initialized
- **Embedding Model**: sentence-transformers/all-MiniLM-L6-v2

## 📱 Flutter Environment

**Framework**: Flutter (latest stable)  
**Language**: Dart 3.x  
**Platform Support**: iOS, Android, Web  

### Key Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9
  go_router: ^12.1.1
  starknet: ^0.4.2
  starknet_provider: ^0.0.6
  pointycastle: ^3.7.3
  crypto: ^3.0.3
  http: ^1.1.0
  web_socket_channel: ^2.4.0
  sqflite: ^2.3.0
  dio: ^5.3.4
```

## 🌐 Network Configuration

### RAG Backend Endpoints
- **Health Check**: `GET http://localhost:8000/`
- **Search**: `POST http://localhost:8000/search`
- **Categories**: `GET http://localhost:8000/categories`
- **Metrics**: `GET http://localhost:8000/metrics`
- **Index**: `POST http://localhost:8000/index`
- **Optimize**: `POST http://localhost:8000/optimize`

### External APIs
- **Extended Exchange**: `https://api.extended.exchange`
- **Extended WebSocket**: `wss://ws.extended.exchange`
- **Starknet RPC**: Testnet/Mainnet endpoints

## 📁 Directory Structure

```
streetcred-minimal/
├── lib/                    # Flutter mobile app
│   ├── main.dart
│   ├── data/
│   ├── models/
│   ├── providers/
│   ├── screens/
│   └── services/
├── rag_backend/           # Python RAG system
│   ├── main.py           # FastAPI server
│   ├── categorization_system.py
│   ├── sdk_enhanced_indexer.py
│   ├── optimization_manager.py
│   ├── venv/             # Virtual environment
│   ├── chroma_db/        # Vector database
│   └── requirements.txt
├── contracts/            # Cairo smart contracts
│   ├── streetcred_xp/
│   ├── streetcred_paymaster/
│   └── street_art_nft/
├── docs/                 # Documentation
│   ├── ARCHITECTURE.md
│   ├── MACHINE_INFO.md
│   └── [other docs]
├── project-rules/        # Project guidelines
└── README.md
```

## 🔧 Development Tools

### Available Commands

**RAG Backend**:
```bash
cd rag_backend
source venv/bin/activate    # Activate virtual environment
python main.py             # Start RAG server
python test_rag.py          # Run system tests
python setup_enhanced.py   # Setup script
```

**Flutter App**:
```bash
flutter run                # Start development server
flutter test               # Run tests
flutter build ios          # Build for iOS
flutter build android      # Build for Android
```

**Smart Contracts**:
```bash
cd contracts/[contract_name]
scarb build                # Build Cairo contract
scarb test                 # Run tests
```

## 🗄️ Database Configuration

### ChromaDB (Vector Database)
- **Location**: `./rag_backend/chroma_db/`
- **Collection**: `starknet_dart_sdk`
- **Embedding Model**: `sentence-transformers/all-MiniLM-L6-v2`
- **Chunk Size**: 1000 tokens
- **Chunk Overlap**: 200 tokens

### SQLite (Flutter Local Storage)
- **Location**: Device-specific app data directory
- **Purpose**: Caching search results and user preferences
- **Schema**: Search history, user settings, offline data

## 🌍 Environment Variables

### RAG Backend (`.env`)
```bash
# Core Settings
CHROMA_DB_PATH=./chroma_db
EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2
CHUNK_SIZE=1000
CHUNK_OVERLAP=200

# Server Configuration
HOST=0.0.0.0
PORT=8000

# Platform URLs
EXTENDED_EXCHANGE_API_URL=https://api.extended.exchange
X10_GITHUB_URL=https://github.com/x10xchange/python_sdk
CAIRO_BOOK_URL=https://book.cairo-lang.org
STARKNET_DART_GITHUB=https://github.com/focustree/starknet.dart
```

### Flutter App
```bash
# Development mode (default)
APP_MODE=development

# Production mode
APP_MODE=real
EXTENDED_API_KEY=your_api_key_here
```

## 🔍 Monitoring & Diagnostics

### RAG Backend Health
- **Status**: ✅ Running
- **Documents Indexed**: 0 (ready for indexing)
- **Platforms**: 4 configured
- **Categories**: 18 available

### System Resources
- **Memory**: Check with `python test_rag.py`
- **Storage**: Vector database grows with indexed content
- **Network**: HTTP/WebSocket connections to external APIs

## 🚨 Common Issues & Solutions

### RAG Backend Issues
1. **Import Error**: Fixed LangChain import compatibility
2. **Virtual Environment**: Always activate before running
3. **Port Conflicts**: Default port 8000, change if needed
4. **Memory Usage**: Monitor with large document sets

### Flutter Issues
1. **SDK Version**: Ensure Flutter 3.10+ installed
2. **Platform Support**: Check iOS/Android SDK setup
3. **Network Permissions**: Configure for API access
4. **State Management**: Riverpod provider debugging

## 📊 Performance Characteristics

### RAG Backend
- **Startup Time**: ~3-5 seconds
- **Query Response**: ~14ms average
- **Memory Usage**: ~200MB base + indexed content
- **Concurrent Users**: Supports multiple simultaneous queries

### Flutter App
- **Build Time**: ~30-60 seconds
- **Hot Reload**: ~1-2 seconds
- **Memory Usage**: ~50-100MB typical
- **Rendering**: 60fps target performance

## 🔄 Update Procedures

### RAG Backend Updates
1. Pull latest changes
2. Update requirements: `pip install -r requirements.txt`
3. Restart server: `python main.py`
4. Re-index if needed: `curl -X POST http://localhost:8000/index`

### Flutter App Updates
1. Pull latest changes
2. Update dependencies: `flutter pub get`
3. Clean build: `flutter clean && flutter pub get`
4. Test: `flutter test`

---

**Last Updated**: 2025-01-08  
**System Status**: ✅ Operational  
**Next Health Check**: As needed