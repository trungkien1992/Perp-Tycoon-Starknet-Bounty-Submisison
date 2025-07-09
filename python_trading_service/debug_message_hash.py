#!/usr/bin/env python3
"""
Debug Message Hash Calculation
Compare our implementation with Extended Exchange exact format
"""
from starkex_crypto import create_order_signer
from starkware.crypto.signature.signature import pedersen_hash

def debug_message_hash_calculation():
    """Debug the exact message hash calculation step by step"""
    
    print("🔍 DEBUG: MESSAGE HASH CALCULATION")
    print("=" * 50)
    print("🎯 Goal: Find the exact discrepancy in our message hash vs Extended Exchange")
    print()
    
    # Use exact parameters from our working test case
    private_key = "0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d"
    vault_id = "101420"
    
    # Create signer
    signer = create_order_signer(private_key, vault_id)
    print(f"🔑 Public Key: {signer.public_key}")
    
    # Test order parameters that worked in our earlier session (got "Duplicate Order")
    market = "EUR-USD"
    side = "BUY"
    quantity = "10"
    price = "0.9000"
    nonce = 1752019757130  # Use the exact nonce that worked before
    expiration = 1752106157130  # Use the exact expiration
    
    print(f"\n📋 Order Parameters:")
    print(f"   Market: {market}")
    print(f"   Side: {side}")
    print(f"   Quantity: {quantity}")
    print(f"   Price: {price}")
    print(f"   Nonce: {nonce}")
    print(f"   Expiration: {expiration}")
    
    # Get asset configuration
    config = signer.ASSET_CONFIGS[market]
    print(f"\n🏭 Asset Configuration:")
    print(f"   Synthetic ID: 0x{config['synthetic_id']:064x}")
    print(f"   Collateral ID: 0x{config['collateral_id']:064x}")
    print(f"   Synthetic Decimals: {config['synthetic_decimals']}")
    print(f"   Collateral Decimals: {config['collateral_decimals']}")
    
    # Calculate scaled amounts
    amount_synthetic = signer._scale_amount(quantity, config['synthetic_decimals'])
    amount_collateral = signer._scale_amount(
        str(float(quantity) * float(price)), 
        config['collateral_decimals']
    )
    max_fee = signer._calculate_fee(amount_collateral)
    
    print(f"\n💰 Scaled Amounts:")
    print(f"   Synthetic Amount: {amount_synthetic}")
    print(f"   Collateral Amount: {amount_collateral}")
    print(f"   Max Fee: {max_fee}")
    
    # Convert parameters for hash calculation
    is_buying_synthetic = 1 if side.upper() == 'BUY' else 0
    expiration_hours = expiration // (1000 * 3600)
    
    print(f"\n🔢 Hash Parameters:")
    print(f"   Is Buying Synthetic: {is_buying_synthetic}")
    print(f"   Expiration Hours: {expiration_hours}")
    print(f"   Vault ID: {signer.vault_id}")
    
    # Calculate message hash step by step
    print(f"\n🧮 MESSAGE HASH CALCULATION STEPS:")
    print("=" * 50)
    
    # Determine sell/buy parameters
    vault_sell = signer.vault_id
    vault_buy = signer.vault_id
    amount_sell = amount_collateral if is_buying_synthetic else amount_synthetic
    amount_buy = amount_synthetic if is_buying_synthetic else amount_collateral
    token_sell = config['collateral_id'] if is_buying_synthetic else config['synthetic_id']
    token_buy = config['synthetic_id'] if is_buying_synthetic else config['collateral_id']
    fee_asset_id = config['collateral_id']  # Fee always in collateral
    
    print(f"Step 1 - Order Direction Setup:")
    print(f"   Vault Sell: {vault_sell}")
    print(f"   Vault Buy: {vault_buy}")
    print(f"   Amount Sell: {amount_sell}")
    print(f"   Amount Buy: {amount_buy}")
    print(f"   Token Sell: 0x{token_sell:064x}")
    print(f"   Token Buy: 0x{token_buy:064x}")
    print(f"   Fee Asset ID: 0x{fee_asset_id:064x}")
    
    # Calculate hash step by step
    instruction_type = 0
    
    print(f"\nStep 2 - Hash Calculation:")
    print(f"   Instruction Type: {instruction_type}")
    
    # Part 1: instruction type + vault info
    part1 = pedersen_hash(instruction_type, vault_sell)
    print(f"   Hash(0, {vault_sell}) = 0x{part1:064x}")
    
    part1 = pedersen_hash(part1, vault_buy)
    print(f"   Hash(prev, {vault_buy}) = 0x{part1:064x}")
    
    # Part 2: amounts
    part1 = pedersen_hash(part1, amount_sell)
    print(f"   Hash(prev, {amount_sell}) = 0x{part1:064x}")
    
    part1 = pedersen_hash(part1, amount_buy)
    print(f"   Hash(prev, {amount_buy}) = 0x{part1:064x}")
    
    # Part 3: tokens
    part1 = pedersen_hash(part1, token_sell)
    print(f"   Hash(prev, token_sell) = 0x{part1:064x}")
    
    part1 = pedersen_hash(part1, token_buy)
    print(f"   Hash(prev, token_buy) = 0x{part1:064x}")
    
    # Part 4: fee info
    part1 = pedersen_hash(part1, fee_asset_id)
    print(f"   Hash(prev, fee_asset) = 0x{part1:064x}")
    
    part1 = pedersen_hash(part1, max_fee)
    print(f"   Hash(prev, {max_fee}) = 0x{part1:064x}")
    
    # Part 5: nonce and expiration
    part1 = pedersen_hash(part1, nonce)
    print(f"   Hash(prev, {nonce}) = 0x{part1:064x}")
    
    final_hash = pedersen_hash(part1, expiration_hours)
    print(f"   Hash(prev, {expiration_hours}) = 0x{final_hash:064x}")
    
    print(f"\n🎯 FINAL MESSAGE HASH: 0x{final_hash:064x}")
    
    # Compare with our signer's calculation
    print(f"\n🔍 COMPARISON WITH SIGNER:")
    print("=" * 50)
    
    try:
        signature_result = signer.sign_order(
            market=market,
            side=side,
            quantity=quantity,
            price=price,
            nonce=nonce,
            expiration_timestamp=expiration
        )
        
        signer_hash = signature_result['msgHash']
        print(f"Our Signer Hash:    {signer_hash}")
        print(f"Step-by-step Hash:  0x{final_hash:064x}")
        print(f"Match: {'✅ YES' if signer_hash == f'0x{final_hash:064x}' else '❌ NO'}")
        
        if signer_hash != f'0x{final_hash:064x}':
            print(f"\n⚠️ HASH MISMATCH DETECTED!")
            print(f"   This suggests an issue in our signer's hash calculation")
        else:
            print(f"\n✅ Hash calculation is consistent")
            print(f"   The issue may be elsewhere (signature generation, formatting, etc.)")
            
    except Exception as e:
        print(f"❌ Error generating signature: {e}")
    
    print(f"\n📊 NEXT STEPS:")
    print("=" * 50)
    print("1. Compare with Extended Exchange Python SDK hash calculation")
    print("2. Verify asset ID values match Extended Exchange exactly")
    print("3. Check if there are any missing parameters or different ordering")
    print("4. Test with different markets to isolate the issue")

if __name__ == "__main__":
    debug_message_hash_calculation()