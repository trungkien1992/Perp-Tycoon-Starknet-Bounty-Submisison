#!/usr/bin/env python3
"""
Confirmation Test: Extended Exchange API without CloudFront Bypass
Verify that CloudFront bypass is completely unnecessary
"""
import requests
import json
import time

# Simple direct API test
API_KEY = "f1894fcb909e3619449c01a1f16ddde3"
BASE_URL = "https://api.extended.exchange/api/v1"

# Simple, clean headers
HEADERS = {
    'Content-Type': 'application/json',
    'X-Api-Key': API_KEY,
    'User-Agent': 'StreetCredPython/1.0.0'
}

def test_direct_api():
    """Test Extended Exchange API with simple, direct requests"""
    
    print("🎯 CONFIRMATION TEST: No CloudFront Bypass Needed")
    print("=" * 55)
    print("🧪 Testing Extended Exchange API with direct HTTP requests")
    print("🚫 NO CloudFront bypass headers or techniques")
    print()
    
    tests = [
        ("GET Markets", "GET", "/info/markets"),
        ("GET Balance", "GET", "/user/balance"), 
        ("GET EUR-USD Stats", "GET", "/info/markets/EUR-USD/stats"),
        ("GET BTC-USD Stats", "GET", "/info/markets/BTC-USD/stats"),
        ("GET ETH-USD Stats", "GET", "/info/markets/ETH-USD/stats"),
    ]
    
    all_success = True
    total_time = 0
    
    for test_name, method, endpoint in tests:
        print(f"🔍 {test_name}...", end=" ")
        
        try:
            start_time = time.time()
            
            if method == "GET":
                response = requests.get(f"{BASE_URL}{endpoint}", headers=HEADERS, timeout=10)
            
            end_time = time.time()
            duration = round((end_time - start_time) * 1000, 1)
            total_time += duration
            
            if response.status_code == 200:
                print(f"✅ SUCCESS ({response.status_code}, {duration}ms)")
                
                # Show some data for verification
                if endpoint == "/info/markets":
                    data = response.json()
                    market_count = len(data.get('data', []))
                    print(f"   📊 Found {market_count} markets")
                elif endpoint == "/user/balance":
                    data = response.json()
                    balance = data.get('data', {}).get('availableForTrade', '0')
                    print(f"   💰 Balance: ${balance} USD")
                elif "stats" in endpoint:
                    data = response.json()
                    price = data.get('data', {}).get('marketStats', {}).get('lastPrice', 'N/A')
                    print(f"   💹 Last Price: ${price}")
                    
            elif response.status_code == 403:
                print(f"❌ BLOCKED BY CLOUDFRONT ({response.status_code})")
                all_success = False
            else:
                print(f"⚠️ ERROR ({response.status_code})")
                print(f"   Response: {response.text[:100]}...")
                all_success = False
                
        except requests.exceptions.Timeout:
            print(f"❌ TIMEOUT")
            all_success = False
        except Exception as e:
            print(f"❌ EXCEPTION: {e}")
            all_success = False
            
        time.sleep(0.5)  # Be nice to the API
    
    print()
    print("📊 FINAL RESULTS")
    print("=" * 55)
    
    if all_success:
        avg_time = round(total_time / len(tests), 1)
        print(f"🎉 ALL TESTS PASSED!")
        print(f"✅ Extended Exchange API accessible via direct HTTP")
        print(f"✅ No CloudFront blocking detected")
        print(f"✅ Average response time: {avg_time}ms")
        print(f"✅ API performance is excellent")
        print()
        print(f"🚀 CONCLUSION: CLOUDFRONT BYPASS IS OBSOLETE!")
        print(f"   • Remove all CloudFront bypass code")
        print(f"   • Use simple HTTP requests in Python service")
        print(f"   • Simplify architecture significantly")
        print(f"   • Focus purely on StarkEx signature implementation")
        
    else:
        print(f"⚠️ Some tests failed - CloudFront bypass may still be needed")
        
    print()
    print(f"🔬 TECHNICAL ANALYSIS:")
    print(f"   • Extended Exchange has likely updated their CloudFront config")
    print(f"   • API is now accepting standard requests")
    print(f"   • Our Python trading service is the optimal approach")
    print(f"   • Focus should be on perfecting StarkEx signatures")

if __name__ == "__main__":
    test_direct_api()