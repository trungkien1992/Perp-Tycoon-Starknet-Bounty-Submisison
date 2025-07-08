# StreetCred Minimal

A production-ready gamified mobile trading app targeting Gen-Z users for the **StarkWare Bounty Program**. Features real Extended Exchange API integration, advanced SDK knowledge base, and comprehensive smart contract development tools.

## 🎯 StarkWare Bounty Submission

**Mission**: Create the most addictive mobile trading game for Gen-Z users (18-28) with up to $1M funding potential.

**Target**: Swipe-based trading with ecosystem growth, achievement NFTs, and viral social features.

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

## 📁 Project Structure

```
streetcred-minimal/
├── lib/                         # Flutter mobile app
│   ├── main.dart               # App entry point with routing
│   ├── app_mode.dart           # Mock/Real mode configuration
│   ├── data/
│   │   ├── datasources/
│   │   │   └── extended_api_client.dart # Extended Exchange API client
│   │   └── providers/
│   │       └── extended_provider.dart   # Trading service providers
│   ├── models/
│   │   └── auth_state.dart     # Authentication state model
│   ├── providers/
│   │   ├── auth_provider.dart  # Authentication provider
│   │   ├── rag_provider.dart   # SDK knowledge base provider
│   │   ├── starknet_provider.dart # Starknet wallet management
│   │   ├── paymaster_provider.dart # Paymaster state management
│   │   └── xp_provider.dart    # XP management provider
│   ├── screens/
│   │   ├── login_screen.dart   # Mock login interface
│   │   ├── trading_screen.dart # Real ETH-USD trading interface
│   │   ├── rag_search_screen.dart # SDK knowledge search
│   │   └── result_screen.dart  # Trade result and order details
│   └── services/
│       ├── starknet_service.dart    # Blockchain account & signing
│       ├── paymaster_service.dart   # Gasless transaction service
│       └── rag_client_service.dart  # RAG knowledge base client
├── rag_backend/                # Python RAG system
│   ├── main.py                 # FastAPI RAG server
│   ├── categorization_system.py # Intelligent document categorization
│   ├── sdk_enhanced_indexer.py # Multi-platform SDK indexer
│   ├── optimization_manager.py # Performance optimization
│   └── setup_enhanced.py       # Enhanced setup script
├── contracts/                  # Cairo smart contracts
│   ├── streetcred_xp/         # XP tracking system
│   ├── streetcred_paymaster/  # Gasless transaction sponsor
│   └── street_art_nft/        # Achievement NFT system
└── docs/
    └── CONTEXT_PRIME.md       # Complete project context
```

## 🚀 Getting Started

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
   *Safe development mode with mock trading and full SDK knowledge base*

4. **Run with Real Trading**
   ```bash
   flutter run --dart-define=APP_MODE=real --dart-define=EXTENDED_API_KEY=your_api_key
   ```
   *Production mode with real Extended API calls*

### Full System Setup

1. **RAG Backend Setup**
   ```bash
   cd rag_backend
   python setup_enhanced.py      # Install and configure
   python main.py               # Start RAG server
   
   # Index all SDK documentation
   curl -X POST http://localhost:8000/index
   
   # Test search
   curl -X POST http://localhost:8000/search \
     -d '{"query": "how to place order Extended Exchange"}'
   ```

2. **Smart Contract Deployment**
   ```bash
   # Deploy XP system
   cd contracts/streetcred_xp
   scarb build
   starkli declare target/dev/streetcred_xp.contract_class.json
   
   # Deploy paymaster
   cd ../streetcred_paymaster
   scarb build
   starkli deploy <class_hash> <constructor_args>
   ```

3. **Mobile App with Full Features**
   ```bash
   # Development with knowledge base
   flutter run -d ios  # or android
   
   # Production build
   flutter build ios --dart-define=APP_MODE=real
   ```

## 🎮 Usage

### Gaming Flow
1. **Login**: Enter username to access the gamified trading interface
2. **Ecosystem View**: Check your growing castle/garden and current XP level
3. **Swipe Trading**: Swipe up for LONG, down for SHORT on ETH-USD
4. **Achievement Unlock**: Earn NFT achievements for milestones
5. **Social Features**: Check leaderboards and friend rankings
6. **Knowledge Search**: Access comprehensive SDK documentation

### Core Features

#### 🎮 Gamified Trading
- **Swipe Mechanics**: TikTok-style gesture trading
- **Ecosystem Growth**: Visual representation of trading success
- **Achievement NFTs**: Collectible milestones (first trade, streaks, profits)
- **XP & Levels**: Progression system with daily bonuses
- **Social Competition**: Leaderboards, clan battles, friend challenges

#### 📚 SDK Knowledge Base
- **Multi-Platform Search**: Query across Extended Exchange, X10 Python, Cairo, Starknet.dart
- **Intelligent Categorization**: AI-powered content organization
- **Code Examples**: Working implementations and tutorials
- **Best Practices**: Security patterns and optimization guides
- **Real-time Suggestions**: Context-aware search recommendations

