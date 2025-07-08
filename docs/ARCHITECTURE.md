# StreetCred Minimal - System Architecture

## 🏗️ High-Level Architecture

StreetCred Minimal is a comprehensive multi-platform system combining gamified mobile trading with intelligent SDK knowledge management. The architecture follows a microservices pattern with clear separation of concerns.

```
┌─────────────────────────────────────────────────────────────────┐
│                     StreetCred Minimal                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────┐  │
│  │                 │    │                 │    │             │  │
│  │  Flutter App    │◄──►│   RAG Backend   │◄──►│  External   │  │
│  │   (Mobile UI)   │    │   (FastAPI)     │    │   APIs      │  │
│  │                 │    │                 │    │             │  │
│  └─────────────────┘    └─────────────────┘    └─────────────┘  │
│           │                       │                      │       │
│           │                       │                      │       │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────┐  │
│  │                 │    │                 │    │             │  │
│  │  Smart Contracts│    │   ChromaDB      │    │  Extended   │  │
│  │    (Cairo)      │    │ (Vector Store)  │    │  Exchange   │  │
│  │                 │    │                 │    │             │  │
│  └─────────────────┘    └─────────────────┘    └─────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 🎯 Core Components

### 1. Flutter Mobile Application (`/lib/`)

**Primary responsibility**: User interface and mobile experience

**Key modules**:
- **Trading Interface**: Swipe-based trading with gamification
- **SDK Knowledge Base**: Search across multiple platforms
- **Blockchain Integration**: Starknet wallet and transaction management
- **Paymaster Integration**: Gasless transaction sponsorship

**Architecture pattern**: Provider-based state management with Riverpod

```dart
// State flow
UI Screen → Provider → Service → External API
     ↖              ↙
       State Update
```

### 2. Python RAG Backend (`/rag_backend/`)

**Primary responsibility**: Intelligent document search and knowledge management

**Key modules**:
- **FastAPI Server**: RESTful API with async support
- **Multi-platform Indexer**: Documentation ingestion from 4 platforms
- **Categorization System**: AI-powered content organization
- **Optimization Manager**: Performance tuning and health monitoring

**Architecture pattern**: Microservice with vector database

```python
# Request flow
API Request → FastAPI → ChromaDB → Sentence Transformers → Response
```

### 3. Smart Contracts (`/contracts/`)

**Primary responsibility**: Blockchain-based features and gasless transactions

**Key contracts**:
- **XP System**: On-chain experience tracking
- **Paymaster**: Gasless transaction sponsorship
- **Achievement NFTs**: Blockchain-verified accomplishments

**Architecture pattern**: Cairo smart contracts on Starknet

## 🔄 Data Flow Architecture

### Trading Flow
```
1. User swipes on mobile → 2. Flutter provider updates
                                     ↓
8. UI shows result ← 7. XP update ← 6. Trade execution
                                     ↓
3. Paymaster sponsors gas → 4. Starknet signature → 5. Extended Exchange API
```

### Knowledge Search Flow
```
1. User searches → 2. RAG backend → 3. ChromaDB query → 4. Semantic search
                                                              ↓
8. Results display ← 7. Categorization ← 6. Ranking ← 5. Vector similarity
```

## 🧩 Component Interactions

### Flutter App ↔ RAG Backend
- **Protocol**: HTTP REST API
- **Endpoints**: `/search`, `/categories`, `/metrics`, `/optimize`
- **Data format**: JSON with structured responses
- **Caching**: Local SQLite cache for offline support

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
# RAG Backend
cd rag_backend && python main.py

# Flutter App  
flutter run

# Smart Contracts
cd contracts && scarb build
```

### Production Deployment
- **RAG Backend**: Docker containerization
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