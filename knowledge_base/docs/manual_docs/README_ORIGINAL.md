# Starknet.dart SDK RAG Backend

A high-performance Python-based RAG (Retrieval-Augmented Generation) system for the Starknet.dart SDK knowledge base. This system indexes and provides semantic search capabilities over the 6M+ token Starknet.dart SDK documentation.

## 🚀 Quick Start

### 1. Setup Python Environment

```bash
cd rag_backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On macOS/Linux:
source venv/bin/activate
# On Windows:
# venv\Scripts\activate

# Run setup script
python setup.py
```

### 2. Start the RAG Server

```bash
# Start the FastAPI server
python main.py

# Or using uvicorn directly
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

### 3. Index the SDK Documentation

```bash
# Trigger indexing (runs in background)
curl -X POST http://localhost:8000/index \
  -H "Content-Type: application/json" \
  -d '{"force_reindex": false}'
```

### 4. Test the Search

```bash
# Search the knowledge base
curl -X POST http://localhost:8000/search \
  -H "Content-Type: application/json" \
  -d '{"query": "how to create account", "max_results": 3}'
```

## 📊 API Endpoints

### Search
- **POST** `/search` - Search the knowledge base
- **GET** `/categories` - Get available categories
- **GET** `/stats` - Get knowledge base statistics

### Management
- **POST** `/index` - Trigger documentation indexing
- **GET** `/` - Health check

### Example API Usage

```python
import requests

# Search for documentation
response = requests.post("http://localhost:8000/search", json={
    "query": "contract deployment",
    "max_results": 5,
    "category": "examples",
    "min_similarity": 0.7
})

results = response.json()
for result in results["results"]:
    print(f"Title: {result['title']}")
    print(f"Category: {result['category']}")
    print(f"Similarity: {result['similarity']:.2%}")
    print(f"Content: {result['content'][:200]}...")
    print("-" * 50)
```

## 🏗️ Architecture

### Core Components

1. **FastAPI Server** - REST API endpoints
2. **ChromaDB** - Vector database for embeddings
3. **SentenceTransformers** - Embedding generation
4. **LangChain** - Document processing and chunking

### Document Processing Pipeline

```
GitHub/pub.dev → Document Fetching → Text Chunking → Embedding Generation → ChromaDB Storage
```

### Search Pipeline

```
User Query → Embedding Generation → Vector Similarity Search → Results Ranking → Response
```

## 🔧 Configuration

### Environment Variables (.env)

```bash
# Database Configuration
CHROMA_DB_PATH=./chroma_db
EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2

# Chunking Configuration
CHUNK_SIZE=1000
CHUNK_OVERLAP=200

# Search Configuration
MAX_RESULTS=10
SIMILARITY_THRESHOLD=0.7

# Optional: Advanced Embeddings
OPENAI_API_KEY=your_openai_api_key_here
COHERE_API_KEY=your_cohere_api_key_here

# Server Configuration
HOST=0.0.0.0
PORT=8000
```

### Advanced Configuration

```python
# In main.py, modify RAG_CONFIG
RAG_CONFIG = {
    "chroma_db_path": "./chroma_db",
    "collection_name": "starknet_dart_sdk",
    "embedding_model": "sentence-transformers/all-MiniLM-L6-v2",
    "chunk_size": 1000,
    "chunk_overlap": 200,
    "max_results": 10,
    "similarity_threshold": 0.7,
}
```

## 📚 Documentation Sources

The RAG system indexes documentation from:

1. **GitHub Repository** - README, guides, API docs
2. **pub.dev** - Package documentation and metadata
3. **Official Website** - starknetdart.dev content
4. **Example Projects** - NFT marketplace, wallet, CLI examples

### Document Categories

- `overview` - High-level SDK information
- `api` - Class and method documentation
- `examples` - Code examples and tutorials
- `packages` - Package-specific documentation
- `getting-started` - Installation and setup guides

## 🎯 Search Features

### Semantic Search
- Vector similarity using sentence transformers
- Context-aware results ranking
- Multi-language embedding support

### Keyword Search
- Full-text search with FTS5
- Boolean operators support
- Phrase matching

### Advanced Filtering
- Category-based filtering
- Source type filtering
- Importance level filtering
- Similarity threshold adjustment

## 🔍 Flutter Integration

### In your Flutter app:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/rag_provider.dart';

// Search the knowledge base
final searchResult = await ref.read(ragSearchProvider.notifier).search("how to create account");

// Get statistics
final stats = await ref.read(ragStatsProvider.future);
print('Total documents: ${stats.totalDocuments}');

// Check system health
final health = await ref.read(ragHealthProvider.future);
if (health.isHealthy) {
    print('RAG system is healthy');
}
```

