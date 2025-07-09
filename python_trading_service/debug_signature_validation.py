#!/usr/bin/env python3
"""
Debug StarkEx Signature Validation - Error 1101 Analysis
Comprehensive logging to validate assumptions about signature format mismatch
"""
import json
import time
import requests
from typing import Dict, Any
from starkex_crypto import create_order_signer
from extended_exchange_format import create_extended_exchange_order

def log_signature_components(signature_data: Dict[str, Any], label: str):
    """Log detailed signature components for analysis"""
    print(f"\n{'='*60}")
    print(f"📊 {label} - SIGNATURE COMPONENTS")
    print(f"{'='*60}")
    
    # Extract signature components
    signature = signature_data.get('signature', {})
    r_value = signature.get('r', 'N/A')
    s_value = signature.get('s', 'N/A')
    stark_key = signature_data.get('starkKey', 'N/A')
    msg_hash = signature_data.get('msgHash', 'N/A')
    
    print(f"🔐 Signature R: {r_value}")
    print(f"   Length: {len(r_value)} characters")
    print(f"   Format: {'0x' + '0'*62 + '[hex]' if r_value.startswith('0x') else 'Invalid'}")
    
    print(f"🔐 Signature S: {s_value}")
    print(f"   Length: {len(s_value)} characters")
    print(f"   Format: {'0x' + '0'*62 + '[hex]' if s_value.startswith('0x') else 'Invalid'}")
    
    print(f"🔑 Stark Key: {stark_key}")
    print(f"   Length: {len(stark_key)} characters")
    print(f"   Format: {'0x' + '0'*62 + '[hex]' if stark_key.startswith('0x') else 'Invalid'}")
    
    print(f"📝 Message Hash: {msg_hash}")
    print(f"   Length: {len(msg_hash)} characters")
    print(f"   Format: {'0x' + '0'*62 + '[hex]' if msg_hash.startswith('0x') else 'Invalid'}")
    
    # Order details if available
    if 'orderDetails' in signature_data:
        details = signature_data['orderDetails']
        print(f"\n📋 Order Details:")
        print(f"   Market: {details.get('market', 'N/A')}")
        print(f"   Side: {details.get('side', 'N/A')}")
        print(f"   Amount Synthetic: {details.get('amountSynthetic', 'N/A')}")
        print(f"   Amount Collateral: {details.get('amountCollateral', 'N/A')}")
        print(f"   Max Fee: {details.get('maxFee', 'N/A')}")
        print(f"   Nonce: {details.get('nonce', 'N/A')}")
        print(f"   Expiration Hours: {details.get('expirationHours', 'N/A')}")

def log_order_payload(order_data: Dict[str, Any], label: str):
    """Log complete order payload for Extended Exchange"""
    print(f"\n{'='*60}")
    print(f"📦 {label} - ORDER PAYLOAD")
    print(f"{'='*60}")
    
    # Main order fields
    print(f"🏷️  Order ID: {order_data.get('id', 'N/A')}")
    print(f"📈 Market: {order_data.get('market', 'N/A')}")
    print(f"📊 Type: {order_data.get('type', 'N/A')}")
    print(f"↗️  Side: {order_data.get('side', 'N/A')}")
    print(f"📏 Quantity: {order_data.get('qty', 'N/A')}")
    print(f"💰 Price: {order_data.get('price', 'N/A')}")
    print(f"⏰ Time In Force: {order_data.get('timeInForce', 'N/A')}")
    print(f"⏳ Expiry: {order_data.get('expiryEpochMillis', 'N/A')}")
    print(f"💸 Fee: {order_data.get('fee', 'N/A')}")
    print(f"🎲 Nonce: {order_data.get('nonce', 'N/A')}")
    
    # Settlement details
    settlement = order_data.get('settlement', {})
    print(f"\n⚖️  Settlement Details:")
    print(f"   Stark Key: {settlement.get('starkKey', 'N/A')}")
    print(f"   Collateral Position: {settlement.get('collateralPosition', 'N/A')}")
    
    # Signature within settlement
    sig = settlement.get('signature', {})
    print(f"   Signature R: {sig.get('r', 'N/A')}")
    print(f"   Signature S: {sig.get('s', 'N/A')}")
    
    # Additional flags
    print(f"\n🏁 Flags:")
    print(f"   Reduce Only: {order_data.get('reduceOnly', 'N/A')}")
    print(f"   Post Only: {order_data.get('postOnly', 'N/A')}")
    print(f"   Self Trade Protection: {order_data.get('selfTradeProtectionLevel', 'N/A')}")

