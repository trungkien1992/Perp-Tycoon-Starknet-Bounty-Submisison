#!/usr/bin/env python3
"""
Starknet.dart SDK RAG Backend
High-performance Python-based RAG service for 6M token SDK knowledge base
"""

import os
import asyncio
from typing import List, Optional, Dict, Any
from dataclasses import dataclass
from datetime import datetime

from fastapi import FastAPI, HTTPException, BackgroundTasks
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import uvicorn

# Vector database and embeddings
import chromadb
from sentence_transformers import SentenceTransformer
from chromadb.utils import embedding_functions

# Document processing
import requests
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.schema import Document

# Enhanced categorization and indexing
from categorization_system import categorize_document, get_all_categories, get_all_platforms
from sdk_enhanced_indexer import EnhancedSDKIndexer
from optimization_manager import RAGOptimizationManager, optimize_rag_system, get_rag_health

# Configuration
RAG_CONFIG = {
    "chroma_db_path": "../system/chroma_db",
    "collection_name": "streetcred_knowledge_base",
    "embedding_model": "sentence-transformers/all-MiniLM-L6-v2",
    "chunk_size": 1000,
    "chunk_overlap": 200,
    "max_results": 10,
    "similarity_threshold": 0.7,
}

# Pydantic models
class QueryRequest(BaseModel):
    query: str
    max_results: Optional[int] = 5
    category: Optional[str] = None
    min_similarity: Optional[float] = 0.6

class QueryResponse(BaseModel):
    results: List[Dict[str, Any]]
    query_time: float
    total_results: int

class IndexRequest(BaseModel):
    force_reindex: bool = False

class IndexResponse(BaseModel):
    status: str
    documents_indexed: int
    time_taken: float

class StatsResponse(BaseModel):
    total_documents: int
    categories: Dict[str, int]
    last_updated: str
    embedding_model: str

@dataclass
class ProcessedDocument:
    content: str
    title: str
    category: str
    subcategory: Optional[str]
    metadata: Dict[str, Any]
    source_url: Optional[str] = None

