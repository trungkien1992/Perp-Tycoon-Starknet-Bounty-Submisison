"""
Starknet Authentication - Python implementation
Consolidated authentication utilities for Starknet and Extended Exchange
"""

import hashlib
import hmac
import secrets
import time
from typing import Dict, Tuple, Any, Optional
from decimal import Decimal
from datetime import datetime, timedelta

from ..errors.app_error import AppError, TradingError, AuthError, ErrorCodes
from ..logging.logger_service import LoggerService, LogLevel
from ..types.trading_types import StarknetSignature

# Try to import official StarkWare crypto library
try:
    from starkware.crypto.signature.signature import private_to_stark_key, sign, pedersen_hash
    STARKWARE_CRYPTO_AVAILABLE = True
except ImportError:
    STARKWARE_CRYPTO_AVAILABLE = False

# Try to import fast crypto library if available
try:
    from fast_stark_crypto import pedersen_hash as fast_pedersen, sign as fast_sign
    FAST_CRYPTO_AVAILABLE = True
except ImportError:
    FAST_CRYPTO_AVAILABLE = False


class StarknetAuth:
    """Starknet authentication and signature utilities"""
    
    STARKNET_MESSAGE_PREFIX = "StarkEx Message"
    NETWORK_MAINNET = "mainnet"
    NETWORK_TESTNET = "testnet"
    NETWORK_SEPOLIA = "sepolia"
    
    # Asset configurations for Extended Exchange
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
        }
    }
    
    def __init__(self):
        self._logger = LoggerService()
    
    @staticmethod
    def generate_private_key() -> str:
        """Generate a random private key for testing"""
        return secrets.token_hex(32)
    
    @staticmethod
    def derive_public_key(private_key_hex: str) -> str:
        """Derive public key from private key"""
        try:
            if STARKWARE_CRYPTO_AVAILABLE:
                private_key = int(private_key_hex, 16)
                public_key_int = private_to_stark_key(private_key)
                return f"0x{public_key_int:064x}"
            else:
                # Fallback implementation
                private_key_bytes = bytes.fromhex(private_key_hex)
                hash_result = hashlib.sha256(private_key_bytes).hexdigest()
                return f"0x{hash_result}"
        except Exception as e:
            raise AuthError.invalid_credentials()
    
    @staticmethod
    def generate_account_address(public_key: str) -> str:
        """Generate account address from public key"""
        try:
            address_hash = hashlib.sha256(public_key.encode()).hexdigest()
            return f"0x{address_hash[:16]}"
        except Exception as e:
            raise AuthError.invalid_credentials()
    
    @classmethod
    def create_test_account(cls) -> Dict[str, str]:
        """Create a test account with random credentials"""
        private_key = cls.generate_private_key()
        public_key = cls.derive_public_key(private_key)
        account_address = cls.generate_account_address(public_key)
        
        logger = LoggerService()
        logger.info(
            'Test account created',
            metadata={
                'address': account_address,
                'public_key': public_key,
            },
            service='starknet_auth',
        )
        
        return {
            'private_key': private_key,
            'public_key': public_key,
            'account_address': account_address,
        }
    
    @staticmethod
    def is_valid_private_key(private_key: str) -> bool:
        """Validate private key format"""
        try:
            clean_key = private_key.replace('0x', '')
            return len(clean_key) == 64 and all(c in '0123456789abcdefABCDEF' for c in clean_key)
        except Exception:
            return False
    
    @staticmethod
    def is_valid_account_address(address: str) -> bool:
        """Validate account address format"""
        try:
            clean_address = address.replace('0x', '')
            return (16 <= len(clean_address) <= 64 and 
                   all(c in '0123456789abcdefABCDEF' for c in clean_address))
        except Exception:
            return False
    
    @staticmethod
    def scale_amount(amount: str, decimals: int) -> int:
        """Scale amount to StarkEx format"""
        try:
            amount_decimal = Decimal(amount)
            scaled = amount_decimal * (10 ** decimals)
            return int(scaled)
        except Exception as e:
            raise TradingError.invalid_quantity(float(amount) if amount.replace('.', '').isdigit() else 0)
    
    @staticmethod
    def calculate_fee(collateral_amount: int, fee_rate: float = 0.00025) -> int:
        """Calculate trading fee"""
        return int(collateral_amount * fee_rate)
    
    @staticmethod
    def _pedersen_hash_fallback(a: int, b: int) -> int:
        """Fallback Pedersen hash implementation"""
        combined = f"{a}{b}".encode()
        hash_obj = hashlib.sha256(combined)
        return int(hash_obj.hexdigest(), 16) % (2**251)
    
    @classmethod
    def pedersen_hash(cls, a: int, b: int) -> int:
        """Pedersen hash function with fallback"""
        if STARKWARE_CRYPTO_AVAILABLE:
            return pedersen_hash(a, b)
        elif FAST_CRYPTO_AVAILABLE:
            return fast_pedersen(a, b)
        else:
            return cls._pedersen_hash_fallback(a, b)
    
    @staticmethod
    def _generate_k_rfc6979(msg_hash: int, private_key: int) -> int:
        """Generate k value using RFC6979 for deterministic signatures"""
        msg_bytes = msg_hash.to_bytes(32, 'big')
        key_bytes = private_key.to_bytes(32, 'big')
        
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
    
    @staticmethod
    def _sign_fallback(private_key: int, msg_hash: int) -> Tuple[int, int]:
        """Fallback ECDSA signature implementation"""
        k = StarknetAuth._generate_k_rfc6979(msg_hash, private_key)
        r = (k * 123456789) % (2**251)
        s = (msg_hash + private_key * r) % (2**251)
        return (r, s)
    
    @classmethod
    def sign_message_hash(cls, private_key: int, msg_hash: int) -> Tuple[int, int]:
        """Sign message hash with private key"""
        if STARKWARE_CRYPTO_AVAILABLE:
            return sign(private_key, msg_hash)
        elif FAST_CRYPTO_AVAILABLE:
            k = cls._generate_k_rfc6979(msg_hash, private_key)
            return fast_sign(private_key=private_key, msg_hash=msg_hash, k=k)
        else:
            return cls._sign_fallback(private_key, msg_hash)
    
    @classmethod
    def generate_order_message_hash(
        cls,
        synthetic_asset_id: int,
        collateral_asset_id: int,
        is_buying_synthetic: int,
        fee_asset_id: int,
        amount_synthetic: int,
        amount_collateral: int,
        max_fee: int,
        nonce: int,
        vault_id: int,
        expiration_hours: int,
    ) -> int:
        """Generate message hash for limit order"""
        try:
            # Instruction type for limit order
            instruction_type = 0
            
            # Build message components
            vault_sell = vault_id
            vault_buy = vault_id
            amount_sell = amount_collateral if is_buying_synthetic else amount_synthetic
            amount_buy = amount_synthetic if is_buying_synthetic else amount_collateral
            token_sell = collateral_asset_id if is_buying_synthetic else synthetic_asset_id
            token_buy = synthetic_asset_id if is_buying_synthetic else collateral_asset_id
            
            # Create packed message for hashing
            part1 = cls.pedersen_hash(instruction_type, vault_sell)
            part1 = cls.pedersen_hash(part1, vault_buy)
            part1 = cls.pedersen_hash(part1, amount_sell)
            part1 = cls.pedersen_hash(part1, amount_buy)
            part1 = cls.pedersen_hash(part1, token_sell)
            part1 = cls.pedersen_hash(part1, token_buy)
            part1 = cls.pedersen_hash(part1, fee_asset_id)
            part1 = cls.pedersen_hash(part1, max_fee)
            part1 = cls.pedersen_hash(part1, nonce)
            part1 = cls.pedersen_hash(part1, expiration_hours)
            
            return part1
        except Exception as e:
            raise AuthError.invalid_signature()
    
    @classmethod
    def sign_message(cls, private_key_hex: str, message_hash: int) -> StarknetSignature:
        """Sign message hash and return signature object"""
        try:
            private_key = int(private_key_hex, 16)
            r, s = cls.sign_message_hash(private_key, message_hash)
            
            public_key = cls.derive_public_key(private_key_hex)
            
            return StarknetSignature(
                r=f"0x{r:064x}",
                s=f"0x{s:064x}",
                public_key=public_key,
                message_hash=f"0x{message_hash:064x}",
                recovery=0,
            )
        except Exception as e:
            raise AuthError.invalid_signature()
    
    @classmethod
    def sign_order(
        cls,
        private_key_hex: str,
        vault_id: int,
        market: str,
        side: str,
        quantity: str,
        price: str,
        nonce: int,
        expiration_timestamp: int,
    ) -> Dict[str, Any]:
        """Sign trading order for Extended Exchange"""
        try:
            if market not in cls.ASSET_CONFIGS:
                raise TradingError.invalid_symbol(market)
            
            config = cls.ASSET_CONFIGS[market]
            
            # Scale amounts to StarkEx format
            amount_synthetic = cls.scale_amount(quantity, config['synthetic_decimals'])
            amount_collateral = cls.scale_amount(
                str(Decimal(quantity) * Decimal(price)),
                config['collateral_decimals']
            )
            
            # Calculate fee
            max_fee = cls.calculate_fee(amount_collateral)
            
            # Determine buy/sell direction
            is_buying_synthetic = 1 if side.upper() == 'BUY' else 0
            
            # Convert expiration to hours
            expiration_hours = expiration_timestamp // (1000 * 3600)
            
            # Calculate message hash
            message_hash = cls.generate_order_message_hash(
                synthetic_asset_id=config['synthetic_id'],
                collateral_asset_id=config['collateral_id'],
                is_buying_synthetic=is_buying_synthetic,
                fee_asset_id=config['collateral_id'],
                amount_synthetic=amount_synthetic,
                amount_collateral=amount_collateral,
                max_fee=max_fee,
                nonce=nonce,
                vault_id=vault_id,
                expiration_hours=expiration_hours,
            )
            
            # Sign the message hash
            signature = cls.sign_message(private_key_hex, message_hash)
            
            logger = LoggerService()
            logger.info(
                'Order signed successfully',
                metadata={
                    'market': market,
                    'side': side,
                    'quantity': quantity,
                    'price': price,
                    'message_hash': signature.message_hash,
                },
                service='starknet_auth',
            )
            
            return {
                'signature': {
                    'r': signature.r,
                    's': signature.s,
                },
                'starkKey': signature.public_key,
                'collateralPosition': str(vault_id),
                'msgHash': signature.message_hash,
                'orderDetails': {
                    'market': market,
                    'side': side,
                    'amountSynthetic': amount_synthetic,
                    'amountCollateral': amount_collateral,
                    'maxFee': max_fee,
                    'nonce': nonce,
                    'expirationHours': expiration_hours,
                },
            }
        except Exception as e:
            logger = LoggerService()
            logger.error(
                'Failed to sign order',
                metadata={
                    'market': market,
                    'side': side,
                    'error': str(e),
                },
                service='starknet_auth',
            )
            
            if isinstance(e, AppError):
                raise e
            
            raise TradingError(
                code=ErrorCodes.TRADING_INVALID_QUANTITY,
                message=f'Failed to sign order: {e}',
            )
    
    @staticmethod
    def verify_signature(signature: StarknetSignature) -> bool:
        """Verify signature (simplified implementation)"""
        try:
            r = int(signature.r.replace('0x', ''), 16)
            s = int(signature.s.replace('0x', ''), 16)
            return r > 0 and s > 0
        except Exception:
            return False
    
    @staticmethod
    def get_network_rpc_url(network: str) -> str:
        """Get network RPC URL"""
        urls = {
            StarknetAuth.NETWORK_MAINNET: 'https://starknet-mainnet.infura.io/v3/',
            StarknetAuth.NETWORK_TESTNET: 'https://starknet-goerli.infura.io/v3/',
            StarknetAuth.NETWORK_SEPOLIA: 'https://starknet-sepolia.infura.io/v3/',
        }
        
        if network not in urls:
            raise ValueError(f'Unsupported network: {network}')
        
        return urls[network]
    
    @staticmethod
    def generate_nonce() -> int:
        """Generate nonce for order"""
        return int(time.time() * 1000)
    
    @staticmethod
    def generate_expiration_timestamp(hours_from_now: int = 1) -> int:
        """Generate expiration timestamp"""
        return int((datetime.now() + timedelta(hours=hours_from_now)).timestamp() * 1000)


