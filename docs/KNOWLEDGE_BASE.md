# Knowledge Base System

## Overview
The knowledge base is the core data and document repository powering the StreetCred Minimal RAG (Retrieval-Augmented Generation) system. It enables fast, multi-platform search and intelligent categorization across SDKs, APIs, and documentation, supporting both the backend RAG service and the mobile app.

## Architecture
- **Location:** `knowledge_base/backend/`
- **Backend:** Python (FastAPI)
- **Database:** ChromaDB (vector database)
- **Indexing:** Sentence Transformers for embedding and semantic search
- **Integration:** Exposes REST API endpoints for search, indexing, and categorization

### Key Components
- `main.py`: FastAPI server exposing RAG endpoints
- `categorization_system.py`: AI-powered document categorization
- `sdk_enhanced_indexer.py`: Multi-platform documentation indexer
- `optimization_manager.py`: Performance and optimization logic
- `chroma_db/`: Persistent vector database storage

## Indexing & Querying
- **Indexing:**
  - Documentation and SDK files are embedded using sentence transformers
  - Supports multi-platform ingestion (Python, Dart, Cairo, etc.)
  - Indexing can be triggered via API or setup scripts
- **Querying:**
  - Exposes `/search` and `/index` endpoints
  - Supports semantic search, filtering, and category-based retrieval

## Integration Points
- **Flutter App:**
  - Consumes RAG backend API for search and suggestions
- **Smart Contracts:**
  - Documentation and contract guides are indexed for developer queries
- **Signature/Trading Services:**
  - API and SDK docs indexed for reference and troubleshooting

## Setup & Usage
1. **Install dependencies:**
   ```bash
   cd knowledge_base/backend
   python setup_enhanced.py
   ./start_rag.sh
   ```
2. **Index documentation:**
   ```bash
   curl -X POST http://localhost:8000/index -H "Content-Type: application/json" -d '{"platforms": ["all"]}'
   ```
3. **Query/search:**
   Use the `/search` endpoint or the mobile app's search interface.

## Maintenance
- **Re-index as new docs are added or updated**
- **Monitor ChromaDB health and optimize embeddings as needed**
- **Update categorization logic for new platforms or categories**

## References
- See also: [ARCHITECTURE.md](ARCHITECTURE.md), [PROJECT_STATUS.md](PROJECT_STATUS.md), [TODO.md](TODO.md)
