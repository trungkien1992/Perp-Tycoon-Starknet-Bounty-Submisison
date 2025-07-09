#!/usr/bin/env python3
"""
Test Different Signature Format Variations
Check if the issue is in JSON formatting or field structure
"""
import time
import requests
import json
from starkex_crypto import create_order_signer

def test_signature_format_variations():
    """Test different ways of formatting the signature in the payload"""
    
    print("🔍 TESTING SIGNATURE FORMAT VARIATIONS")
    print("=" * 60)
    print("🎯 Check if Error 1101 is due to JSON formatting")
    print()
    
    # Test parameters
    private_key = "0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d"
    vault_id = "101420"
    market = "EUR-USD"
    side = "BUY"
    quantity = "10"
    price = "0.8500"  # Low price
    
    # Generate signature
    base_nonce = int(time.time() * 1000) + 3000
    expiration = base_nonce + (24 * 3600 * 1000)
    
    signer = create_order_signer(private_key, vault_id)
    sig_result = signer.sign_order(
        market=market,
        side=side,
        quantity=quantity,
        price=price,
        nonce=base_nonce,
        expiration_timestamp=expiration
    )
    
    print(f"📝 Generated Signature:")
    print(f"   R: {sig_result['signature']['r']}")
    print(f"   S: {sig_result['signature']['s']}")
    print(f"   Stark Key: {sig_result['starkKey']}")
    print()
    
    headers = {
        'Content-Type': 'application/json',
        'X-Api-Key': 'f1894fcb909e3619449c01a1f16ddde3',
        'User-Agent': 'StreetCredFormatTest/1.0.0'
    }
    
    # Test different format variations
    variations = []
    
    # Variation 1: Current format (nested signature object)
    variations.append({
        'name': 'Nested signature object',
        'payload': {
            'id': f'format_test_1_{base_nonce}',
            'market': market,
            'type': 'LIMIT',
            'side': side.upper(),
            'qty': quantity,
            'price': price,
            'timeInForce': 'GTT',
            'expiryEpochMillis': expiration,
            'fee': '0.00025',
            'nonce': str(base_nonce),
            'settlement': {
                'signature': {
                    'r': sig_result['signature']['r'],
                    's': sig_result['signature']['s']
                },
                'starkKey': sig_result['starkKey'],
                'collateralPosition': sig_result['collateralPosition']
            },
            'reduceOnly': False,
            'postOnly': False,
            'selfTradeProtectionLevel': 'ACCOUNT'
        }
    })
    
    # Variation 2: Flat signature fields
    variations.append({
        'name': 'Flat signature fields',
        'payload': {
            'id': f'format_test_2_{base_nonce + 1}',
            'market': market,
            'type': 'LIMIT',
            'side': side.upper(),
            'qty': quantity,
            'price': price,
            'timeInForce': 'GTT',
            'expiryEpochMillis': expiration,
            'fee': '0.00025',
            'nonce': str(base_nonce + 1),
            'settlement': {
                'r': sig_result['signature']['r'],
                's': sig_result['signature']['s'],
                'starkKey': sig_result['starkKey'],
                'collateralPosition': sig_result['collateralPosition']
            },
            'reduceOnly': False,
            'postOnly': False,
            'selfTradeProtectionLevel': 'ACCOUNT'
        }
    })
    
    # Variation 3: Different field names
    variations.append({
        'name': 'Different field names',
        'payload': {
            'id': f'format_test_3_{base_nonce + 2}',
            'market': market,
            'type': 'LIMIT',
            'side': side.upper(),
            'qty': quantity,
            'price': price,
            'timeInForce': 'GTT',
            'expiryEpochMillis': expiration,
            'fee': '0.00025',
            'nonce': str(base_nonce + 2),
            'settlement': {
                'signatureR': sig_result['signature']['r'],
                'signatureS': sig_result['signature']['s'],
                'starkKey': sig_result['starkKey'],
                'collateralPosition': sig_result['collateralPosition']
            },
            'reduceOnly': False,
            'postOnly': False,
            'selfTradeProtectionLevel': 'ACCOUNT'
        }
    })
    
    # Variation 4: Remove 0x prefix
    r_no_prefix = sig_result['signature']['r'][2:] if sig_result['signature']['r'].startswith('0x') else sig_result['signature']['r']
    s_no_prefix = sig_result['signature']['s'][2:] if sig_result['signature']['s'].startswith('0x') else sig_result['signature']['s']
    key_no_prefix = sig_result['starkKey'][2:] if sig_result['starkKey'].startswith('0x') else sig_result['starkKey']
    
    variations.append({
        'name': 'No 0x prefix',
        'payload': {
            'id': f'format_test_4_{base_nonce + 3}',
            'market': market,
            'type': 'LIMIT',
            'side': side.upper(),
            'qty': quantity,
            'price': price,
            'timeInForce': 'GTT',
            'expiryEpochMillis': expiration,
            'fee': '0.00025',
            'nonce': str(base_nonce + 3),
            'settlement': {
                'signature': {
                    'r': r_no_prefix,
                    's': s_no_prefix
                },
                'starkKey': key_no_prefix,
                'collateralPosition': sig_result['collateralPosition']
            },
            'reduceOnly': False,
            'postOnly': False,
            'selfTradeProtectionLevel': 'ACCOUNT'
        }
    })
    
    # Variation 5: Integer values instead of strings
    variations.append({
        'name': 'Integer values',
        'payload': {
            'id': f'format_test_5_{base_nonce + 4}',
            'market': market,
            'type': 'LIMIT',
            'side': side.upper(),
            'qty': quantity,
            'price': price,
            'timeInForce': 'GTT',
            'expiryEpochMillis': expiration,
            'fee': '0.00025',
            'nonce': str(base_nonce + 4),
            'settlement': {
                'signature': {
                    'r': int(sig_result['signature']['r'], 16),
                    's': int(sig_result['signature']['s'], 16)
                },
                'starkKey': int(sig_result['starkKey'], 16),
                'collateralPosition': int(sig_result['collateralPosition'])
            },
            'reduceOnly': False,
            'postOnly': False,
            'selfTradeProtectionLevel': 'ACCOUNT'
        }
    })
    
    # Test each variation
    for i, variation in enumerate(variations, 1):
        print(f"🧪 VARIATION {i}: {variation['name']}")
        print("=" * 50)
        
        try:
            # Print the settlement structure for debugging
            settlement = variation['payload']['settlement']
            print(f"   Settlement structure: {json.dumps(settlement, indent=4)}")
            
            response = requests.post(
                'https://api.extended.exchange/api/v1/user/order',
                headers=headers,
                json=variation['payload'],
                timeout=30
            )
            
            print(f"   📥 Status: {response.status_code}")
            
            if response.status_code == 201:
                print(f"   🎉 SUCCESS! This format works!")
                response_data = response.json()
                order_id = response_data.get('data', {}).get('id', 'Unknown')
                print(f"   ✅ Order ID: {order_id}")
                print(f"   ✅ Working format: {variation['name']}")
                break
                
            elif response.status_code == 400:
                error_data = response.json()
                error_code = error_data.get('error', {}).get('code', 'N/A')
                error_message = error_data.get('error', {}).get('message', 'Unknown')
                
                print(f"   ❌ Error {error_code}: {error_message}")
                
                if error_code == 1134:  # Duplicate order
                    print(f"   ✅ Signature valid! Just duplicate order")
                elif error_code != 1101:
                    print(f"   ✅ Signature format may be working (non-1101 error)")
                
            else:
                print(f"   ⚠️ Unexpected status: {response.status_code}")
                print(f"   Response: {response.text[:100]}...")
                
        except Exception as e:
            print(f"   💥 Exception: {e}")
        
        print()
    
    print(f"📊 SUMMARY:")
    print("=" * 50)
    print(f"   Tested {len(variations)} different signature format variations")
    print(f"   Looking for format that doesn't return Error 1101")

if __name__ == "__main__":
    test_signature_format_variations()