## 🚀 Performance Optimization

### Embedding Models

- **Fast**: `sentence-transformers/all-MiniLM-L6-v2` (default)
- **Balanced**: `sentence-transformers/all-mpnet-base-v2`
- **High Quality**: `text-embedding-3-small` (OpenAI API required)

### Database Optimization

```python
# Batch processing for large documents
BATCH_SIZE = 100

# Index optimization
await collection.create_index("category")
await collection.create_index("source_type")
```

### Caching

```python
# Redis caching (optional)
import redis
r = redis.Redis(host='localhost', port=6379, db=0)

# Cache search results
cache_key = f"search:{query_hash}"
cached_result = r.get(cache_key)
```

## 🧪 Testing

### Unit Tests

```bash
cd rag_backend
python -m pytest tests/ -v
```

### Load Testing

```bash
# Install locust
pip install locust

# Run load tests
locust -f tests/load_test.py --host=http://localhost:8000
```

### Integration Tests

```bash
# Test full pipeline
python tests/test_integration.py
```

## 📈 Monitoring

### Health Checks

- **GET** `/` - Basic health check
- **GET** `/stats` - Detailed system statistics
- Database connection status
- Embedding model status

### Metrics

- Search latency
- Index size
- Query volume
- Error rates

### Logging

```python
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
```

## 🔒 Security

### API Security

- CORS configuration
- Rate limiting (optional)
- API key authentication (optional)

### Data Security

- No persistent storage of queries
- Encrypted connections
- Secure configuration management

## 🚨 Troubleshooting

### Common Issues

1. **ChromaDB Connection Errors**
   ```bash
   # Clear and recreate database
   rm -rf ./chroma_db
   python main.py
   ```

2. **Embedding Model Download Issues**
   ```bash
   # Pre-download model
   python -c "from sentence_transformers import SentenceTransformer; SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')"
   ```

3. **Memory Issues**
   ```python
   # Reduce batch size
   BATCH_SIZE = 50
   
   # Use smaller embedding model
   EMBEDDING_MODEL = "sentence-transformers/all-MiniLM-L6-v2"
   ```

### Debug Mode

```bash
# Start with debug logging
LOG_LEVEL=DEBUG python main.py

# Enable FastAPI debug mode
uvicorn main:app --reload --log-level debug
```

## 📦 Dependencies

### Core Dependencies
- `fastapi` - Web framework
- `chromadb` - Vector database
- `sentence-transformers` - Embeddings
- `langchain` - Document processing

### Optional Dependencies
- `openai` - OpenAI embeddings
- `cohere` - Cohere embeddings
- `pinecone-client` - Alternative vector DB
- `redis` - Caching

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

### Development Setup

```bash
# Install development dependencies
pip install -r requirements-dev.txt

# Run pre-commit hooks
pre-commit install

# Run tests
pytest tests/ -v --cov=src/
```

## 📄 License

This project is part of the StreetCred Minimal application and follows the same license terms.

## 🆘 Support

- **GitHub Issues**: Report bugs and request features
- **Telegram**: Join the Starknet.dart community at https://t.me/+CWezjfLIRYc0MDY0
- **Documentation**: Visit https://starknetdart.dev for SDK documentation

---

**Happy searching! 🔍✨**