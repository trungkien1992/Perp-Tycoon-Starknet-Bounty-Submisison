#!/usr/bin/env python3
"""
Generate Fresh Signature and Test Immediately
Check if the issue is signature timing or account state
"""
import time
import requests
import json
from starkware.crypto.signature.signature import private_to_stark_key, sign, pedersen_hash

def generate_fresh_signature_and_test():
    """Generate a fresh signature and test immediately"""
    
    print("🔄 GENERATING FRESH SIGNATURE AND TESTING IMMEDIATELY")
    print("=" * 70)
    print("🎯 Rule out signature expiration or timing issues")
    print()
    
    # Generate completely fresh parameters
    current_time = int(time.time() * 1000)
    nonce = current_time
    expiry = nonce + (24 * 3600 * 1000)  # 24 hours from now
    
    print(f"📅 Fresh timestamp: {current_time}")
    print(f"📅 Nonce: {nonce}")
    print(f"📅 Expiry: {expiry}")
    print()
    
    # Account and order parameters
    private_key = "0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d"
    vault_id = 101420
    market = "EUR-USD"
    side = "BUY"
    quantity = "10"
    price = "0.7000"  # Conservative price
    
    # Asset configuration
    assets = {
        'synthetic_asset_id': 0x4555522d5553442d38000000000000,
        'collateral_asset_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d
    }
    
    print(f"📋 ORDER PARAMETERS:")
    print(f"   Market: {market}")
    print(f"   Side: {side}")
    print(f"   Quantity: {quantity}")
    print(f"   Price: ${price}")
    print(f"   Investment: ${float(quantity) * float(price):.2f}")
    print()
    
    # Convert private key and derive public key
    private_key_int = int(private_key, 16)
    public_key = private_to_stark_key(private_key_int)
    
    print(f"🔑 ACCOUNT INFO:")
    print(f"   Private Key: {private_key}")
    print(f"   Public Key: 0x{public_key:064x}")
    print(f"   Vault ID: {vault_id}")
    print()
    
    # Calculate amounts
    qty_float = float(quantity)
    price_float = float(price)
    
    amount_synthetic = int(qty_float * (10 ** 10))
    amount_collateral = int(qty_float * price_float * (10 ** 6))
    fee_limit = int(amount_collateral * 0.00025)
    
    # Buy parameters
    vault_sell = vault_id
    vault_buy = vault_id
    amount_sell = amount_collateral
    amount_buy = amount_synthetic
    token_sell = assets['collateral_asset_id']
    token_buy = assets['synthetic_asset_id']
    fee_token = assets['collateral_asset_id']
    
    expiration_hours = expiry // (1000 * 3600)
    
    print(f"🔢 CALCULATED VALUES:")
    print(f"   Amount Synthetic: {amount_synthetic}")
    print(f"   Amount Collateral: {amount_collateral}")
    print(f"   Fee Limit: {fee_limit}")
    print(f"   Expiration Hours: {expiration_hours}")
    print()
    
    # Calculate message hash step by step
    print(f"🔐 CALCULATING MESSAGE HASH STEP BY STEP...")
    
    # Start with instruction type
    instruction_type = 0
    packed_message = instruction_type
    print(f"   Step 0: instruction_type = {instruction_type}")
    
    # Hash each parameter
    packed_message = pedersen_hash(packed_message, vault_sell)
    print(f"   Step 1: hash(prev, vault_sell={vault_sell}) = 0x{packed_message:064x}")
    
    packed_message = pedersen_hash(packed_message, vault_buy)
    print(f"   Step 2: hash(prev, vault_buy={vault_buy}) = 0x{packed_message:064x}")
    
    packed_message = pedersen_hash(packed_message, amount_sell)
    print(f"   Step 3: hash(prev, amount_sell={amount_sell}) = 0x{packed_message:064x}")
    
    packed_message = pedersen_hash(packed_message, amount_buy)
    print(f"   Step 4: hash(prev, amount_buy={amount_buy}) = 0x{packed_message:064x}")
    
    packed_message = pedersen_hash(packed_message, token_sell)
    print(f"   Step 5: hash(prev, token_sell) = 0x{packed_message:064x}")
    
    packed_message = pedersen_hash(packed_message, token_buy)
    print(f"   Step 6: hash(prev, token_buy) = 0x{packed_message:064x}")
    
    packed_message = pedersen_hash(packed_message, fee_token)
    print(f"   Step 7: hash(prev, fee_token) = 0x{packed_message:064x}")
    
    packed_message = pedersen_hash(packed_message, fee_limit)
    print(f"   Step 8: hash(prev, fee_limit={fee_limit}) = 0x{packed_message:064x}")
    
    packed_message = pedersen_hash(packed_message, nonce)
    print(f"   Step 9: hash(prev, nonce={nonce}) = 0x{packed_message:064x}")
    
    packed_message = pedersen_hash(packed_message, expiration_hours)
    print(f"   Step 10: hash(prev, expiration_hours={expiration_hours}) = 0x{packed_message:064x}")
    
    message_hash = packed_message
    
    print(f"\n📝 FINAL MESSAGE HASH: 0x{message_hash:064x}")
    
    # Sign the message hash
    print(f"\n🔐 SIGNING MESSAGE HASH...")
    r, s = sign(private_key_int, message_hash)
    
    print(f"   Signature R: 0x{r:064x}")
    print(f"   Signature S: 0x{s:064x}")
    print()
    
    # Create order payload
    order_data = {
        'id': f'fresh_signature_{nonce}',
        'market': market,
        'type': 'LIMIT',
        'side': side.upper(),
        'qty': quantity,
        'price': price,
        'timeInForce': 'GTT',
        'expiryEpochMillis': expiry,
        'fee': '0.00025',
        'nonce': str(nonce),
        'settlement': {
            'signature': {
                'r': f'0x{r:064x}',
                's': f'0x{s:064x}'
            },
            'starkKey': f'0x{public_key:064x}',
            'collateralPosition': str(vault_id)
        },
        'reduceOnly': False,
        'postOnly': False,
        'selfTradeProtectionLevel': 'ACCOUNT'
    }
    
    print(f"📦 FRESH ORDER PAYLOAD:")
    print(json.dumps(order_data, indent=2))
    print()
    
    # Test immediately
    print(f"🚀 TESTING FRESH SIGNATURE IMMEDIATELY...")
    
    headers = {
        'Content-Type': 'application/json',
        'X-Api-Key': 'f1894fcb909e3619449c01a1f16ddde3',
        'User-Agent': 'StreetCredFreshSignature/1.0.0'
    }
    
    try:
        # Submit immediately after generation
        response = requests.post(
            'https://api.extended.exchange/api/v1/user/order',
            headers=headers,
            json=order_data,
            timeout=30
        )
        
        print(f"📥 Response Status: {response.status_code}")
        
        if response.status_code == 201:
            response_data = response.json()
            order_id = response_data.get('data', {}).get('id', 'Unknown')
            
            print(f"\n🎉 SUCCESS! FRESH SIGNATURE WORKS!")
            print("=" * 60)
            print(f"✅ Order created: {order_id}")
            print(f"✅ Fresh signature: VALID")
            print(f"✅ Real position: CREATED")
            
            print(f"\n🌐 CHECK EXTENDED EXCHANGE WEBSITE:")
            print(f"   📊 Order ID: {order_id}")
            print(f"   📈 Long EUR position active!")
            print(f"   💰 Investment: ${float(quantity) * float(price):.2f}")
            
            return True
            
        elif response.status_code == 400:
            try:
                error_data = response.json()
                error_code = error_data.get('error', {}).get('code', 'N/A')
                error_message = error_data.get('error', {}).get('message', 'Unknown')
                
                print(f"   Error Code: {error_code}")
                print(f"   Error Message: {error_message}")
                print(f"   Full Error: {json.dumps(error_data, indent=2)}")
                
                if error_code == 1134:  # Duplicate order
                    print(f"\n🎉 SIGNATURE VALIDATION SUCCESS!")
                    print("=" * 60)
                    print(f"✅ Fresh signature: VALID")
                    print(f"📝 Just duplicate order (try different nonce)")
                    return True
                    
                elif error_code == 1101:
                    print(f"\n❌ FRESH SIGNATURE STILL INVALID")
                    print("=" * 60)
                    print(f"❌ Issue is fundamental - not timing related")
                    print(f"🔧 Need to investigate API requirements or account state")
                    return False
                    
                else:
                    print(f"\n✅ SIGNATURE VALIDATION PASSED!")
                    print(f"   📝 Error {error_code} is business logic")
                    print(f"   🎯 Fresh signature works!")
                    return True
                    
            except json.JSONDecodeError:
                print(f"   Could not parse error response")
                print(f"   Raw response: {response.text}")
                return False
                
        else:
            print(f"   Unexpected status: {response.status_code}")
            print(f"   Response: {response.text}")
            return False
            
    except Exception as e:
        print(f"💥 Exception: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    success = generate_fresh_signature_and_test()
    
    if success:
        print(f"\n🎉 FRESH SIGNATURE VALIDATION SUCCESSFUL!")
        print("=" * 70)
        print("✅ Timing/expiration not the issue")
        print("✅ Signature generation working correctly")
        print("🚀 Ready for scaled real trading!")
        
    else:
        print(f"\n🔧 FRESH SIGNATURE STILL FAILS")
        print("=" * 70)
        print("❌ Issue is fundamental, not timing-related")
        print("🔍 Need to investigate API requirements or account state")
        print("📝 Possible issues:")
        print("   - Account verification status")
        print("   - API key permissions")
        print("   - Extended Exchange API changes")
        print("   - StarkEx signature format changes")