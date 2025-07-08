#!/usr/bin/env python3
"""
Enhanced Setup Script for Multi-Platform RAG System
Sets up Extended Exchange, X10 Python SDK, Cairo Smart Contracts, and Starknet.dart
"""

import subprocess
import sys
import os
import json
import asyncio
from pathlib import Path

def install_requirements():
    """Install enhanced Python requirements"""
    print("🔧 Installing enhanced requirements...")
    
    enhanced_requirements = [
        "fastapi==0.104.1",
        "uvicorn==0.24.0",
        "chromadb==0.4.18",
        "sentence-transformers==2.2.2",
        "langchain==0.0.335",
        "requests==2.31.0",
        "pandas==2.1.3",
        "numpy==1.24.4",
        "pydantic==2.5.0",
        "python-dotenv==1.0.0",
        "PyYAML==6.0.1",
        "tqdm==4.66.1",
        "aiofiles==23.2.1",
        "sqlite3"  # For optimization tracking
    ]
    
    for requirement in enhanced_requirements:
        try:
            subprocess.check_call([sys.executable, "-m", "pip", "install", requirement])
        except subprocess.CalledProcessError as e:
            print(f"⚠️ Failed to install {requirement}: {e}")
    
    print("✅ Enhanced requirements installed!")

def setup_enhanced_environment():
    """Setup enhanced environment with all platforms"""
    print("🌍 Setting up enhanced environment...")
    
    env_content = """
# Enhanced Multi-Platform RAG Configuration

# Core RAG Settings
CHROMA_DB_PATH=./chroma_db
EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2
CHUNK_SIZE=1000
CHUNK_OVERLAP=200
MAX_RESULTS=10
SIMILARITY_THRESHOLD=0.7

# Extended Exchange API Configuration
EXTENDED_EXCHANGE_API_URL=https://api.extended.exchange
EXTENDED_EXCHANGE_WS_URL=wss://ws.extended.exchange
EXTENDED_EXCHANGE_DOCS_URL=https://api.docs.extended.exchange

# X10 Python SDK Configuration
X10_GITHUB_URL=https://github.com/x10xchange/python_sdk
X10_PACKAGE_NAME=x10-python-trading

# Cairo Smart Contracts Configuration
CAIRO_BOOK_URL=https://book.cairo-lang.org
OPENZEPPELIN_CAIRO_URL=https://github.com/OpenZeppelin/cairo-contracts
STARKNET_FOUNDRY_URL=https://github.com/foundry-rs/starknet-foundry

# Starknet.dart Configuration
STARKNET_DART_URL=https://starknetdart.dev
STARKNET_DART_GITHUB=https://github.com/focustree/starknet.dart

# API Keys (Optional - for enhanced embeddings)
OPENAI_API_KEY=your_openai_api_key_here
COHERE_API_KEY=your_cohere_api_key_here

# Performance Settings
BATCH_SIZE=100
EMBEDDING_CACHE_SIZE=1000
INDEX_REFRESH_INTERVAL=3600

# Server Configuration
HOST=0.0.0.0
PORT=8000
LOG_LEVEL=INFO

# Optimization Settings
AUTO_OPTIMIZE=true
OPTIMIZE_INTERVAL=24
CLEANUP_OLD_DATA_DAYS=30
"""
    
    with open('.env', 'w') as f:
        f.write(env_content)
    
    print("✅ Enhanced environment file created (.env)")

def create_enhanced_directories():
    """Create enhanced directory structure"""
    print("📁 Creating enhanced directories...")
    
    directories = [
        "chroma_db",
        "logs",
        "cache",
        "optimization_reports",
        "backups",
        "temp",
        "data/extended_exchange",
        "data/x10_python",
        "data/cairo_contracts",
        "data/starknet_dart"
    ]
    
    for directory in directories:
        Path(directory).mkdir(parents=True, exist_ok=True)
        print(f"   Created: {directory}/")
    
    print("✅ Enhanced directories created!")