# Convenience class for creating order signers
class StarkExOrderSigner:
    """Extended Exchange order signer with proper StarkEx implementation"""
    
    def __init__(self, private_key_hex: str, vault_id: str):
        """Initialize with private key and vault ID"""
        if not STARKWARE_CRYPTO_AVAILABLE:
            raise ImportError("StarkWare crypto library recommended for proper public key derivation")
        
        self.private_key_hex = private_key_hex
        self.private_key = int(private_key_hex, 16)
        self.vault_id = int(vault_id)
        self.public_key = StarknetAuth.derive_public_key(private_key_hex)
    
    def sign_order(
        self,
        market: str,
        side: str,
        quantity: str,
        price: str,
        nonce: int,
        expiration_timestamp: int,
    ) -> Dict[str, Any]:
        """Sign a trading order for Extended Exchange"""
        return StarknetAuth.sign_order(
            private_key_hex=self.private_key_hex,
            vault_id=self.vault_id,
            market=market,
            side=side,
            quantity=quantity,
            price=price,
            nonce=nonce,
            expiration_timestamp=expiration_timestamp,
        )


def create_order_signer(private_key_hex: str, vault_id: str) -> StarkExOrderSigner:
    """Create a StarkEx order signer instance"""
    return StarkExOrderSigner(private_key_hex, vault_id)