class StarknetSDKRAG:
    """High-performance RAG system for Starknet.dart SDK"""
    
    def __init__(self):
        self.chroma_client = None
        self.collection = None
        self.embedding_model = None
        self.text_splitter = None
        self.documents_indexed = 0
        self.last_updated = None
        
    async def initialize(self):
        """Initialize the RAG system"""
        print("🚀 Initializing Starknet.dart SDK RAG system...")
        
        # Initialize ChromaDB
        self.chroma_client = chromadb.PersistentClient(path=RAG_CONFIG["chroma_db_path"])
        
        # Initialize embedding model
        self.embedding_model = SentenceTransformer(RAG_CONFIG["embedding_model"])
        
        # Create embedding function for ChromaDB
        embedding_function = embedding_functions.SentenceTransformerEmbeddingFunction(
            model_name=RAG_CONFIG["embedding_model"]
        )
        
        # Get or create collection
        try:
            self.collection = self.chroma_client.get_collection(
                name=RAG_CONFIG["collection_name"],
                embedding_function=embedding_function
            )
            print(f"✅ Loaded existing collection: {RAG_CONFIG['collection_name']}")
        except Exception:
            self.collection = self.chroma_client.create_collection(
                name=RAG_CONFIG["collection_name"],
                embedding_function=embedding_function,
                metadata={"description": "Starknet.dart SDK knowledge base"}
            )
            print(f"✅ Created new collection: {RAG_CONFIG['collection_name']}")
        
        # Initialize text splitter
        self.text_splitter = RecursiveCharacterTextSplitter(
            chunk_size=RAG_CONFIG["chunk_size"],
            chunk_overlap=RAG_CONFIG["chunk_overlap"],
            separators=["\n\n", "\n", ". ", " ", ""]
        )
        
        # Get current stats
        count = self.collection.count()
        self.documents_indexed = count
        print(f"📊 Current documents in collection: {count}")
        
    async def index_sdk_documentation(self, force_reindex: bool = False) -> Dict[str, Any]:
        """Index all SDK documentation with enhanced categorization"""
        start_time = datetime.now()
        
        if force_reindex:
            print("🔄 Force reindexing - clearing existing collection...")
            self.collection.delete()
            self.collection = self.chroma_client.create_collection(
                name=RAG_CONFIG["collection_name"],
                embedding_function=embedding_functions.SentenceTransformerEmbeddingFunction(
                    model_name=RAG_CONFIG["embedding_model"]
                )
            )
        
        # Use enhanced indexer
        enhanced_indexer = EnhancedSDKIndexer(self)
        platform_results = await enhanced_indexer.index_all_sdks()
        
        # Update stats
        total_docs = sum(platform_results.values())
        self.documents_indexed = total_docs
        self.last_updated = datetime.now().isoformat()
        
        time_taken = (datetime.now() - start_time).total_seconds()
        
        return {
            "status": "completed",
            "documents_indexed": total_docs,
            "platform_breakdown": platform_results,
            "time_taken": time_taken
        }
    
    async def _collect_sdk_documentation(self) -> List[ProcessedDocument]:
        """Collect all SDK documentation from various sources"""
        documents = []
        
        # GitHub repository documentation
        documents.extend(await self._fetch_github_docs())
        
        # pub.dev API documentation
        documents.extend(await self._fetch_pubdev_docs())
        
        # Official documentation site
        documents.extend(await self._fetch_official_docs())
        
        # Example projects
        documents.extend(await self._fetch_example_projects())
        
        return documents
    
    async def _fetch_github_docs(self) -> List[ProcessedDocument]:
        """Fetch documentation from GitHub repository"""
        documents = []
        
        # GitHub API endpoints for starknet.dart
        base_url = "https://api.github.com/repos/focustree/starknet.dart"
        
        # README
        documents.append(ProcessedDocument(
            content=await self._fetch_github_file(f"{base_url}/contents/README.md"),
            title="Starknet.dart SDK README",
            category="overview",
            subcategory="readme",
            metadata={"source": "github", "importance": "critical"},
            source_url="https://github.com/focustree/starknet.dart/blob/main/README.md"
        ))
        
        # Documentation files
        doc_files = [
            "CONTRIBUTING.md",
            "CHANGELOG.md",
            "docs/getting-started.md",
            "docs/api-reference.md",
            "docs/examples.md",
        ]
        
        for file_path in doc_files:
            try:
                content = await self._fetch_github_file(f"{base_url}/contents/{file_path}")
                if content:
                    documents.append(ProcessedDocument(
                        content=content,
                        title=f"Starknet.dart {file_path}",
                        category="documentation",
                        subcategory=file_path.split("/")[-1].replace(".md", ""),
                        metadata={"source": "github", "file_path": file_path},
                        source_url=f"https://github.com/focustree/starknet.dart/blob/main/{file_path}"
                    ))
            except Exception as e:
                print(f"⚠️  Could not fetch {file_path}: {e}")
        
        return documents
    
    async def _fetch_github_file(self, url: str) -> Optional[str]:
        """Fetch a file from GitHub API"""
        try:
            response = requests.get(url)
            if response.status_code == 200:
                data = response.json()
                if data.get("content"):
                    import base64
                    content = base64.b64decode(data["content"]).decode("utf-8")
                    return content
        except Exception as e:
            print(f"Error fetching GitHub file: {e}")
        return None
    
    async def _fetch_pubdev_docs(self) -> List[ProcessedDocument]:
        """Fetch API documentation from pub.dev"""
        documents = []
        
        # API documentation from pub.dev
        packages = [
            "starknet",
            "starknet_provider",
            "wallet_kit",
            "secure_store",
            "avnu_paymaster_provider",
            "starknet_builder"
        ]
        
        for package in packages:
            try:
                # Fetch package info
                url = f"https://pub.dev/api/packages/{package}"
                response = requests.get(url)
                if response.status_code == 200:
                    data = response.json()
                    description = data.get("latest", {}).get("pubspec", {}).get("description", "")
                    
                    documents.append(ProcessedDocument(
                        content=f"Package: {package}\nDescription: {description}\n"
                                f"Latest Version: {data.get('latest', {}).get('version', '')}\n"
                                f"Published: {data.get('latest', {}).get('published', '')}\n"
                                f"Dependencies: {data.get('latest', {}).get('pubspec', {}).get('dependencies', {})}",
                        title=f"{package} Package Info",
                        category="packages",
                        subcategory=package,
                        metadata={"source": "pub.dev", "package": package},
                        source_url=f"https://pub.dev/packages/{package}"
                    ))
            except Exception as e:
                print(f"⚠️  Could not fetch package {package}: {e}")
        
        return documents
    
    async def _fetch_official_docs(self) -> List[ProcessedDocument]:
        """Fetch documentation from official website"""
        documents = []
        
        # Official documentation site content
        official_content = """
        Starknet.dart SDK Official Documentation
        
        The goal of this SDK is to be able to interact with StarkNet smart contracts in a type-safe way.
        You can also call the JSON-RPC endpoint exposed by the Starknet full nodes.
        
        The priority is to build the best possible Starknet SDK for dart applications,
        thus unlocking the era of Flutter mobile apps on Starknet.
        
        Supported Features:
        - Invoke transactions (versions 0, 1, 3)
        - Declare transactions (versions 1, 2, 3)
        - Deploy Account transactions (versions 1, 3)
        - JSON RPC version 0.7.1 support
        - Type-safe contract interactions
        - Mobile-first development approach
        
        Key Packages:
        - Starknet: Core SDK functionality
        - Starknet Provider: Network provider implementations
        - Wallet Kit: Wallet integration utilities
        - Secure Store: Secure storage for keys and credentials
        - Avnu Paymaster Provider: Paymaster integration
        - Starknet Builder: Development tools
        """
        
        documents.append(ProcessedDocument(
            content=official_content,
            title="Official Starknet.dart Documentation",
            category="documentation",
            subcategory="official",
            metadata={"source": "official_site", "importance": "critical"},
            source_url="https://starknetdart.dev"
        ))
        
        return documents
    
    async def _fetch_example_projects(self) -> List[ProcessedDocument]:
        """Fetch example project documentation"""
        documents = []
        
        examples = [
            {
                "title": "NFT Marketplace Example",
                "content": """
                Complete NFT marketplace implementation using Starknet.dart SDK.
                
                Features:
                - ERC-721 token standard
                - Minting and trading
                - Flutter mobile interface
                - Wallet integration
                - Smart contract deployment
                
                Architecture:
                - Cairo smart contracts
                - Flutter frontend with Riverpod
                - Starknet.dart SDK integration
                - Secure key management
                
                Usage:
                - Connect to Starknet testnet
                - Deploy NFT contracts
                - Mint and trade NFTs
                - Manage wallet accounts
                """,
                "category": "examples",
                "subcategory": "nft_marketplace"
            },
            {
                "title": "Mobile Wallet Example",
                "content": """
                Full-featured mobile wallet for Starknet.
                
                Features:
                - Account management
                - Token transfers
                - Transaction history
                - Secure storage
                - Biometric authentication
                
                Implementation:
                - Flutter cross-platform
                - Hardware-backed security
                - Multi-account support
                - Real-time balance updates
                - Push notifications
                
                Security:
                - Hardware security module
                - Biometric locks
                - Encrypted storage
                - Secure key derivation
                """,
                "category": "examples",
                "subcategory": "wallet"
            }
        ]
        
        for example in examples:
            documents.append(ProcessedDocument(
                content=example["content"],
                title=example["title"],
                category=example["category"],
                subcategory=example["subcategory"],
                metadata={"source": "examples", "complexity": "advanced"}
            ))
        
        return documents
    
    def _chunk_document(self, doc: ProcessedDocument) -> List[Dict[str, Any]]:
        """Chunk a document into smaller pieces"""
        chunks = self.text_splitter.split_text(doc.content)
        
        chunked_docs = []
        for i, chunk in enumerate(chunks):
            chunk_id = f"{doc.category}_{doc.subcategory}_{i}" if doc.subcategory else f"{doc.category}_{i}"
            
            chunked_docs.append({
                "id": chunk_id,
                "content": chunk,
                "metadata": {
                    "title": doc.title,
                    "category": doc.category,
                    "subcategory": doc.subcategory,
                    "chunk_index": i,
                    "total_chunks": len(chunks),
                    "source_url": doc.source_url,
                    **doc.metadata
                }
            })
        
        return chunked_docs
    
    async def _add_chunks_to_collection(self, chunks: List[Dict[str, Any]]):
        """Add document chunks to ChromaDB collection"""
        batch_size = 100
        
        for i in range(0, len(chunks), batch_size):
            batch = chunks[i:i + batch_size]
            
            ids = [chunk["id"] for chunk in batch]
            documents = [chunk["content"] for chunk in batch]
            metadatas = [chunk["metadata"] for chunk in batch]
            
            self.collection.add(
                ids=ids,
                documents=documents,
                metadatas=metadatas
            )
            
            print(f"✅ Added batch {i//batch_size + 1}/{(len(chunks) + batch_size - 1)//batch_size}")
    
    async def search(self, query: str, max_results: int = 5, category: str = None, 
                    min_similarity: float = 0.6) -> Dict[str, Any]:
        """Search the knowledge base"""
        start_time = datetime.now()
        
        # Prepare query filters
        where_filter = {}
        if category:
            where_filter["category"] = category
        
        # Perform vector search
        results = self.collection.query(
            query_texts=[query],
            n_results=max_results,
            where=where_filter if where_filter else None
        )
        
        # Process results
        processed_results = []
        if results["documents"] and results["documents"][0]:
            for i, doc in enumerate(results["documents"][0]):
                metadata = results["metadatas"][0][i] if results["metadatas"] else {}
                distance = results["distances"][0][i] if results["distances"] else 0
                similarity = 1 - distance  # Convert distance to similarity
                
                if similarity >= min_similarity:
                    processed_results.append({
                        "content": doc,
                        "title": metadata.get("title", "Unknown"),
                        "category": metadata.get("category", "Unknown"),
                        "subcategory": metadata.get("subcategory"),
                        "similarity": similarity,
                        "source_url": metadata.get("source_url"),
                        "metadata": metadata
                    })
        
        query_time = (datetime.now() - start_time).total_seconds()
        
        return {
            "results": processed_results,
            "query_time": query_time,
            "total_results": len(processed_results)
        }
    
    def get_stats(self) -> Dict[str, Any]:
        """Get knowledge base statistics"""
        total_docs = self.collection.count()
        
        # Get categories
        all_metadata = self.collection.get()["metadatas"]
        categories = {}
        for metadata in all_metadata:
            category = metadata.get("category", "unknown")
            categories[category] = categories.get(category, 0) + 1
        
        return {
            "total_documents": total_docs,
            "categories": categories,
            "last_updated": self.last_updated or "Never",
            "embedding_model": RAG_CONFIG["embedding_model"]
        }

