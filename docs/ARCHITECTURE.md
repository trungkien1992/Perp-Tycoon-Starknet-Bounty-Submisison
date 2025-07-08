# StreetCred Minimal - System Architecture

## 🏗️ High-Level Architecture

StreetCred Minimal is a **gamified mobile trading app** for Gen-Z users targeting the StarkWare Bounty Program. The architecture focuses on trading, gamification, and blockchain innovation.

### 🎮 Product Architecture (User-Facing)
```
┌─────────────────────────────────────────────────────────────────┐
│                  StreetCred Mobile Trading App                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────┐  │
│  │                 │    │                 │    │             │  │
│  │  Flutter App    │◄──►│ Smart Contracts │◄──►│  Extended   │  │
│  │ (Swipe Trading) │    │ (XP + Paymaster)│    │  Exchange   │  │
│  │                 │    │                 │    │ (Real API)  │  │
│  └─────────────────┘    └─────────────────┘    └─────────────┘  │
│                                                                 │
│  Core Features: Swipe Trading • Gasless Transactions • NFTs    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 🛠️ Development Architecture (Claude Code Tool)
```
┌─────────────────────────────────────────────────────────────────┐
│                    Claude Development Tools                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────┐  │
│  │                 │    │                 │    │             │  │
│  │   Claude Code   │◄──►│   RAG Backend   │◄──►│  SDK Docs   │  │
│  │  (This Session) │    │ (Context Tool)  │    │ (5 Platforms)│  │
│  │                 │    │                 │    │             │  │
│  └─────────────────┘    └─────────────────┘    └─────────────┘  │
│                                                                 │
│  Purpose: Efficient context retrieval without burning tokens   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 🎯 Core Components

### 1. Flutter Mobile Application (`/lib/`)

**Primary responsibility**: User interface and mobile trading experience

**Key modules**:
- **Trading Interface**: Swipe-based trading with gamification
- **Blockchain Integration**: Starknet wallet and transaction management
- **Paymaster Integration**: Gasless transaction sponsorship
- **Social Features**: Leaderboards, achievements, and friend systems

**Architecture pattern**: Provider-based state management with Riverpod

```dart
// State flow
UI Screen → Provider → Service → External API
     ↖              ↙
       State Update
```

### 2. Knowledge Base RAG System (`/knowledge_base/`) - **DEVELOPMENT TOOL ONLY**

**Primary responsibility**: Claude Code context retrieval without burning tokens (NOT a product feature)

**Key modules**:
- **FastAPI Server**: Local development server for Claude context queries
- **Multi-platform Indexer**: SDK documentation for Claude reference  
- **Categorization System**: Organize context for efficient retrieval
- **Optimization Manager**: Keep context database efficient
- **Management Scripts**: Complete system management and automation

**Architecture pattern**: Self-contained knowledge management system

```python
# Claude Code context flow
Claude Question → Knowledge Base RAG → ChromaDB → SDK Context → Better Code
```

**⚠️ IMPORTANT**: This is NOT shipped to users - it's purely for Claude development efficiency

### 3. Smart Contracts (`/contracts/`)

**Primary responsibility**: Blockchain-based features and gasless transactions

**Key contracts**:
- **XP System** (`streetcred_xp/`): On-chain experience tracking
- **AVNU Paymaster** (`streetcred_paymaster/avnu_paymaster.cairo`): AVNU-compatible gasless transaction sponsorship
- **Achievement NFTs** (`street_art_nft/`): Blockchain-verified accomplishments

**Architecture pattern**: Cairo smart contracts on Starknet with AVNU ecosystem compatibility

## 🔄 Data Flow Architecture

### Trading Flow (with AVNU Gasless)
```
1. User swipes on mobile → 2. Flutter provider updates
                                     ↓
9. UI shows result ← 8. XP bonus (+10 for gasless) ← 7. Trade execution
                                     ↓
3. AVNU can_sponsor_transaction? → 4. validate_and_pay_for_transaction → 5. Extended Exchange API
        ↓                                    ↓
6. Daily limit check                 Atomic gas payment by paymaster
```

### Knowledge Search Flow (Development Only)
```
1. Claude searches → 2. Knowledge Base RAG → 3. ChromaDB query → 4. Semantic search
                                                                      ↓
8. Context provided ← 7. Categorization ← 6. Ranking ← 5. Vector similarity
```

## 🧩 Component Interactions

