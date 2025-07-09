#!/usr/bin/env python3
"""
Compare Signature Generation Between Methods
Find out why starkex_crypto still fails with Error 1101
"""
import time
import requests
from starkex_crypto import create_order_signer
from extended_exchange_format import create_extended_exchange_order
from starkware.crypto.signature.signature import private_to_stark_key, sign

def compare_complete_signatures():
    """Compare complete signature generation and test both"""
    
    print("🔍 COMPARING COMPLETE SIGNATURE GENERATION")
    print("=" * 70)
    
    # Common parameters
    private_key = "0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d"
    vault_id = 101420
    market = "EUR-USD"
    side = "BUY"
    quantity = "10"
    price = "0.9000"
    nonce = int(time.time() * 1000) + 2000  # Fresh nonce
    expiration = nonce + (24 * 3600 * 1000)
    
    print(f"📋 Test Parameters:")
    print(f"   Nonce: {nonce}")
    print()
    
    # Method 1: starkex_crypto
    print("🔧 METHOD 1: starkex_crypto")
    print("=" * 40)
    
    signer = create_order_signer(private_key, str(vault_id))
    sig_result_1 = signer.sign_order(
        market=market,
        side=side,
        quantity=quantity,
        price=price,
        nonce=nonce,
        expiration_timestamp=expiration
    )
    
    print(f"   Message Hash: {sig_result_1['msgHash']}")
    print(f"   Signature R: {sig_result_1['signature']['r']}")
    print(f"   Signature S: {sig_result_1['signature']['s']}")
    print(f"   Stark Key: {sig_result_1['starkKey']}")
    print(f"   Collateral Position: {sig_result_1['collateralPosition']}")
    
    # Method 2: extended_exchange_format  
    print(f"\n✅ METHOD 2: extended_exchange_format")
    print("=" * 40)
    
    order_data_2 = create_extended_exchange_order(
        private_key_hex=private_key,
        vault_id=vault_id,
        market=market,
        side=side,
        quantity=quantity,
        price=price,
        nonce=nonce,
        expiry_timestamp=expiration
    )
    
    settlement_2 = order_data_2['settlement']
    print(f"   Signature R: {settlement_2['signature']['r']}")
    print(f"   Signature S: {settlement_2['signature']['s']}")
    print(f"   Stark Key: {settlement_2['starkKey']}")
    print(f"   Collateral Position: {settlement_2['collateralPosition']}")
    
    # Compare signatures
    print(f"\n🔍 SIGNATURE COMPARISON:")
    print("=" * 40)
    
    r1 = sig_result_1['signature']['r']
    s1 = sig_result_1['signature']['s']
    key1 = sig_result_1['starkKey']
    
    r2 = settlement_2['signature']['r']
    s2 = settlement_2['signature']['s']
    key2 = settlement_2['starkKey']
    
    print(f"   R values match: {'✅' if r1 == r2 else '❌'} ({r1 == r2})")
    print(f"   S values match: {'✅' if s1 == s2 else '❌'} ({s1 == s2})")
    print(f"   Keys match: {'✅' if key1 == key2 else '❌'} ({key1 == key2})")
    
    if r1 != r2 or s1 != s2 or key1 != key2:
        print(f"\n🔴 SIGNATURES DIFFER!")
        print(f"   Method 1 R: {r1}")
        print(f"   Method 2 R: {r2}")
        print(f"   Method 1 S: {s1}")
        print(f"   Method 2 S: {s2}")
        print(f"   Method 1 Key: {key1}")
        print(f"   Method 2 Key: {key2}")
    else:
        print(f"\n✅ SIGNATURES IDENTICAL!")
    
    # Test both with Extended Exchange
    print(f"\n🚀 TESTING BOTH WITH EXTENDED EXCHANGE:")
    print("=" * 70)
    
    headers = {
        'Content-Type': 'application/json',
        'X-Api-Key': 'f1894fcb909e3619449c01a1f16ddde3',
        'User-Agent': 'StreetCredCompareTest/1.0.0'
    }
    
    # Create order payloads
    order_1 = {
        'id': f'method1_test_{nonce}',
        'market': market,
        'type': 'LIMIT',
        'side': side.upper(),
        'qty': quantity,
        'price': price,
        'timeInForce': 'GTT',
        'expiryEpochMillis': expiration,
        'fee': '0.00025',
        'nonce': str(nonce),
        'settlement': {
            'signature': sig_result_1['signature'],
            'starkKey': sig_result_1['starkKey'],
            'collateralPosition': sig_result_1['collateralPosition']
        },
        'reduceOnly': False,
        'postOnly': False,
        'selfTradeProtectionLevel': 'ACCOUNT'
    }
    
    order_2 = order_data_2.copy()
    order_2['id'] = f'method2_test_{nonce + 1}'  # Different ID
    order_2['nonce'] = str(nonce + 1)  # Different nonce
    
    # Test method 1
    print(f"📤 Testing Method 1 (starkex_crypto)...")
    try:
        response_1 = requests.post(
            'https://api.extended.exchange/api/v1/user/order',
            headers=headers,
            json=order_1,
            timeout=30
        )
        
        print(f"   Status: {response_1.status_code}")
        if response_1.status_code == 400:
            error_1 = response_1.json()
            error_code_1 = error_1.get('error', {}).get('code', 'N/A')
            print(f"   Error: {error_code_1} - {error_1.get('error', {}).get('message', 'Unknown')}")
        elif response_1.status_code == 201:
            print(f"   ✅ SUCCESS!")
            
    except Exception as e:
        print(f"   ❌ Exception: {e}")
    
    # Test method 2
    print(f"\n📤 Testing Method 2 (extended_exchange_format)...")
    try:
        response_2 = requests.post(
            'https://api.extended.exchange/api/v1/user/order',
            headers=headers,
            json=order_2,
            timeout=30
        )
        
        print(f"   Status: {response_2.status_code}")
        if response_2.status_code == 400:
            error_2 = response_2.json()
            error_code_2 = error_2.get('error', {}).get('code', 'N/A')
            print(f"   Error: {error_code_2} - {error_2.get('error', {}).get('message', 'Unknown')}")
        elif response_2.status_code == 201:
            print(f"   ✅ SUCCESS!")
            
    except Exception as e:
        print(f"   ❌ Exception: {e}")
    
    print(f"\n📊 CONCLUSION:")
    print("=" * 40)
    print(f"   If both methods produce identical signatures but different results,")
    print(f"   the issue might be in the order payload structure or other fields.")

if __name__ == "__main__":
    compare_complete_signatures()