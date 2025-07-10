#!/usr/bin/env python3
"""
Debug Payload Mismatch Between Standalone and Service
Find the exact data differences causing Error 1101
"""
import json
import time
import requests
from decimal import Decimal
from starkware.crypto.signature.signature import private_to_stark_key, sign, pedersen_hash

def log_payload_data(payload_dict, label):
    """Log payload data for comparison"""
    print(f"\n{'='*60}")
    print(f"🔍 {label} - PAYLOAD DATA")
    print(f"{'='*60}")
    
    # Log the raw payload
    print("📋 RAW PAYLOAD:")
    print(json.dumps(payload_dict, indent=2, default=str))
    
    # Log data types for each field
    print(f"\n📊 DATA TYPES:")
    for key, value in payload_dict.items():
        print(f"   {key}: {type(value).__name__} = {repr(value)}")
    
    print(f"{'='*60}")

def create_standalone_order():
    """Create order using exact standalone script logic"""
    
    print("🔧 STANDALONE SCRIPT METHOD")
    print("=" * 50)
    
    # EXACT parameters from working standalone script
    private_key = "0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d"
    vault_id = 101420
    market = "EUR-USD"
    side = "BUY"
    quantity = "10"
    price = "0.7500"
    nonce = 1752080000000  # Fixed nonce for comparison
    expiry = nonce + (24 * 3600 * 1000)
    
    # Asset configuration
    assets = {
        'synthetic_asset_id': 0x4555522d5553442d38000000000000,
        'collateral_asset_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d
    }
    
    # Convert private key and derive public key
    private_key_int = int(private_key, 16)
    public_key = private_to_stark_key(private_key_int)
    
    # Calculate amounts (EXACT from standalone)
    qty_float = float(quantity)
    price_float = float(price)
    
    amount_synthetic = int(qty_float * (10 ** 10))
    amount_collateral = int(qty_float * price_float * (10 ** 6))
    fee_limit = int(amount_collateral * 0.00025)
    
    # Buy/sell parameters
    vault_sell = vault_id
    vault_buy = vault_id
    amount_sell = amount_collateral
    amount_buy = amount_synthetic
    token_sell = assets['collateral_asset_id']
    token_buy = assets['synthetic_asset_id']
    fee_token = assets['collateral_asset_id']
    
    expiration_hours = expiry // (1000 * 3600)
    
    # Create payload for hashing
    hash_payload = {
        'instruction_type': 0,
        'vault_sell': vault_sell,
        'vault_buy': vault_buy,
        'amount_sell': amount_sell,
        'amount_buy': amount_buy,
        'token_sell': token_sell,
        'token_buy': token_buy,
        'fee_token': fee_token,
        'fee_limit': fee_limit,
        'nonce': nonce,
        'expiration_hours': expiration_hours
    }
    
    # Log the payload
    log_payload_data(hash_payload, "STANDALONE SCRIPT")
    
    # Calculate hash
    message_hash = calculate_message_hash(hash_payload)
    
    # Sign
    r, s = sign(private_key_int, message_hash)
    
    return {
        'message_hash': message_hash,
        'signature': {'r': r, 's': s},
        'public_key': public_key,
        'hash_payload': hash_payload
    }

def create_service_like_order():
    """Create order simulating main service data flow"""
    
    print("\n🌐 MAIN SERVICE METHOD")
    print("=" * 50)
    
    # Simulate FastAPI request data (strings from JSON)
    request_data = {
        'market': 'EUR-USD',
        'side': 'BUY',
        'qty': '10',  # String from JSON
        'price': '0.7500',  # String from JSON
        'order_type': 'LIMIT',
        'time_in_force': 'GTT'
    }
    
    print(f"📥 Simulated request data: {request_data}")
    
    # Service configuration
    private_key = "0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d"
    vault_id = 101420
    nonce = 1752080000000  # Same nonce for comparison
    expiry = nonce + (24 * 3600 * 1000)
    
    # Asset configuration (might be from different source)
    ASSET_CONFIGS = {
        'EUR-USD': {
            'synthetic_id': 0x4555522d5553442d38000000000000,
            'collateral_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d,
            'synthetic_decimals': 10,
            'collateral_decimals': 6
        }
    }
    
    # Convert private key
    private_key_int = int(private_key, 16)
    public_key = private_to_stark_key(private_key_int)
    
    # Process request data (potential source of differences)
    market = request_data['market']
    side = request_data['side']
    quantity = request_data['qty']  # Still string
    price = request_data['price']  # Still string
    
    config = ASSET_CONFIGS[market]
    
    # Scale amounts (using service logic)
    # This might use different logic than standalone
    quantity_decimal = Decimal(quantity)
    price_decimal = Decimal(price)
    
    amount_synthetic = int(quantity_decimal * (10 ** config['synthetic_decimals']))
    amount_collateral = int(quantity_decimal * price_decimal * (10 ** config['collateral_decimals']))
    max_fee = int(amount_collateral * Decimal('0.00025'))
    
    # Determine direction
    is_buying_synthetic = 1 if side.upper() == 'BUY' else 0
    expiration_hours = expiry // (1000 * 3600)
    
    # Build parameters (service style)
    if is_buying_synthetic:
        vault_sell = vault_id
        vault_buy = vault_id
        amount_sell = amount_collateral
        amount_buy = amount_synthetic
        token_sell = config['collateral_id']
        token_buy = config['synthetic_id']
    else:
        vault_sell = vault_id
        vault_buy = vault_id
        amount_sell = amount_synthetic
        amount_buy = amount_collateral
        token_sell = config['synthetic_id']
        token_buy = config['collateral_id']
    
    fee_token = config['collateral_id']
    
    # Create payload for hashing
    hash_payload = {
        'instruction_type': 0,
        'vault_sell': vault_sell,
        'vault_buy': vault_buy,
        'amount_sell': amount_sell,
        'amount_buy': amount_buy,
        'token_sell': token_sell,
        'token_buy': token_buy,
        'fee_token': fee_token,
        'fee_limit': max_fee,
        'nonce': nonce,
        'expiration_hours': expiration_hours
    }
    
    # Log the payload
    log_payload_data(hash_payload, "MAIN SERVICE")
    
    # Calculate hash
    message_hash = calculate_message_hash(hash_payload)
    
    # Sign
    r, s = sign(private_key_int, message_hash)
    
    return {
        'message_hash': message_hash,
        'signature': {'r': r, 's': s},
        'public_key': public_key,
        'hash_payload': hash_payload
    }

