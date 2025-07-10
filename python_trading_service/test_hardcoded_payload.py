#!/usr/bin/env python3
"""
Test Hardcoded Payload - Isolate API Formatting Issues
Use the exact payload that worked in standalone script
"""
import time
import requests
import json

def test_hardcoded_working_payload():
    """Test with the exact payload that worked in standalone script"""
    
    print("🧪 TESTING HARDCODED WORKING PAYLOAD")
    print("=" * 60)
    print("🎯 Using exact order structure from working standalone script")
    print("💡 This will prove if issue is in payload formatting")
    print()
    
    # EXACT working payload from extended_exchange_format.py when it returned Error 1134
    # This is the payload structure that successfully passed signature validation
    
    # Generate fresh nonce
    nonce = int(time.time() * 1000)
    expiry = nonce + (24 * 3600 * 1000)
    
    # EXACT payload structure from working code
    working_order = {
        'id': f'extended_exact_{nonce}',
        'market': 'EUR-USD',
        'type': 'LIMIT',
        'side': 'BUY',
        'qty': '10',
        'price': '0.7500',
        'timeInForce': 'GTT',
        'expiryEpochMillis': expiry,
        'fee': '0.00025',
        'nonce': str(nonce),
        'settlement': {
            'signature': {
                'r': '0x051a85209b0a5d8856ca676b7e952e23b7acd1406c29ba2ead92335482911213',
                's': '0x073dc3c16913335812b4d99c8ed2a0706ade001517dcef8f2b89025f06c104a0'
            },
            'starkKey': '0x075a5dbd0f632a28521fc860e4992fa11c4fa47f6e67e1a4094ed98d49cf946e',
            'collateralPosition': '101420'
        },
        'reduceOnly': False,
        'postOnly': False,
        'selfTradeProtectionLevel': 'ACCOUNT'
    }
    
    print(f"📋 HARDCODED WORKING ORDER:")
    print(json.dumps(working_order, indent=2))
    print()
    
    # Test with Extended Exchange
    headers = {
        'Content-Type': 'application/json',
        'X-Api-Key': 'f1894fcb909e3619449c01a1f16ddde3',
        'User-Agent': 'StreetCredHardcodedTest/1.0.0'
    }
    
    print(f"🚀 SENDING HARDCODED PAYLOAD TO EXTENDED EXCHANGE...")
    
    try:
        response = requests.post(
            'https://api.extended.exchange/api/v1/user/order',
            headers=headers,
            json=working_order,
            timeout=30
        )
        
        print(f"📥 Response Status: {response.status_code}")
        
        if response.status_code == 201:
            response_data = response.json()
            order_id = response_data.get('data', {}).get('id', 'Unknown')
            
            print(f"\n🎉 SUCCESS! HARDCODED PAYLOAD WORKS!")
            print("=" * 60)
            print(f"✅ Order created: {order_id}")
            print(f"✅ Signature validation: PASSED")
            print(f"✅ Payload structure: CORRECT")
            print(f"\n🔧 CONCLUSION: Issue is in dynamic payload generation")
            
            return 'SUCCESS'
            
        elif response.status_code == 400:
            try:
                error_data = response.json()
                error_code = error_data.get('error', {}).get('code', 'N/A')
                error_message = error_data.get('error', {}).get('message', 'Unknown')
                
                print(f"   Error Code: {error_code}")
                print(f"   Error Message: {error_message}")
                
                if error_code == 1134:  # Duplicate order
                    print(f"\n🎉 SIGNATURE VALIDATION SUCCESS!")
                    print("=" * 60)
                    print(f"✅ Hardcoded payload signature: VALID")
                    print(f"✅ Order structure: CORRECT")
                    print(f"📝 Just duplicate order (expected)")
                    print(f"\n🔧 CONCLUSION: Issue is in dynamic signature generation")
                    
                    return 'SIGNATURE_VALID'
                    
                elif error_code == 1101:
                    print(f"\n❌ HARDCODED PAYLOAD ALSO FAILS!")
                    print("=" * 60)
                    print(f"❌ Even hardcoded payload has invalid signature")
                    print(f"🔧 Issue might be deeper - account state or API changes")
                    
                    return 'SIGNATURE_INVALID'
                    
                else:
                    print(f"\n✅ SIGNATURE VALIDATION PASSED!")
                    print(f"   📝 Error {error_code} is business logic")
                    print(f"   🎯 Hardcoded structure works!")
                    
                    return 'BUSINESS_ERROR'
                    
            except json.JSONDecodeError:
                print(f"   Could not parse error response")
                print(f"   Raw response: {response.text}")
                return 'PARSE_ERROR'
                
        else:
            print(f"   Unexpected status: {response.status_code}")
            print(f"   Response: {response.text}")
            return 'UNEXPECTED'
            
    except Exception as e:
        print(f"💥 Exception: {e}")
        return 'EXCEPTION'