def test_order_with_logging(method_name: str, order_creator_func, *args, **kwargs):
    """Test order creation with comprehensive logging"""
    
    print(f"\n{'🧪 ' + method_name.upper() + ' TEST'}")
    print(f"{'='*80}")
    
    try:
        # Create order/signature
        print(f"🔧 Creating order with {method_name}...")
        if method_name == "starkex_crypto":
            # For starkex_crypto, we need to create the signer and call sign_order
            signer = create_order_signer(
                kwargs['private_key_hex'], 
                kwargs['vault_id']
            )
            
            signature_data = signer.sign_order(
                market=kwargs['market'],
                side=kwargs['side'],
                quantity=kwargs['quantity'],
                price=kwargs['price'],
                nonce=kwargs['nonce'],
                expiration_timestamp=kwargs['expiration_timestamp']
            )
            
            # Log signature components
            log_signature_components(signature_data, f"{method_name.upper()} METHOD")
            
            # Create order payload for Extended Exchange
            order_data = {
                'id': f'{method_name}_test_{kwargs["nonce"]}',
                'market': kwargs['market'],
                'type': 'LIMIT',
                'side': kwargs['side'].upper(),
                'qty': kwargs['quantity'],
                'price': kwargs['price'],
                'timeInForce': 'GTT',
                'expiryEpochMillis': kwargs['expiration_timestamp'],
                'fee': '0.00025',
                'nonce': str(kwargs['nonce']),
                'settlement': {
                    'signature': signature_data['signature'],
                    'starkKey': signature_data['starkKey'],
                    'collateralPosition': signature_data['collateralPosition']
                },
                'reduceOnly': False,
                'postOnly': False,
                'selfTradeProtectionLevel': 'ACCOUNT'
            }
            
        else:
            # For extended_exchange_format
            order_data = order_creator_func(*args, **kwargs)
            
            # Extract signature data for logging
            settlement = order_data.get('settlement', {})
            signature_data = {
                'signature': settlement.get('signature', {}),
                'starkKey': settlement.get('starkKey', 'N/A'),
                'collateralPosition': settlement.get('collateralPosition', 'N/A'),
                'msgHash': 'N/A'  # Not directly available in extended format
            }
            
            log_signature_components(signature_data, f"{method_name.upper()} METHOD")
        
        # Log complete order payload
        log_order_payload(order_data, f"{method_name.upper()} METHOD")
        
        # Test with Extended Exchange API
        print(f"\n🚀 TESTING WITH EXTENDED EXCHANGE API...")
        print(f"{'='*60}")
        
        headers = {
            'Content-Type': 'application/json',
            'X-Api-Key': 'f1894fcb909e3619449c01a1f16ddde3',
            'User-Agent': f'StreetCred{method_name.title()}Test/1.0.0'
        }
        
        print(f"🌐 Sending request to Extended Exchange...")
        print(f"   Method: POST")
        print(f"   URL: https://api.extended.exchange/api/v1/user/order")
        print(f"   Headers: {json.dumps(headers, indent=4)}")
        
        response = requests.post(
            'https://api.extended.exchange/api/v1/user/order',
            headers=headers,
            json=order_data,
            timeout=30
        )
        
        print(f"\n📥 EXTENDED EXCHANGE RESPONSE:")
        print(f"{'='*60}")
        print(f"   Status Code: {response.status_code}")
        print(f"   Response Headers: {dict(response.headers)}")
        
        if response.status_code == 201:
            response_data = response.json()
            print(f"\n🎉 SUCCESS! Order created successfully!")
            print(f"   ✅ Order ID: {response_data.get('data', {}).get('id', 'N/A')}")
            print(f"   ✅ Method '{method_name}' signature validation: PASSED")
            return 'SUCCESS'
            
        elif response.status_code == 400:
            try:
                error_data = response.json()
                error_code = error_data.get('error', {}).get('code', 'N/A')
                error_message = error_data.get('error', {}).get('message', 'Unknown')
                
                print(f"   ❌ Error Code: {error_code}")
                print(f"   ❌ Error Message: {error_message}")
                print(f"   📄 Full Error Response: {json.dumps(error_data, indent=4)}")
                
                if error_code == 1101:
                    print(f"\n🔍 SIGNATURE VALIDATION FAILED (Error 1101):")
                    print(f"   ❌ Method '{method_name}' signature format: INVALID")
                    print(f"   📝 This confirms signature format mismatch")
                    return 'SIGNATURE_INVALID'
                    
                elif error_code == 1134:
                    print(f"\n✅ SIGNATURE VALIDATION PASSED (Duplicate Order):")
                    print(f"   ✅ Method '{method_name}' signature format: VALID")
                    print(f"   📝 Error is just duplicate order (expected)")
                    return 'SIGNATURE_VALID'
                    
                else:
                    print(f"\n🔍 BUSINESS LOGIC ERROR:")
                    print(f"   ⚠️  Method '{method_name}' signature may be valid")
                    print(f"   📝 Error appears to be order parameter issue")
                    return 'BUSINESS_ERROR'
                    
            except json.JSONDecodeError:
                print(f"   ❌ Could not parse error response")
                print(f"   📄 Raw response: {response.text}")
                return 'PARSE_ERROR'
                
        else:
            print(f"   ❌ Unexpected status code: {response.status_code}")
            print(f"   📄 Response: {response.text}")
            return 'UNEXPECTED_ERROR'
            
    except Exception as e:
        print(f"\n💥 EXCEPTION in {method_name} test:")
        print(f"   ❌ Error: {str(e)}")
        print(f"   📝 This suggests implementation issue")
        return 'EXCEPTION'