def create_optimization_config():
    """Create optimization configuration"""
    print("⚙️ Creating optimization configuration...")
    
    optimization_config = {
        "auto_optimization": {
            "enabled": True,
            "interval_hours": 24,
            "operations": [
                "remove_duplicates",
                "optimize_embeddings",
                "cleanup_metadata",
                "update_quality_scores"
            ]
        },
        "performance_monitoring": {
            "track_query_times": True,
            "track_memory_usage": True,
            "alert_thresholds": {
                "query_time_ms": 5000,
                "memory_usage_mb": 2048
            }
        },
        "data_retention": {
            "max_document_age_days": 365,
            "cleanup_frequency_days": 7,
            "backup_before_cleanup": True
        },
        "quality_control": {
            "min_content_length": 50,
            "required_metadata_fields": [
                "platform",
                "category",
                "doc_type",
                "importance"
            ],
            "auto_categorize": True
        }
    }
    
    with open('optimization_config.json', 'w') as f:
        json.dump(optimization_config, f, indent=2)
    
    print("✅ Optimization configuration created!")

def test_enhanced_installation():
    """Test the enhanced installation"""
    print("🧪 Testing enhanced installation...")
    
    try:
        # Test core imports
        import chromadb
        import sentence_transformers
        import fastapi
        import langchain
        from categorization_system import categorize_document
        from sdk_enhanced_indexer import EnhancedSDKIndexer
        from optimization_manager import RAGOptimizationManager
        
        print("✅ All enhanced packages imported successfully!")
        
        # Test ChromaDB with enhanced collection
        client = chromadb.Client()
        collection = client.create_collection(
            "test_enhanced",
            metadata={"description": "Enhanced multi-platform test"}
        )
        
        # Test enhanced document structure
        test_doc = {
            "content": "Extended Exchange API test document",
            "metadata": {
                "platform": "extended_exchange",
                "category": "trading_api",
                "doc_type": "reference",
                "importance": "high",
                "tags": ["api", "trading", "rest"]
            }
        }
        
        collection.add(
            documents=[test_doc["content"]],
            metadatas=[test_doc["metadata"]],
            ids=["test_enhanced_doc"]
        )
        
        # Test categorization
        categorization = categorize_document(
            "Extended Exchange API Overview",
            "Extended Exchange is a Layer 2 trading platform using StarkEx",
            "https://api.docs.extended.exchange"
        )
        
        if categorization["platform"] == "extended_exchange":
            print("✅ Enhanced categorization test passed!")
        else:
            print("❌ Enhanced categorization test failed!")
        
        print("🎉 Enhanced installation test completed successfully!")
        return True
        
    except Exception as e:
        print(f"❌ Enhanced installation test failed: {e}")
        return False

def create_startup_script():
    """Create enhanced startup script"""
    print("🚀 Creating startup script...")
    
    startup_script = """#!/bin/bash
# Enhanced RAG System Startup Script

echo "🚀 Starting Enhanced Multi-Platform RAG System..."

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install/update requirements
pip install -r requirements.txt

# Load environment variables
export $(cat .env | xargs)

# Start the enhanced RAG server
echo "Starting RAG server on port $PORT..."
python main.py

# Keep script running
wait
"""
    
    with open('start_rag.sh', 'w') as f:
        f.write(startup_script)
    
    os.chmod('start_rag.sh', 0o755)
    print("✅ Startup script created (start_rag.sh)")

