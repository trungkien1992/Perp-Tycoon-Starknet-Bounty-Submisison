#!/usr/bin/env python3
"""
Deep Debug StarkEx Signature Issue
Compare exact message hash calculations step by step
"""
import time
from starkex_crypto import create_order_signer
from extended_exchange_format import create_extended_exchange_order, get_limit_order_msg_with_fee
from starkware.crypto.signature.signature import pedersen_hash

def debug_message_hash_calculation():
    """Debug message hash calculation step by step"""
    
    print("🔍 DEEP DEBUGGING MESSAGE HASH CALCULATION")
    print("=" * 70)
    print("🎯 Compare starkex_crypto vs extended_exchange_format")
    print()
    
    # Common parameters
    private_key = "0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d"
    vault_id = 101420
    market = "EUR-USD"
    side = "BUY"
    quantity = "10"
    price = "0.9000"
    nonce = 1752070500000  # Fixed nonce for comparison
    expiration = nonce + (24 * 3600 * 1000)
    
    print(f"📋 Common Parameters:")
    print(f"   Market: {market}")
    print(f"   Side: {side}")
    print(f"   Quantity: {quantity}")
    print(f"   Price: ${price}")
    print(f"   Nonce: {nonce}")
    print(f"   Expiration: {expiration}")
    print()
    
    # Method 1: starkex_crypto (fixed)
    print("🔧 METHOD 1: starkex_crypto (fixed)")
    print("=" * 50)
    
    signer = create_order_signer(private_key, str(vault_id))
    signature_result = signer.sign_order(
        market=market,
        side=side,
        quantity=quantity,
        price=price,
        nonce=nonce,
        expiration_timestamp=expiration
    )
    
    msg_hash_1 = signature_result['msgHash']
    print(f"   Message Hash: {msg_hash_1}")
    print(f"   Order Details: {signature_result['orderDetails']}")
    
    # Method 2: extended_exchange_format (working)
    print(f"\n✅ METHOD 2: extended_exchange_format (working)")
    print("=" * 50)
    
    # Manually calculate with extended_exchange_format method
    # Get asset configuration
    assets = {
        'synthetic_asset_id': 0x4555522d5553442d38000000000000,
        'collateral_asset_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d
    }
    
    # Calculate amounts with proper scaling
    qty_float = float(quantity)
    price_float = float(price)
    
    # Extended Exchange scaling: synthetic=10 decimals, collateral=6 decimals
    amount_synthetic = int(qty_float * (10 ** 10))
    amount_collateral = int(qty_float * price_float * (10 ** 6))
    
    # Calculate fee (0.025% = 0.00025)
    fee_limit = int(amount_collateral * 0.00025)
    
    # Determine buy/sell parameters
    if side.upper() == 'BUY':
        # Buying synthetic with collateral
        vault_sell = vault_id
        vault_buy = vault_id
        amount_sell = amount_collateral
        amount_buy = amount_synthetic
        token_sell = assets['collateral_asset_id']
        token_buy = assets['synthetic_asset_id']
    else:
        # Selling synthetic for collateral
        vault_sell = vault_id
        vault_buy = vault_id
        amount_sell = amount_synthetic
        amount_buy = amount_collateral
        token_sell = assets['synthetic_asset_id']
        token_buy = assets['collateral_asset_id']
    
    # Fee token is always collateral
    fee_token = assets['collateral_asset_id']
    
    # Convert expiration to hours (Extended Exchange format)
    expiration_hours = expiration // (1000 * 3600)
    
    print(f"   Parameters for hash calculation:")
    print(f"     Vault Sell: {vault_sell}")
    print(f"     Vault Buy: {vault_buy}")
    print(f"     Amount Sell: {amount_sell}")
    print(f"     Amount Buy: {amount_buy}")
    print(f"     Token Sell: 0x{token_sell:064x}")
    print(f"     Token Buy: 0x{token_buy:064x}")
    print(f"     Fee Token: 0x{fee_token:064x}")
    print(f"     Fee Limit: {fee_limit}")
    print(f"     Nonce: {nonce}")
    print(f"     Expiration Hours: {expiration_hours}")
    
    # Calculate message hash using extended_exchange_format method
    msg_hash_2 = get_limit_order_msg_with_fee(
        vault_sell=vault_sell,
        vault_buy=vault_buy,
        amount_sell=amount_sell,
        amount_buy=amount_buy,
        token_sell=token_sell,
        token_buy=token_buy,
        fee_token=fee_token,
        fee_limit=fee_limit,
        nonce=nonce,
        expiration_timestamp=expiration_hours
    )
    
    print(f"   Message Hash: 0x{msg_hash_2:064x}")
    
    # Compare
    print(f"\n🔍 COMPARISON:")
    print("=" * 50)
    print(f"   Method 1 (starkex_crypto): {msg_hash_1}")
    print(f"   Method 2 (extended_format): 0x{msg_hash_2:064x}")
    print(f"   Match: {'✅ YES' if msg_hash_1 == f'0x{msg_hash_2:064x}' else '❌ NO'}")
    
    if msg_hash_1 != f"0x{msg_hash_2:064x}":
        print(f"\n🔧 DEBUGGING DIFFERENCE:")
        print("=" * 50)
        
        # Let's manually trace through starkex_crypto calculation
        config = signer.ASSET_CONFIGS[market]
        
        # starkex_crypto scaling
        amount_synthetic_1 = signer._scale_amount(quantity, config['synthetic_decimals'])
        amount_collateral_1 = signer._scale_amount(
            str(float(quantity) * float(price)), 
            config['collateral_decimals']
        )
        max_fee_1 = signer._calculate_fee(amount_collateral_1)
        is_buying_synthetic = 1 if side.upper() == 'BUY' else 0
        expiration_hours_1 = expiration // (1000 * 3600)
        
        print(f"   starkex_crypto amounts:")
        print(f"     Amount Synthetic: {amount_synthetic_1}")
        print(f"     Amount Collateral: {amount_collateral_1}")
        print(f"     Max Fee: {max_fee_1}")
        print(f"     Is Buying Synthetic: {is_buying_synthetic}")
        print(f"     Expiration Hours: {expiration_hours_1}")
        
        print(f"\n   extended_exchange_format amounts:")
        print(f"     Amount Synthetic: {amount_synthetic}")
        print(f"     Amount Collateral: {amount_collateral}")
        print(f"     Fee Limit: {fee_limit}")
        print(f"     Expiration Hours: {expiration_hours}")
        
        # Check for differences
        if amount_synthetic_1 != amount_synthetic:
            print(f"   🔴 DIFFERENCE: Synthetic amount scaling")
        if amount_collateral_1 != amount_collateral:
            print(f"   🔴 DIFFERENCE: Collateral amount scaling")
        if max_fee_1 != fee_limit:
            print(f"   🔴 DIFFERENCE: Fee calculation")
        if expiration_hours_1 != expiration_hours:
            print(f"   🔴 DIFFERENCE: Expiration conversion")
    
    else:
        print(f"\n✅ MESSAGE HASHES MATCH!")
        print("🎯 The issue might be elsewhere in the signature generation")

if __name__ == "__main__":
    debug_message_hash_calculation()