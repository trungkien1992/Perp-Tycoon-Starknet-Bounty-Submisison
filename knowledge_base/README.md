# StreetCred Knowledge Base

## 🧠 Complete RAG System for Efficient Context Retrieval

This knowledge base contains a self-contained RAG (Retrieval-Augmented Generation) system designed to provide comprehensive context for Claude development sessions without burning tokens. It includes documentation, APIs, and automated indexing for all StreetCred-related technologies.

## 📁 Directory Structure

```
knowledge_base/
├── README.md                    # This file
├── manage_knowledge_base.sh     # Main management script
├── backend/                     # RAG backend system
│   ├── main.py                 # FastAPI RAG server
│   ├── categorization_system.py # Document categorization
│   ├── sdk_enhanced_indexer.py  # Multi-platform indexer
│   ├── optimization_manager.py  # Performance optimization
│   ├── requirements.txt        # Python dependencies
│   ├── start_rag.sh           # Backend startup script
│   └── venv/                  # Python virtual environment
├── docs/                       # Documentation repository
│   ├── manual_docs/           # Hand-written documentation
│   │   ├── AVNU_*.md         # AVNU integration docs
│   │   ├── Extended_API_*.md # Extended Exchange docs
│   │   ├── Starknet_*.md     # Starknet development docs
│   │   └── *.md              # Other platform docs
│   └── auto_generated/       # Auto-generated documentation
├── data/                      # Raw data sources
│   ├── cairo_contracts/      # Cairo smart contract docs
│   ├── extended_exchange/    # Extended Exchange API docs
│   ├── starknet_dart/       # Starknet.dart SDK docs
│   ├── x10_python/          # X10 Python SDK docs
│   └── avnu_gasless/        # AVNU gasless transaction docs
└── system/                   # System files and databases
    ├── chroma_db/           # Vector database
    ├── cache/               # Caching layer
    ├── logs/                # System logs
    ├── temp/                # Temporary files
    ├── backups/             # System backups
    └── optimization_reports/ # Performance reports
```

## 🚀 Quick Start

### 1. Setup Environment
```bash
./manage_knowledge_base.sh setup
```

### 2. Start RAG System
```bash
./manage_knowledge_base.sh start
```

### 3. Check Status
```bash
./manage_knowledge_base.sh status
```

### 4. Search Knowledge Base
```bash
./manage_knowledge_base.sh search "AVNU paymaster integration"
```

## 🔧 Management Commands

### Core Operations
- `./manage_knowledge_base.sh start` - Start RAG backend server
- `./manage_knowledge_base.sh stop` - Stop RAG backend server
- `./manage_knowledge_base.sh restart` - Restart RAG backend server
- `./manage_knowledge_base.sh status` - Check system status

### Knowledge Management
- `./manage_knowledge_base.sh index` - Index all documentation
- `./manage_knowledge_base.sh search <query>` - Search knowledge base
- `./manage_knowledge_base.sh health` - Check system health

### Maintenance
- `./manage_knowledge_base.sh backup` - Create system backup
- `./manage_knowledge_base.sh clean` - Clean temporary files
- `./manage_knowledge_base.sh help` - Show all available commands

## 📊 API Endpoints

Once started, the RAG system provides these endpoints:

- **http://localhost:8000** - Main API base
- **http://localhost:8000/docs** - Interactive Swagger documentation
- **http://localhost:8000/search** - POST endpoint for semantic search
- **http://localhost:8000/categories** - GET available document categories
- **http://localhost:8000/health** - GET system health status

### Example API Usage

```bash
# Search for AVNU integration information
curl -X POST "http://localhost:8000/search" \
     -H "Content-Type: application/json" \
     -d '{"query": "AVNU paymaster gasless transactions", "max_results": 5}'

# Get all available categories
curl "http://localhost:8000/categories"

# Check system health
curl "http://localhost:8000/health"
```

## 🎯 Platforms and Technologies Covered

### 1. **AVNU Gasless Transactions**
- Paymaster integration patterns
- API specifications and endpoints
- Smart contract implementations
- Mobile integration examples

### 2. **Extended Exchange API**
- Trading API documentation
- WebSocket market data feeds
- Authentication and security
- Order management systems

### 3. **Starknet Development**
- Starknet.dart SDK usage
- Cairo smart contract development
- Account abstraction patterns
- Blockchain deployment guides

### 4. **X10 Python SDK**
- Python client library usage
- Trading algorithm examples
- Market data processing
- Portfolio management

### 5. **StreetCred Specific**
- Application architecture
- Component integration patterns
- Security implementations
- Deployment procedures

## 🔍 Search Categories

The system automatically categorizes content into:

**Technical Categories:**
- `api_reference` - API documentation and specifications
- `integration_guide` - Step-by-step integration tutorials
- `smart_contracts` - Blockchain and smart contract development
- `mobile_development` - Flutter/mobile app development
- `authentication` - Security and authentication patterns