#### 🔗 Blockchain Integration
- **Gasless Transactions**: Zero fees via Starknet paymaster
- **Smart Contract XP**: On-chain experience point tracking
- **Achievement NFTs**: Blockchain-verified accomplishments
- **Cross-chain Support**: Ethereum and Starknet interoperability

### App Modes

#### 🟡 Development Mode
- **Purpose**: Safe testing and development
- **Trading**: Simulated with gamified feedback
- **Ecosystem**: Mock growth with visual effects
- **SDK Access**: Full knowledge base functionality
- **Risk**: Zero - no real trades or transactions

#### 🔴 Production Mode
- **Purpose**: Real trading with gamified experience
- **Trading**: Actual Extended Exchange API integration
- **Ecosystem**: Real progress tied to trading performance
- **Achievements**: Actual NFT minting on blockchain
- **Risk**: Real money - production trading environment

## 🔧 Technology Stack

### Mobile App (Flutter)
- `flutter`: Cross-platform mobile framework
- `flutter_riverpod`: Reactive state management
- `go_router`: Declarative routing and navigation
- `sqflite`: Local database for caching

### Blockchain & Trading
- `starknet`: Starknet blockchain integration
- `starknet_provider`: Starknet wallet provider  
- `pointycastle`: Cryptographic operations
- `crypto`: Hash functions and signatures
- `http`: REST API client for Extended Exchange
- `web_socket_channel`: Real-time market data streaming
- `dio`: HTTP client for paymaster API calls

### RAG Knowledge Base (Python)
- `fastapi`: High-performance web framework
- `chromadb`: Vector database for semantic search
- `sentence-transformers`: AI embeddings for document similarity
- `langchain`: Document processing and chunking
- `requests`: HTTP client for fetching documentation
- `pandas`: Data processing and analysis

### Smart Contracts (Cairo)
- `scarb`: Cairo package manager and build tool
- `starknet_foundry`: Testing framework for Cairo
- `openzeppelin`: Security-audited contract library
- `starkli`: Starknet CLI for deployment

## 🏗️ Architecture

### State Management
- **Riverpod**: Reactive state management with providers
- **StarknetProvider**: Blockchain wallet connection state
- **ExtendedProvider**: Trading service and market data
- **PaymasterProvider**: Gasless transaction state management
- **AuthProvider**: User authentication state

### Data Flow
```
UI Layer (Screens) 
    ↓
Providers (Riverpod)
    ↓
Services (Starknet + Extended API + Paymaster)
    ↓
External APIs (Extended Exchange + WebSocket + Starknet RPC)
```

### Trading Pipeline
1. **Market Data**: WebSocket → ExtendedProvider → Trading Screen
2. **Gasless Trade**: UI → PaymasterService (sponsorship) → StarknetService (sign) → Extended API
3. **Order Response**: Extended API → Result Screen → XP Update

### Security
- **Starknet Signatures**: Cryptographic proof of trade authorization
- **Private Key Management**: Secure key generation and storage
- **API Authentication**: Extended Exchange signature verification
- **Error Handling**: Comprehensive failure recovery

## 🔐 Security Features

- **No Private Key Exposure**: Keys generated and stored locally
- **Signature-Based Auth**: Cryptographic trade authorization  
- **Input Validation**: All API inputs sanitized and validated
- **Error Isolation**: Failures don't compromise wallet security
- **Mode Separation**: Mock mode prevents accidental real trades

## 🚨 Important Notes

⚠️ **Real Mode Warning**: When `APP_MODE=real`, this app executes actual trades with real money on the Extended Exchange. Only use with funds you can afford to lose.

🔒 **Private Key Security**: This implementation generates test private keys for demonstration. In production, integrate with secure wallet providers (ArgentX, Braavos, etc.).

📊 **Trade Size**: Default trade size is 0.01 ETH (~$28 at current prices) for testing. Adjust quantity in `trading_screen.dart` for production use.

## 💰 Paymaster Deployment

The project includes a paymaster contract for gasless transactions:

### Deploy Paymaster Contract
```bash
# Deploy to testnet
python scripts/deploy_paymaster.py --network testnet

# Deploy to mainnet with custom owner
python scripts/deploy_paymaster.py --network mainnet --owner 0x123... --fund 10.0
```

### Contract Structure
```
contracts/paymaster/
├── src/
│   ├── paymaster.cairo      # Main paymaster contract
│   └── lib.cairo           # Library functions
├── Scarb.toml              # Cairo project configuration
└── deployment_*.json       # Deployment configurations
```

## 🎯 Production Readiness

This implementation demonstrates a **complete trading pipeline** with:
- ✅ Real Extended API integration with authentication
- ✅ Starknet blockchain signature verification  
- ✅ **Gasless transactions via paymaster for mass adoption**
- ✅ Live market data streaming
- ✅ Comprehensive error handling
- ✅ Production-ready architecture
- ✅ Security best practices

Perfect for extending into a full-featured trading application or integrating into larger DeFi platforms.