### Claude Code ↔ Knowledge Base RAG (Development Only)
- **Protocol**: HTTP REST API (local development)
- **Endpoints**: `/search`, `/categories`, `/health` for context retrieval
- **Purpose**: Efficient SDK documentation lookup for Claude without burning tokens
- **Management**: `./manage_knowledge_base.sh` for complete system control
- **Scope**: Development environment only, not deployed to production

### Flutter App ↔ Smart Contracts
- **Protocol**: Starknet RPC calls
- **Integration**: Direct contract calls via starknet.dart
- **Authentication**: Cryptographic signatures
- **Gas management**: Paymaster-sponsored transactions

### RAG Backend ↔ External APIs
- **Extended Exchange**: API documentation scraping
- **GitHub**: Repository content extraction
- **Static sites**: Documentation parsing
- **WebSocket**: Real-time updates (future)

## 📊 Platform Integration

### Extended Exchange API
- **Type**: RESTful trading API
- **Integration**: Direct HTTP calls with authentication
- **Features**: Order placement, market data, account management
- **Documentation**: Indexed in RAG system

### X10 Python SDK
- **Type**: Python client library
- **Integration**: Code examples and usage patterns
- **Features**: Simplified Extended Exchange interaction
- **Documentation**: GitHub repository indexing

### Cairo Smart Contracts
- **Type**: Blockchain development framework
- **Integration**: Contract deployment and interaction
- **Features**: Starknet-based smart contract development
- **Documentation**: Official Cairo book and examples

### Starknet.dart
- **Type**: Flutter/Dart blockchain SDK
- **Integration**: Direct dependency in Flutter app
- **Features**: Wallet management, transaction signing
- **Documentation**: API reference and mobile patterns

## 🔐 Security Architecture

### Authentication Flow
```
1. User login → 2. Starknet keypair generation → 3. Signature creation
                                                        ↓
6. Access granted ← 5. Signature verification ← 4. API authentication
```

### Transaction Security
- **Private keys**: Generated and stored locally
- **Signatures**: Cryptographic proof of authorization
- **API authentication**: Signature-based verification
- **Error isolation**: Failures don't compromise wallet security

### Data Protection
- **Sensitive data**: Encrypted at rest and in transit
- **API keys**: Environment variable configuration
- **User data**: Minimal collection with local storage
- **Audit logs**: Comprehensive transaction tracking

## 🚀 Performance Architecture

### Scalability Considerations
- **RAG Backend**: Async FastAPI with connection pooling
- **Vector Database**: ChromaDB with efficient indexing
- **Mobile App**: Lazy loading with pagination
- **Caching**: Multi-layer caching strategy

### Optimization Features
- **Document deduplication**: Automatic duplicate removal
- **Embedding cache**: Reuse of computed embeddings
- **Query optimization**: Intelligent query routing
- **Background indexing**: Non-blocking documentation updates

## 🔧 Development Architecture

### Environment Separation
- **Development**: Mock APIs with safe testing
- **Staging**: Real APIs with limited exposure
- **Production**: Full integration with monitoring

### Testing Strategy
- **Unit tests**: Individual component testing
- **Integration tests**: Cross-component verification
- **E2E tests**: Full workflow validation
- **Performance tests**: Load and stress testing

## 🌐 Deployment Architecture

### Local Development
```bash
# Knowledge Base RAG System
cd knowledge_base && ./manage_knowledge_base.sh start

# Flutter App  
flutter run

# Smart Contracts
cd contracts && scarb build
```

### Production Deployment
- **Knowledge Base RAG**: NOT deployed (development tool only)
- **Flutter App**: Mobile app stores
- **Smart Contracts**: Starknet mainnet deployment  
- **Monitoring**: Health checks and metrics

## 🔮 Future Architecture Considerations

### Planned Enhancements
- **Microservices**: Split RAG backend into focused services
- **Real-time**: WebSocket integration for live updates
- **Multi-chain**: Cross-chain bridge integration
- **AI enhancement**: Advanced LLM integration
- **Social features**: User-generated content and sharing

### Scaling Strategies
- **Horizontal scaling**: Load balancer with multiple instances
- **Database sharding**: Distributed vector storage
- **CDN integration**: Global content delivery
- **Edge computing**: Regional processing nodes

---

**Last Updated**: 2025-01-08  
**Version**: 1.0.0  
**Next Review**: 2025-01-15