**Platform Categories:**
- `avnu_gasless` - AVNU paymaster and gasless transactions
- `extended_exchange` - Extended Exchange trading platform
- `starknet_dart` - Starknet.dart SDK and blockchain integration
- `cairo_contracts` - Cairo smart contract development
- `x10_python` - X10 Python SDK for trading

**Complexity Levels:**
- `beginner` - Getting started guides
- `intermediate` - Standard implementation patterns
- `advanced` - Complex integration scenarios
- `expert` - Advanced optimization and customization

## 🎛️ Configuration

### Environment Variables
Create a `.env` file in the `backend/` directory:

```env
# Server configuration
PORT=8000
HOST=localhost
DEBUG=true

# Vector database
CHROMA_DB_PATH=../system/chroma_db
COLLECTION_NAME=streetcred_knowledge_base

# Embedding model
EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2

# Search configuration
DEFAULT_MAX_RESULTS=10
DEFAULT_SIMILARITY_THRESHOLD=0.7
CHUNK_SIZE=1000
CHUNK_OVERLAP=200
```

### Customizing Search Behavior

Edit `backend/main.py` to modify:

```python
RAG_CONFIG = {
    "chroma_db_path": "../system/chroma_db",
    "collection_name": "streetcred_knowledge_base",
    "embedding_model": "sentence-transformers/all-MiniLM-L6-v2",
    "chunk_size": 1000,        # Adjust chunk size
    "chunk_overlap": 200,      # Adjust overlap
    "max_results": 10,         # Default max results
    "similarity_threshold": 0.7, # Minimum similarity score
}
```

## 🔄 Development Workflow

### Adding New Documentation

1. **Manual Documentation**: Add `.md` files to `docs/manual_docs/`
2. **Auto-Generated**: Place in `docs/auto_generated/`
3. **Raw Data Sources**: Add to appropriate `data/` subdirectory
4. **Re-index**: Run `./manage_knowledge_base.sh index`

### Updating Existing Content

1. Modify the source files
2. Re-run indexing: `./manage_knowledge_base.sh index`
3. Verify with search: `./manage_knowledge_base.sh search "updated content"`

### Performance Monitoring

```bash
# Check system health and performance
./manage_knowledge_base.sh health

# View recent logs
tail -f system/logs/backend.log

# Check optimization reports
ls -la system/optimization_reports/
```

## 🔒 Security Considerations

### Access Control
- RAG system runs locally (localhost:8000)
- No external network access required
- All data stored locally in knowledge base

### Data Privacy
- No external API calls for embeddings (uses local model)
- All processing happens locally
- No data leaves the local system

### Backup and Recovery
- Regular backups: `./manage_knowledge_base.sh backup`
- Backups stored in `system/backups/`
- Full system restoration supported

## 🚀 Performance Optimization

### Automatic Optimization
The system includes automatic optimization features:

- **Document deduplication** - Removes duplicate content
- **Embedding caching** - Reuses computed embeddings
- **Query optimization** - Improves search performance
- **Background cleanup** - Maintains system health

### Manual Optimization
```bash
# Force optimization
curl -X POST "http://localhost:8000/optimize"

# Check optimization status
curl "http://localhost:8000/optimization/status"
```

## 🐛 Troubleshooting

### Common Issues

1. **Backend won't start**
   ```bash
   # Check logs
   cat system/logs/backend.log
   
   # Verify dependencies
   cd backend && source venv/bin/activate && pip install -r requirements.txt
   ```

2. **Search returns no results**
   ```bash
   # Check if documents are indexed
   ./manage_knowledge_base.sh health
   
   # Re-index if needed
   ./manage_knowledge_base.sh index
   ```

3. **Performance issues**
   ```bash
   # Clean temporary files
   ./manage_knowledge_base.sh clean
   
   # Check optimization
   curl "http://localhost:8000/health"
   ```

### Logs and Debugging

- **Backend logs**: `system/logs/backend.log`
- **Error logs**: `system/logs/error.log`
- **Performance logs**: `system/optimization_reports/`

## 🔮 Future Enhancements

### Planned Features
- **Multi-language support** - Support for multiple programming languages
- **Real-time updates** - Live documentation updates
- **Advanced search** - Semantic search improvements
- **Integration APIs** - Direct integration with development tools

### Extensibility
The knowledge base is designed to be easily extensible:

- Add new platforms by creating new data directories
- Extend categorization in `backend/categorization_system.py`
- Add new endpoints in `backend/main.py`
- Customize search behavior in RAG configuration

---

**Knowledge Base Version**: 2.0  
**Last Updated**: 2025-01-08  
**Maintainer**: StreetCred Development Team  
**Support**: See troubleshooting section above

> **💡 Pro Tip**: Use `./manage_knowledge_base.sh search "your query"` to quickly find relevant information without burning Claude tokens!