def calculate_message_hash(payload):
    """Calculate message hash from payload"""
    
    print(f"\n🔐 CALCULATING MESSAGE HASH...")
    print(f"   Input payload: {payload}")
    
    # Extract parameters
    instruction_type = payload['instruction_type']
    vault_sell = payload['vault_sell']
    vault_buy = payload['vault_buy']
    amount_sell = payload['amount_sell']
    amount_buy = payload['amount_buy']
    token_sell = payload['token_sell']
    token_buy = payload['token_buy']
    fee_token = payload['fee_token']
    fee_limit = payload['fee_limit']
    nonce = payload['nonce']
    expiration_hours = payload['expiration_hours']
    
    # Calculate hash step by step
    packed_message = instruction_type
    packed_message = pedersen_hash(packed_message, vault_sell)
    packed_message = pedersen_hash(packed_message, vault_buy)
    packed_message = pedersen_hash(packed_message, amount_sell)
    packed_message = pedersen_hash(packed_message, amount_buy)
    packed_message = pedersen_hash(packed_message, token_sell)
    packed_message = pedersen_hash(packed_message, token_buy)
    packed_message = pedersen_hash(packed_message, fee_token)
    packed_message = pedersen_hash(packed_message, fee_limit)
    packed_message = pedersen_hash(packed_message, nonce)
    packed_message = pedersen_hash(packed_message, expiration_hours)
    
    print(f"   📝 Message Hash: 0x{packed_message:064x}")
    
    return packed_message

def compare_payloads():
    """Compare payloads between both methods"""
    
    print("🔍 PAYLOAD COMPARISON DEBUG")
    print("=" * 70)
    print("🎯 Finding exact differences causing Error 1101")
    print()
    
    # Create orders with both methods
    standalone_result = create_standalone_order()
    service_result = create_service_like_order()
    
    # Compare hashes
    print(f"\n📊 MESSAGE HASH COMPARISON:")
    print("=" * 50)
    standalone_hash = standalone_result['message_hash']
    service_hash = service_result['message_hash']
    
    print(f"   Standalone: 0x{standalone_hash:064x}")
    print(f"   Service:    0x{service_hash:064x}")
    print(f"   Match: {'✅ YES' if standalone_hash == service_hash else '❌ NO'}")
    
    if standalone_hash != service_hash:
        print(f"\n🔴 HASH MISMATCH DETECTED!")
        print("=" * 50)
        
        # Compare individual payload fields
        standalone_payload = standalone_result['hash_payload']
        service_payload = service_result['hash_payload']
        
        print(f"📋 FIELD-BY-FIELD COMPARISON:")
        for key in standalone_payload.keys():
            standalone_val = standalone_payload[key]
            service_val = service_payload[key]
            
            if standalone_val != service_val:
                print(f"   ❌ {key}:")
                print(f"      Standalone: {type(standalone_val).__name__} = {standalone_val}")
                print(f"      Service:    {type(service_val).__name__} = {service_val}")
            else:
                print(f"   ✅ {key}: {standalone_val}")
    
    else:
        print(f"\n✅ HASHES MATCH!")
        print("🎯 Issue might be in order payload structure or API formatting")
    
    # Compare signatures
    print(f"\n🔐 SIGNATURE COMPARISON:")
    print("=" * 50)
    standalone_sig = standalone_result['signature']
    service_sig = service_result['signature']
    
    print(f"   R values match: {'✅' if standalone_sig['r'] == service_sig['r'] else '❌'}")
    print(f"   S values match: {'✅' if standalone_sig['s'] == service_sig['s'] else '❌'}")
    
    return standalone_hash == service_hash

if __name__ == "__main__":
    matches = compare_payloads()
    
    if matches:
        print(f"\n✅ PAYLOADS IDENTICAL!")
        print("🔧 Issue must be in API request formatting or other factors")
    else:
        print(f"\n❌ PAYLOAD MISMATCH FOUND!")
        print("🎯 Fix the differences above to resolve Error 1101")