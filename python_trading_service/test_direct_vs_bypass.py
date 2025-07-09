#!/usr/bin/env python3
"""
Test: Direct Extended Exchange API vs CloudFront Bypass
Determine if CloudFront bypass is still necessary for trading
"""
import requests
import time
import json
from concurrent.futures import ThreadPoolExecutor
import asyncio
import aiohttp
from starkex_crypto import create_order_signer

# Test configuration
API_KEY = "f1894fcb909e3619449c01a1f16ddde3"
BASE_URL = "https://api.extended.exchange/api/v1"
VAULT_ID = "101420"
PRIVATE_KEY = "0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d"

# Headers for direct API calls
DIRECT_HEADERS = {
    'Content-Type': 'application/json',
    'X-Api-Key': API_KEY,
    'User-Agent': 'StreetCredDirectTest/1.0.0'
}

# Headers with CloudFront bypass techniques
BYPASS_HEADERS = {
    'Content-Type': 'application/json',
    'X-Api-Key': API_KEY,
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'application/json, text/plain, */*',
    'Accept-Language': 'en-US,en;q=0.9',
    'Accept-Encoding': 'gzip, deflate, br',
    'Referer': 'https://app.extended.exchange/',
    'Origin': 'https://app.extended.exchange',
    'Sec-Ch-Ua': '"Not_A Brand";v="8", "Chromium";v="120", "Google Chrome";v="120"',
    'Sec-Ch-Ua-Mobile': '?0',
    'Sec-Ch-Ua-Platform': '"macOS"',
    'Sec-Fetch-Dest': 'empty',
    'Sec-Fetch-Mode': 'cors',
    'Sec-Fetch-Site': 'same-site'
}

def test_endpoint(endpoint, headers, method='GET', json_data=None, test_name=""):
    """Test a single endpoint with given headers"""
    url = f"{BASE_URL}{endpoint}"
    
    try:
        start_time = time.time()
        
        if method == 'GET':
            response = requests.get(url, headers=headers, timeout=30)
        elif method == 'POST':
            response = requests.post(url, headers=headers, json=json_data, timeout=30)
        
        end_time = time.time()
        duration = end_time - start_time
        
        return {
            'test_name': test_name,
            'method': method,
            'endpoint': endpoint,
            'status_code': response.status_code,
            'success': response.status_code < 400,
            'blocked_by_cloudfront': response.status_code == 403 and 'CloudFront' in response.text,
            'duration_ms': round(duration * 1000, 2),
            'response_size': len(response.content),
            'error': None if response.status_code < 400 else response.text[:200]
        }
        
    except Exception as e:
        return {
            'test_name': test_name,
            'method': method,
            'endpoint': endpoint,
            'status_code': 0,
            'success': False,
            'blocked_by_cloudfront': False,
            'duration_ms': 0,
            'response_size': 0,
            'error': str(e)
        }