# FastAPI application
app = FastAPI(
    title="Starknet.dart SDK RAG API",
    description="High-performance RAG service for Starknet.dart SDK knowledge base",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize RAG system
rag_system = StarknetSDKRAG()

@app.on_event("startup")
async def startup_event():
    """Initialize RAG system on startup"""
    await rag_system.initialize()

@app.get("/", response_model=Dict[str, str])
async def root():
    """Root endpoint"""
    return {
        "service": "Starknet.dart SDK RAG API",
        "version": "1.0.0",
        "status": "running"
    }

@app.post("/index", response_model=IndexResponse)
async def index_documentation(request: IndexRequest, background_tasks: BackgroundTasks):
    """Index SDK documentation"""
    background_tasks.add_task(rag_system.index_sdk_documentation, request.force_reindex)
    return IndexResponse(
        status="started",
        documents_indexed=0,
        time_taken=0.0
    )

@app.post("/search", response_model=QueryResponse)
async def search_knowledge_base(request: QueryRequest):
    """Search the knowledge base"""
    result = await rag_system.search(
        query=request.query,
        max_results=request.max_results,
        category=request.category,
        min_similarity=request.min_similarity
    )
    
    return QueryResponse(
        results=result["results"],
        query_time=result["query_time"],
        total_results=result["total_results"]
    )

@app.get("/stats", response_model=StatsResponse)
async def get_stats():
    """Get knowledge base statistics"""
    stats = rag_system.get_stats()
    return StatsResponse(
        total_documents=stats["total_documents"],
        categories=stats["categories"],
        last_updated=stats["last_updated"],
        embedding_model=stats["embedding_model"]
    )

@app.get("/categories")
async def get_categories():
    """Get all available categories from the enhanced categorization system"""
    return {
        "categories": get_all_categories(),
        "platforms": get_all_platforms(),
        "current_stats": rag_system.get_stats()["categories"]
    }

@app.get("/platforms")
async def get_platforms():
    """Get all available platforms"""
    return {"platforms": get_all_platforms()}

@app.post("/search/advanced")
async def advanced_search(request: QueryRequest):
    """Advanced search with enhanced filtering"""
    result = await rag_system.search(
        query=request.query,
        max_results=request.max_results,
        category=request.category,
        min_similarity=request.min_similarity
    )
    
    # Add enhanced metadata to results
    enhanced_results = []
    for doc in result["results"]:
        enhanced_doc = doc.copy()
        enhanced_doc["enhanced_metadata"] = {
            "platform": enhanced_doc.get("metadata", {}).get("platform", "unknown"),
            "doc_type": enhanced_doc.get("metadata", {}).get("doc_type", "unknown"),
            "importance": enhanced_doc.get("metadata", {}).get("importance", "medium"),
            "complexity": enhanced_doc.get("metadata", {}).get("complexity", "intermediate"),
            "tags": enhanced_doc.get("metadata", {}).get("tags", [])
        }
        enhanced_results.append(enhanced_doc)
    
    return QueryResponse(
        results=enhanced_results,
        query_time=result["query_time"],
        total_results=result["total_results"]
    )

@app.get("/search/suggestions")
async def get_search_suggestions(query: str = ""):
    """Get intelligent search suggestions"""
    if not query:
        return {
            "suggestions": [
                "How to create account",
                "Trading API authentication",
                "Place order with X10 SDK",
                "Cairo smart contract deployment",
                "WebSocket market data",
                "NFT marketplace example",
                "Error handling best practices",
                "Starknet.dart mobile integration"
            ]
        }
    
    # Generate contextual suggestions based on query
    suggestions = []
    query_lower = query.lower()
    
    if "account" in query_lower:
        suggestions.extend([
            "Create account with X10 SDK",
            "Account management Starknet.dart",
            "Deploy account Cairo contract",
            "Account authentication Extended Exchange"
        ])
    elif "order" in query_lower:
        suggestions.extend([
            "Place limit order",
            "Cancel order API",
            "Order types Extended Exchange",
            "Order management best practices"
        ])
    elif "contract" in query_lower:
        suggestions.extend([
            "Deploy Cairo smart contract",
            "ERC20 token contract",
            "Contract testing with Forge",
            "OpenZeppelin contracts"
        ])
    else:
        suggestions.extend([
            f"{query} tutorial",
            f"{query} example",
            f"{query} API reference",
            f"How to {query}"
        ])
    
    return {"suggestions": suggestions[:8]}

@app.post("/optimize")
async def optimize_system(background_tasks: BackgroundTasks):
    """Trigger system optimization"""
    background_tasks.add_task(optimize_rag_system, rag_system.chroma_client, RAG_CONFIG["collection_name"])
    return {"status": "optimization_started", "message": "System optimization running in background"}

@app.get("/health/detailed")
async def get_detailed_health():
    """Get detailed system health report"""
    try:
        health_report = await get_rag_health(rag_system.chroma_client, RAG_CONFIG["collection_name"])
        return health_report
    except Exception as e:
        return {
            "status": "error",
            "message": f"Health check failed: {str(e)}"
        }

@app.get("/metrics")
async def get_system_metrics():
    """Get comprehensive system metrics"""
    stats = rag_system.get_stats()
    
    # Get platform breakdown
    platform_stats = {}
    if rag_system.collection:
        results = rag_system.collection.get(include=['metadatas'])
        metadatas = results['metadatas'] if results['metadatas'] else []
        
        for metadata in metadatas:
            platform = metadata.get('platform', 'unknown')
            platform_stats[platform] = platform_stats.get(platform, 0) + 1
    
    return {
        "total_documents": stats["total_documents"],
        "categories": stats["categories"],
        "platform_breakdown": platform_stats,
        "embedding_model": stats["embedding_model"],
        "last_updated": stats["last_updated"],
        "available_platforms": get_all_platforms(),
        "available_categories": get_all_categories()
    }

if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
        log_level="info"
    )