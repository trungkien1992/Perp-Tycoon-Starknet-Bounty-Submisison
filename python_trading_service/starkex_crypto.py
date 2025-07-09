"""
StarkEx Cryptographic Functions
Native Python implementation for Extended Exchange signature generation
"""
import hashlib
import hmac
from typing import Tuple, Dict
from decimal import Decimal
import time

try:
    # Try to import official StarkWare crypto library from cairo-lang
    from starkware.crypto.signature.signature import private_to_stark_key, sign, pedersen_hash
    STARKWARE_CRYPTO_AVAILABLE = True
except ImportError:
    STARKWARE_CRYPTO_AVAILABLE = False

try:
    # Try to import fast crypto library if available
    from fast_stark_crypto import pedersen_hash as fast_pedersen, sign as fast_sign
    FAST_CRYPTO_AVAILABLE = True
except ImportError:
    FAST_CRYPTO_AVAILABLE = False

# Fallback to pure Python implementation
def _pedersen_hash_fallback(a: int, b: int) -> int:
    """
    Fallback Pedersen hash implementation
    This is a simplified version - in production, use the official StarkWare implementation
    """
    # This is a placeholder implementation
    # In practice, you would use the official starkware.crypto.signature.pedersen_hash
    combined = f"{a}{b}".encode()
    hash_obj = hashlib.sha256(combined)
    return int(hash_obj.hexdigest(), 16) % (2**251)

def pedersen_hash_func(a: int, b: int) -> int:
    """Pedersen hash function with fallback"""
    if STARKWARE_CRYPTO_AVAILABLE:
        return pedersen_hash(a, b)
    elif FAST_CRYPTO_AVAILABLE:
        return fast_pedersen(a, b)
    else:
        return _pedersen_hash_fallback(a, b)

def _generate_k_rfc6979(msg_hash: int, private_key: int) -> int:
    """
    Generate k value using RFC6979 for deterministic signatures
    This is a simplified implementation
    """
    # Convert to bytes for HMAC
    msg_bytes = msg_hash.to_bytes(32, 'big')
    key_bytes = private_key.to_bytes(32, 'big')
    
    # RFC6979 implementation (simplified)
    v = b'\x01' * 32
    k = b'\x00' * 32
    
    k = hmac.new(k, v + b'\x00' + key_bytes + msg_bytes, hashlib.sha256).digest()
    v = hmac.new(k, v, hashlib.sha256).digest()
    k = hmac.new(k, v + b'\x01' + key_bytes + msg_bytes, hashlib.sha256).digest()
    v = hmac.new(k, v, hashlib.sha256).digest()
    
    while True:
        v = hmac.new(k, v, hashlib.sha256).digest()
        candidate = int.from_bytes(v, 'big')
        if 1 <= candidate < 2**251:
            return candidate
        k = hmac.new(k, v + b'\x00', hashlib.sha256).digest()
        v = hmac.new(k, v, hashlib.sha256).digest()

def _sign_fallback(private_key: int, msg_hash: int) -> Tuple[int, int]:
    """
    Fallback ECDSA signature implementation
    This is a placeholder - use official StarkWare implementation in production
    """
    # This is a simplified implementation
    # In practice, use starkware.crypto.signature.sign
    k = _generate_k_rfc6979(msg_hash, private_key)
    
    # Simplified signature calculation (placeholder)
    r = (k * 123456789) % (2**251)  # Placeholder calculation
    s = (msg_hash + private_key * r) % (2**251)  # Placeholder calculation
    
    return (r, s)

def sign_func(private_key: int, msg_hash: int) -> Tuple[int, int]:
    """Sign message hash with private key"""
    if STARKWARE_CRYPTO_AVAILABLE:
        return sign(private_key, msg_hash)
    elif FAST_CRYPTO_AVAILABLE:
        k = _generate_k_rfc6979(msg_hash, private_key)
        return fast_sign(private_key=private_key, msg_hash=msg_hash, k=k)
    else:
        return _sign_fallback(private_key, msg_hash)