def create_quick_test_script():
    """Create quick test script for all platforms"""
    print("🧪 Creating quick test script...")
    
    test_script = """#!/usr/bin/env python3
# Quick Test Script for Enhanced RAG System

import asyncio
import requests
import json
import time

async def test_rag_system():
    base_url = "http://localhost:8000"
    
    print("🧪 Testing Enhanced RAG System...")
    
    # Test health check
    try:
        response = requests.get(f"{base_url}/")
        if response.status_code == 200:
            print("✅ Health check passed")
        else:
            print("❌ Health check failed")
            return
    except:
        print("❌ Server not responding. Make sure the RAG server is running.")
        return
    
    # Test enhanced metrics
    try:
        response = requests.get(f"{base_url}/metrics")
        if response.status_code == 200:
            metrics = response.json()
            print(f"✅ Metrics: {metrics['total_documents']} docs across {len(metrics['platform_breakdown'])} platforms")
        else:
            print("❌ Metrics endpoint failed")
    except Exception as e:
        print(f"❌ Metrics test failed: {e}")
    
    # Test categorization endpoints
    try:
        response = requests.get(f"{base_url}/categories")
        if response.status_code == 200:
            categories = response.json()
            print(f"✅ Categories: {len(categories['categories'])} categories, {len(categories['platforms'])} platforms")
        else:
            print("❌ Categories endpoint failed")
    except Exception as e:
        print(f"❌ Categories test failed: {e}")
    
    # Test platform-specific searches
    test_queries = [
        ("Extended Exchange API", "trading_api"),
        ("X10 Python SDK authentication", "python_sdk"),
        ("Cairo smart contract deployment", "cairo_development"),
        ("Starknet.dart mobile integration", "mobile_integration")
    ]
    
    for query, expected_category in test_queries:
        try:
            response = requests.post(f"{base_url}/search", json={
                "query": query,
                "max_results": 3,
                "min_similarity": 0.5
            })
            
            if response.status_code == 200:
                results = response.json()
                result_count = results.get('total_results', 0)
                print(f"✅ Search '{query}': {result_count} results")
            else:
                print(f"❌ Search '{query}' failed")
        except Exception as e:
            print(f"❌ Search test failed for '{query}': {e}")
        
        time.sleep(0.5)  # Rate limiting
    
    # Test optimization trigger
    try:
        response = requests.post(f"{base_url}/optimize")
        if response.status_code == 200:
            print("✅ Optimization trigger successful")
        else:
            print("❌ Optimization trigger failed")
    except Exception as e:
        print(f"❌ Optimization test failed: {e}")
    
    print("🎉 Enhanced RAG system test completed!")

if __name__ == "__main__":
    asyncio.run(test_rag_system())
"""
    
    with open('test_rag.py', 'w') as f:
        f.write(test_script)
    
    os.chmod('test_rag.py', 0o755)
    print("✅ Test script created (test_rag.py)")

def main():
    """Main enhanced setup function"""
    print("🚀 Setting up Enhanced Multi-Platform RAG System...")
    print("=" * 60)
    
    try:
        # Install requirements
        install_requirements()
        
        # Setup environment
        setup_enhanced_environment()
        
        # Create directories
        create_enhanced_directories()
        
        # Create optimization config
        create_optimization_config()
        
        # Create scripts
        create_startup_script()
        create_quick_test_script()
        
        # Test installation
        if test_enhanced_installation():
            print("\n" + "=" * 60)
            print("✅ Enhanced setup completed successfully!")
            print("\n🎯 Next steps:")
            print("1. Review and update .env file with your API keys")
            print("2. Start the RAG server: ./start_rag.sh")
            print("3. Test the system: python test_rag.py")
            print("4. Index all platforms: curl -X POST http://localhost:8000/index")
            print("5. Run optimization: curl -X POST http://localhost:8000/optimize")
            print("\n📊 Available platforms:")
            print("   - Extended Exchange API (trading)")
            print("   - X10 Python SDK (client library)")
            print("   - Cairo Smart Contracts (blockchain)")
            print("   - Starknet.dart (mobile development)")
            print("\n🔍 Enhanced features:")
            print("   - Intelligent categorization")
            print("   - Multi-platform search")
            print("   - Performance optimization")
            print("   - Quality monitoring")
            print("   - Advanced filtering")
            print("\n🌟 Your enhanced RAG system is ready!")
        else:
            print("\n❌ Setup completed with errors. Please check the output above.")
            
    except Exception as e:
        print(f"\n❌ Enhanced setup failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()