def test_trading_workflow():
    """Test complete trading workflow without CloudFront bypass"""
    
    print("🧪 TESTING: DIRECT API vs CLOUDFRONT BYPASS")
    print("=" * 60)
    print("🎯 Goal: Determine if CloudFront bypass is still necessary")
    print()
    
    # Test endpoints to check
    test_endpoints = [
        ('/info/markets', 'GET', None, 'Get Markets'),
        ('/user/balance', 'GET', None, 'Get Balance'), 
        ('/info/markets/EUR-USD/stats', 'GET', None, 'Get Market Data'),
    ]
    
    results = []
    
    print("📋 PHASE 1: READ-ONLY ENDPOINT TESTS")
    print("-" * 40)
    
    for endpoint, method, data, description in test_endpoints:
        print(f"\n🔍 Testing: {description}")
        
        # Test direct API call
        direct_result = test_endpoint(endpoint, DIRECT_HEADERS, method, data, f"Direct - {description}")
        results.append(direct_result)
        
        # Test with CloudFront bypass headers
        bypass_result = test_endpoint(endpoint, BYPASS_HEADERS, method, data, f"Bypass - {description}")
        results.append(bypass_result)
        
        # Compare results
        print(f"   Direct API:    Status {direct_result['status_code']}, {direct_result['duration_ms']}ms")
        print(f"   Bypass Headers: Status {bypass_result['status_code']}, {bypass_result['duration_ms']}ms")
        
        if direct_result['blocked_by_cloudfront']:
            print(f"   ❌ Direct API blocked by CloudFront")
        elif direct_result['success']:
            print(f"   ✅ Direct API working")
        else:
            print(f"   ⚠️ Direct API error: {direct_result.get('error', 'Unknown')[:50]}")
            
        if bypass_result['success'] and not direct_result['success']:
            print(f"   🛡️ CloudFront bypass still needed")
        elif direct_result['success']:
            print(f"   🚀 CloudFront bypass NO LONGER NEEDED!")
            
        time.sleep(1)  # Rate limiting
    
    print(f"\n📋 PHASE 2: TRADING ORDER TEST")
    print("-" * 40)
    
    # Create order signature for testing
    signer = create_order_signer(PRIVATE_KEY, VAULT_ID)
    
    test_nonce = int(time.time() * 1000)
    test_expiration = test_nonce + (24 * 3600 * 1000)  # 24 hours
    
    try:
        signature_result = signer.sign_order(
            market="EUR-USD",
            side="BUY",
            quantity="10",
            price="0.7500",  # Very low price - unlikely to execute
            nonce=test_nonce,
            expiration_timestamp=test_expiration
        )
        
        order_data = {
            'id': f'direct_vs_bypass_test_{test_nonce}',
            'market': 'EUR-USD',
            'type': 'LIMIT',
            'side': 'BUY',
            'qty': '10',
            'price': '0.7500',
            'timeInForce': 'GTT',
            'expiryEpochMillis': test_expiration,
            'fee': '0.00025',
            'nonce': str(test_nonce),
            'settlement': {
                'signature': signature_result['signature'],
                'starkKey': signature_result['starkKey'], 
                'collateralPosition': signature_result['collateralPosition']
            },
            'reduceOnly': False,
            'postOnly': False,
            'selfTradeProtectionLevel': 'ACCOUNT'
        }
        
        print(f"\n🔍 Testing: Order Creation")
        
        # Test direct order creation
        direct_order_result = test_endpoint('/user/order', DIRECT_HEADERS, 'POST', order_data, 'Direct - Create Order')
        results.append(direct_order_result)
        
        print(f"   Direct API Order: Status {direct_order_result['status_code']}")
        if direct_order_result['success']:
            print(f"   ✅ DIRECT TRADING SUCCESSFUL! No CloudFront bypass needed!")
        elif direct_order_result['blocked_by_cloudfront']:
            print(f"   ❌ Direct trading blocked by CloudFront")
            
            # Test with bypass if direct failed
            time.sleep(2)
            bypass_order_result = test_endpoint('/user/order', BYPASS_HEADERS, 'POST', order_data, 'Bypass - Create Order')
            results.append(bypass_order_result)
            
            print(f"   Bypass Order:     Status {bypass_order_result['status_code']}")
            if bypass_order_result['success']:
                print(f"   🛡️ CloudFront bypass still required for trading")
        else:
            error_msg = direct_order_result.get('error', '')[:100]
            print(f"   ⚠️ Order validation error: {error_msg}")
            if 'signature' in error_msg.lower() or 'duplicate' in error_msg.lower():
                print(f"   📝 This is a business logic error, not CloudFront blocking")
                print(f"   ✅ Direct API connection working for trading!")
                
    except Exception as e:
        print(f"   ❌ Order creation test failed: {e}")
    
    print(f"\n📊 SUMMARY ANALYSIS")
    print("=" * 60)
    
    # Analyze results
    direct_successes = sum(1 for r in results if 'Direct' in r['test_name'] and r['success'])
    bypass_successes = sum(1 for r in results if 'Bypass' in r['test_name'] and r['success'])
    cloudfront_blocks = sum(1 for r in results if r['blocked_by_cloudfront'])
    total_direct_tests = sum(1 for r in results if 'Direct' in r['test_name'])
    
    print(f"🎯 Direct API Success Rate: {direct_successes}/{total_direct_tests} ({round(direct_successes/total_direct_tests*100)}%)")
    print(f"🛡️ CloudFront Blocks: {cloudfront_blocks}")
    print(f"📈 Average Direct API Response Time: {round(sum(r['duration_ms'] for r in results if 'Direct' in r['test_name'] and r['success']) / max(direct_successes, 1))}ms")
    
    print(f"\n🏆 RECOMMENDATION:")
    if cloudfront_blocks == 0 and direct_successes >= total_direct_tests * 0.8:
        print(f"✅ CLOUDFRONT BYPASS NO LONGER NEEDED!")
        print(f"   • Direct API calls working reliably")
        print(f"   • No CloudFront blocking detected")
        print(f"   • Can simplify architecture by removing bypass logic")
        print(f"   • Python trading service can use direct HTTP requests")
    elif cloudfront_blocks > 0:
        print(f"⚠️ CloudFront bypass still recommended")
        print(f"   • {cloudfront_blocks} requests blocked by CloudFront")
        print(f"   • Keep bypass logic for reliability")
    else:
        print(f"❓ Mixed results - manual investigation needed")
        
    print(f"\n📋 DETAILED RESULTS:")
    print("-" * 60)
    for result in results:
        status = "✅" if result['success'] else "❌"
        print(f"{status} {result['test_name']}: {result['status_code']} ({result['duration_ms']}ms)")
        if result.get('error'):
            print(f"    Error: {result['error'][:80]}...")

if __name__ == "__main__":
    test_trading_workflow()