class StarkExOrderSigner:
    """Extended Exchange order signer with proper StarkEx implementation"""
    
    # Extended Exchange asset configurations
    ASSET_CONFIGS = {
        'BTC-USD': {
            'synthetic_id': 0x4254432d38000000000000000000000,
            'collateral_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d,
            'synthetic_decimals': 10,
            'collateral_decimals': 6
        },
        'ETH-USD': {
            'synthetic_id': 0x4554482d38000000000000000000000,
            'collateral_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d,
            'synthetic_decimals': 10,
            'collateral_decimals': 6
        },
        'EUR-USD': {
            'synthetic_id': 0x4555522d5553442d38000000000000,
            'collateral_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d,
            'synthetic_decimals': 10,
            'collateral_decimals': 6
        },
        'AVAX-USD': {
            'synthetic_id': 0x415641582d555344000000000000000,
            'collateral_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d,
            'synthetic_decimals': 10,
            'collateral_decimals': 6
        },
        'BNB-USD': {
            'synthetic_id': 0x424e422d55534400000000000000000,
            'collateral_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d,
            'synthetic_decimals': 10,
            'collateral_decimals': 6
        },
        'LTC-USD': {
            'synthetic_id': 0x4c54432d55534400000000000000000,
            'collateral_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d,
            'synthetic_decimals': 10,
            'collateral_decimals': 6
        }
    }
    
    def __init__(self, private_key_hex: str, vault_id: str):
        """Initialize with private key and vault ID"""
        if not STARKWARE_CRYPTO_AVAILABLE:
            raise ImportError("StarkWare crypto library required for proper public key derivation. Install cairo-lang.")
        
        self.private_key = int(private_key_hex, 16)
        self.vault_id = int(vault_id)
        
        # Calculate public key using proper StarkEx elliptic curve operations
        try:
            public_key_int = private_to_stark_key(self.private_key)
            self.public_key = f"0x{public_key_int:064x}"
        except Exception as e:
            raise ValueError(f"Failed to derive StarkEx public key: {e}")
    
    def _scale_amount(self, amount: str, decimals: int) -> int:
        """Scale amount to StarkEx format"""
        amount_decimal = Decimal(amount)
        scaled = amount_decimal * (10 ** decimals)
        return int(scaled)
    
    def _calculate_fee(self, collateral_amount: int, fee_rate: float = 0.00025) -> int:
        """Calculate trading fee"""
        return int(collateral_amount * fee_rate)
    
    def _get_limit_order_msg_hash(self, 
                                  synthetic_asset_id: int,
                                  collateral_asset_id: int,
                                  is_buying_synthetic: int,
                                  fee_asset_id: int,
                                  amount_synthetic: int,
                                  amount_collateral: int,
                                  max_fee: int,
                                  nonce: int,
                                  vault_id: int,
                                  expiration_hours: int) -> int:
        """
        Calculate limit order message hash for StarkEx
        This implements the Extended Exchange order hash calculation
        """
        # Implement the exact hash calculation used by Extended Exchange
        # This is based on StarkEx's getLimitOrderMsgHashWithFee
        
        # Instruction type for limit order
        instruction_type = 0  # LIMIT_ORDER_TYPE
        
        # Build message components
        vault_sell = vault_id
        vault_buy = vault_id
        amount_sell = amount_collateral if is_buying_synthetic else amount_synthetic
        amount_buy = amount_synthetic if is_buying_synthetic else amount_collateral
        token_sell = collateral_asset_id if is_buying_synthetic else synthetic_asset_id
        token_buy = synthetic_asset_id if is_buying_synthetic else collateral_asset_id
        
        # Create packed message for hashing
        # This follows StarkEx's specific packing format
        
        # Part 1: instruction type + vault info
        part1 = pedersen_hash_func(instruction_type, vault_sell)
        part1 = pedersen_hash_func(part1, vault_buy)
        
        # Part 2: amounts
        part1 = pedersen_hash_func(part1, amount_sell)
        part1 = pedersen_hash_func(part1, amount_buy)
        
        # Part 3: tokens
        part1 = pedersen_hash_func(part1, token_sell)
        part1 = pedersen_hash_func(part1, token_buy)
        
        # Part 4: fee info
        part1 = pedersen_hash_func(part1, fee_asset_id)
        part1 = pedersen_hash_func(part1, max_fee)
        
        # Part 5: nonce and expiration
        part1 = pedersen_hash_func(part1, nonce)
        part1 = pedersen_hash_func(part1, expiration_hours)
        
        return part1
    
    def sign_order(self, 
                   market: str,
                   side: str,
                   quantity: str,
                   price: str,
                   nonce: int,
                   expiration_timestamp: int) -> Dict:
        """
        Sign a trading order for Extended Exchange
        Returns signature components and metadata
        """
        
        if market not in self.ASSET_CONFIGS:
            raise ValueError(f"Unsupported market: {market}")
        
        config = self.ASSET_CONFIGS[market]
        
        # Scale amounts to StarkEx format
        amount_synthetic = self._scale_amount(quantity, config['synthetic_decimals'])
        amount_collateral = self._scale_amount(
            str(Decimal(quantity) * Decimal(price)), 
            config['collateral_decimals']
        )
        
        # Calculate fee
        max_fee = self._calculate_fee(amount_collateral)
        
        # Determine buy/sell direction
        is_buying_synthetic = 1 if side.upper() == 'BUY' else 0
        
        # Convert expiration to hours (StarkEx format)
        expiration_hours = expiration_timestamp // (1000 * 3600)
        
        # Calculate message hash
        msg_hash = self._get_limit_order_msg_hash(
            synthetic_asset_id=config['synthetic_id'],
            collateral_asset_id=config['collateral_id'],
            is_buying_synthetic=is_buying_synthetic,
            fee_asset_id=config['collateral_id'],  # Fee always in collateral
            amount_synthetic=amount_synthetic,
            amount_collateral=amount_collateral,
            max_fee=max_fee,
            nonce=nonce,
            vault_id=self.vault_id,
            expiration_hours=expiration_hours
        )
        
        # Sign the message hash
        r, s = sign_func(self.private_key, msg_hash)
        
        # Return signature in Extended Exchange format
        return {
            'signature': {
                'r': f"0x{r:064x}",
                's': f"0x{s:064x}"
            },
            'starkKey': self.public_key,
            'collateralPosition': str(self.vault_id),
            'msgHash': f"0x{msg_hash:064x}",
            'orderDetails': {
                'market': market,
                'side': side,
                'amountSynthetic': amount_synthetic,
                'amountCollateral': amount_collateral,
                'maxFee': max_fee,
                'nonce': nonce,
                'expirationHours': expiration_hours
            }
        }

def create_order_signer(private_key_hex: str, vault_id: str) -> StarkExOrderSigner:
    """Create a StarkEx order signer instance"""
    return StarkExOrderSigner(private_key_hex, vault_id)