def test_different_payload_variations():
    """Test different payload structure variations"""
    
    print(f"\n🧪 TESTING PAYLOAD STRUCTURE VARIATIONS")
    print("=" * 60)
    
    base_nonce = int(time.time() * 1000) + 1000
    base_expiry = base_nonce + (24 * 3600 * 1000)
    
    # Test different payload structures
    variations = []
    
    # Variation 1: Current structure (nested signature)
    variations.append({
        'name': 'Nested signature structure',
        'payload': {
            'id': f'test_nested_{base_nonce}',
            'market': 'EUR-USD',
            'type': 'LIMIT',
            'side': 'BUY',
            'qty': '10',
            'price': '0.7500',
            'timeInForce': 'GTT',
            'expiryEpochMillis': base_expiry,
            'fee': '0.00025',
            'nonce': str(base_nonce),
            'settlement': {
                'signature': {
                    'r': '0x051a85209b0a5d8856ca676b7e952e23b7acd1406c29ba2ead92335482911213',
                    's': '0x073dc3c16913335812b4d99c8ed2a0706ade001517dcef8f2b89025f06c104a0'
                },
                'starkKey': '0x075a5dbd0f632a28521fc860e4992fa11c4fa47f6e67e1a4094ed98d49cf946e',
                'collateralPosition': '101420'
            },
            'reduceOnly': False,
            'postOnly': False,
            'selfTradeProtectionLevel': 'ACCOUNT'
        }
    })
    
    # Variation 2: Move signature to top level
    variations.append({
        'name': 'Top-level signature fields',
        'payload': {
            'id': f'test_toplevel_{base_nonce + 1}',
            'market': 'EUR-USD',
            'type': 'LIMIT',
            'side': 'BUY',
            'qty': '10',
            'price': '0.7500',
            'timeInForce': 'GTT',
            'expiryEpochMillis': base_expiry,
            'fee': '0.00025',
            'nonce': str(base_nonce + 1),
            'signatureR': '0x051a85209b0a5d8856ca676b7e952e23b7acd1406c29ba2ead92335482911213',
            'signatureS': '0x073dc3c16913335812b4d99c8ed2a0706ade001517dcef8f2b89025f06c104a0',
            'starkKey': '0x075a5dbd0f632a28521fc860e4992fa11c4fa47f6e67e1a4094ed98d49cf946e',
            'collateralPosition': '101420',
            'reduceOnly': False,
            'postOnly': False,
            'selfTradeProtectionLevel': 'ACCOUNT'
        }
    })
    
    # Variation 3: Different field names
    variations.append({
        'name': 'Alternative field names',
        'payload': {
            'orderId': f'test_alt_{base_nonce + 2}',
            'symbol': 'EUR-USD',
            'orderType': 'LIMIT',
            'direction': 'BUY',
            'quantity': '10',
            'limitPrice': '0.7500',
            'timeInForce': 'GTT',
            'expiration': base_expiry,
            'feeRate': '0.00025',
            'clientOrderId': str(base_nonce + 2),
            'starkSignature': {
                'r': '0x051a85209b0a5d8856ca676b7e952e23b7acd1406c29ba2ead92335482911213',
                's': '0x073dc3c16913335812b4d99c8ed2a0706ade001517dcef8f2b89025f06c104a0',
                'publicKey': '0x075a5dbd0f632a28521fc860e4992fa11c4fa47f6e67e1a4094ed98d49cf946e',
                'vaultId': '101420'
            }
        }
    })
    
    headers = {
        'Content-Type': 'application/json',
        'X-Api-Key': 'f1894fcb909e3619449c01a1f16ddde3',
        'User-Agent': 'StreetCredVariationTest/1.0.0'
    }
    
    results = []
    
    for i, variation in enumerate(variations, 1):
        print(f"\n🧪 VARIATION {i}: {variation['name']}")
        print("-" * 40)
        
        try:
            response = requests.post(
                'https://api.extended.exchange/api/v1/user/order',
                headers=headers,
                json=variation['payload'],
                timeout=30
            )
            
            print(f"   Status: {response.status_code}")
            
            if response.status_code == 201:
                print(f"   ✅ SUCCESS! Working structure found!")
                results.append((variation['name'], 'SUCCESS'))
                break
                
            elif response.status_code == 400:
                error_data = response.json()
                error_code = error_data.get('error', {}).get('code', 'N/A')
                print(f"   Error: {error_code}")
                
                if error_code == 1134:
                    print(f"   ✅ Signature valid (duplicate order)")
                    results.append((variation['name'], 'SIGNATURE_VALID'))
                elif error_code == 1101:
                    print(f"   ❌ Invalid signature")
                    results.append((variation['name'], 'SIGNATURE_INVALID'))
                else:
                    print(f"   ⚠️  Other error: {error_code}")
                    results.append((variation['name'], f'ERROR_{error_code}'))
            else:
                print(f"   ⚠️  Status: {response.status_code}")
                results.append((variation['name'], f'HTTP_{response.status_code}'))
                
        except Exception as e:
            print(f"   💥 Exception: {e}")
            results.append((variation['name'], 'EXCEPTION'))
    
    print(f"\n📊 VARIATION TEST RESULTS:")
    print("=" * 50)
    for name, result in results:
        emoji = '✅' if result in ['SUCCESS', 'SIGNATURE_VALID'] else '❌'
        print(f"   {emoji} {name}: {result}")

if __name__ == "__main__":
    print("🔍 PAYLOAD STRUCTURE DEBUGGING")
    print("=" * 70)
    print("🎯 Isolating API formatting issues")
    print()
    
    # Test hardcoded payload first
    result = test_hardcoded_working_payload()
    
    if result == 'SIGNATURE_INVALID':
        print(f"\n🔧 Even hardcoded payload fails - deeper investigation needed")
    elif result in ['SUCCESS', 'SIGNATURE_VALID']:
        print(f"\n✅ Hardcoded payload works!")
        print("🔧 Issue is in dynamic payload generation")
        
        # Test different structures
        test_different_payload_variations()
    else:
        print(f"\n⚠️  Unexpected result: {result}")
        print("🔧 Need manual investigation")