def main():
    """Main debug function to test both signature methods"""
    
    print(f"🔍 STARKEX SIGNATURE VALIDATION DEBUG")
    print(f"{'='*80}")
    print(f"📝 Testing both signature methods to identify Error 1101 source")
    print(f"🎯 Goal: Determine which method produces valid signatures")
    print()
    
    # Test parameters
    private_key = "0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d"
    vault_id = "101420"
    market = "EUR-USD"
    side = "BUY"
    quantity = "10"
    price = "0.9500"  # Conservative price
    nonce = int(time.time() * 1000)
    expiration = nonce + (24 * 3600 * 1000)  # 24 hours
    
    print(f"📋 Common Test Parameters:")
    print(f"   Private Key: {private_key}")
    print(f"   Vault ID: {vault_id}")
    print(f"   Market: {market}")
    print(f"   Side: {side}")
    print(f"   Quantity: {quantity}")
    print(f"   Price: ${price}")
    print(f"   Nonce: {nonce}")
    print(f"   Expiration: {expiration}")
    
    # Test results
    results = {}
    
    # Test 1: starkex_crypto method
    print(f"\n" + "="*80)
    print(f"🧪 TEST 1: starkex_crypto.py method")
    print(f"="*80)
    
    results['starkex_crypto'] = test_order_with_logging(
        "starkex_crypto",
        None,  # No order creator function needed
        private_key_hex=private_key,
        vault_id=vault_id,
        market=market,
        side=side,
        quantity=quantity,
        price=price,
        nonce=nonce,
        expiration_timestamp=expiration
    )
    
    # Test 2: extended_exchange_format method
    print(f"\n" + "="*80)
    print(f"🧪 TEST 2: extended_exchange_format.py method")
    print(f"="*80)
    
    results['extended_exchange_format'] = test_order_with_logging(
        "extended_exchange_format",
        create_extended_exchange_order,
        private_key_hex=private_key,
        vault_id=int(vault_id),
        market=market,
        side=side,
        quantity=quantity,
        price=price,
        nonce=nonce,
        expiry_timestamp=expiration
    )
    
    # Analysis
    print(f"\n" + "="*80)
    print(f"📊 COMPREHENSIVE ANALYSIS")
    print(f"="*80)
    
    print(f"📈 Test Results Summary:")
    for method, result in results.items():
        status_emoji = {
            'SUCCESS': '✅',
            'SIGNATURE_VALID': '✅',
            'SIGNATURE_INVALID': '❌',
            'BUSINESS_ERROR': '⚠️',
            'PARSE_ERROR': '🔧',
            'UNEXPECTED_ERROR': '❓',
            'EXCEPTION': '💥'
        }.get(result, '❓')
        
        print(f"   {status_emoji} {method}: {result}")
    
    # Conclusions
    print(f"\n🎯 CONCLUSIONS:")
    
    valid_methods = [method for method, result in results.items() 
                    if result in ['SUCCESS', 'SIGNATURE_VALID', 'BUSINESS_ERROR']]
    invalid_methods = [method for method, result in results.items() 
                      if result == 'SIGNATURE_INVALID']
    
    if valid_methods:
        print(f"   ✅ Working signature methods: {', '.join(valid_methods)}")
        print(f"   📝 These methods produce valid StarkEx signatures")
    
    if invalid_methods:
        print(f"   ❌ Invalid signature methods: {', '.join(invalid_methods)}")
        print(f"   🔧 These methods need signature format correction")
    
    if len(valid_methods) == 1:
        working_method = valid_methods[0]
        print(f"\n💡 RECOMMENDATION:")
        print(f"   🎯 Use '{working_method}' method for signature generation")
        print(f"   🔧 Fix or replace other methods with working implementation")
    
    elif len(valid_methods) > 1:
        print(f"\n💡 RECOMMENDATION:")
        print(f"   🎯 Multiple methods work - choose most reliable/performant")
        print(f"   📝 Consider consolidating to single implementation")
    
    else:
        print(f"\n🔧 DEBUGGING NEEDED:")
        print(f"   ❌ No methods produce valid signatures")
        print(f"   🔍 Need to investigate signature format requirements further")
        print(f"   📝 Consider checking Extended Exchange documentation")

if __name__ == "__main__":
    main()