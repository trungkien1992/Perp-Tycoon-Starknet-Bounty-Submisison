#!/usr/bin/env python3
"""
Test StarkEx signature generation against Extended Exchange
"""
import requests
import json
from starkex_crypto import create_order_signer

def test_starkex_signing():
    """Test our StarkEx signature generation"""
    
    print("🧪 TESTING STARKEX SIGNATURE GENERATION")
    print("=" * 50)
    
    # Test configuration
    private_key = "0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d"
    vault_id = "101420"
    
    # Create signer
    signer = create_order_signer(private_key, vault_id)
    
    print(f"🔐 Private Key: {private_key[:20]}...")
    print(f"🏦 Vault ID: {vault_id}")
    print(f"🔑 Generated Public Key: {signer.public_key}")
    
    # Test order parameters
    market = "EUR-USD"
    side = "BUY"
    quantity = "10"
    price = "0.9000"
    nonce = 1752019757130
    expiration = 1752106157130
    
    print(f"\n📋 Test Order:")
    print(f"   Market: {market}")
    print(f"   Side: {side}")
    print(f"   Quantity: {quantity}")
    print(f"   Price: {price}")
    print(f"   Nonce: {nonce}")
    print(f"   Expiration: {expiration}")
    
    try:
        # Generate signature
        result = signer.sign_order(
            market=market,
            side=side,
            quantity=quantity,
            price=price,
            nonce=nonce,
            expiration_timestamp=expiration
        )
        
        print(f"\n✅ Signature Generation Successful!")
        print(f"🔐 Message Hash: {result['msgHash']}")
        print(f"📝 Signature R: {result['signature']['r']}")
        print(f"📝 Signature S: {result['signature']['s']}")
        print(f"🔑 Public Key: {result['starkKey']}")
        print(f"💰 Vault Position: {result['collateralPosition']}")
        
        print(f"\n📊 Order Details:")
        details = result['orderDetails']
        print(f"   Synthetic Amount: {details['amountSynthetic']}")
        print(f"   Collateral Amount: {details['amountCollateral']}")  
        print(f"   Max Fee: {details['maxFee']}")
        print(f"   Expiration Hours: {details['expirationHours']}")
        
        # Test with Extended Exchange (using our actual API)
        print(f"\n🚀 TESTING WITH EXTENDED EXCHANGE API")
        print("=" * 50)
        
        order_data = {
            'id': f'starkex_test_{nonce}',
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
                'signature': result['signature'],
                'starkKey': result['starkKey'],
                'collateralPosition': result['collateralPosition']
            },
            'reduceOnly': False,
            'postOnly': False,
            'selfTradeProtectionLevel': 'ACCOUNT'
        }
        
        headers = {
            'Content-Type': 'application/json',
            'X-Api-Key': 'f1894fcb909e3619449c01a1f16ddde3',
            'User-Agent': 'StreetCredStarkExTest/1.0.0'
        }
        
        print(f"📤 Sending order to Extended Exchange...")
        
        response = requests.post(
            'https://api.extended.exchange/api/v1/user/order',
            headers=headers,
            json=order_data,
            timeout=30
        )
        
        print(f"📥 Response Status: {response.status_code}")
        print(f"📥 Response Body: {response.text}")
        
        if response.status_code == 201:
            print(f"\n🎉 SUCCESS! Order created with native Python StarkEx signatures!")
            response_data = response.json()
            print(f"✅ Order ID: {response_data.get('data', {}).get('id', 'N/A')}")
            
        elif response.status_code == 400:
            error_data = response.json()
            error_msg = error_data.get('error', {}).get('message', 'Unknown error')
            error_code = error_data.get('error', {}).get('code', 'N/A')
            
            print(f"\n⚠️ Order validation failed:")
            print(f"   Error Code: {error_code}")
            print(f"   Error Message: {error_msg}")
            
            if "signature" in error_msg.lower() or "public key" in error_msg.lower():
                print(f"\n🔧 SIGNATURE ANALYSIS:")
                print(f"   • StarkEx signature format may need adjustment")
                print(f"   • Public key derivation method may be incorrect")
                print(f"   • Message hash calculation may differ from Extended API")
                print(f"   • Consider using Extended Exchange Python SDK")
            
        else:
            print(f"\n❌ Unexpected response: {response.status_code}")
            
    except Exception as e:
        print(f"\n❌ StarkEx signature generation failed: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    test_starkex_signing()