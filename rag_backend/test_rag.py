#!/usr/bin/env python3
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
