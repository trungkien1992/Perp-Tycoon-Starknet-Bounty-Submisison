"""
Application Error Classes - Python implementation
Standardized error handling across Python services
"""

import uuid
from datetime import datetime
from typing import Dict, Any, Optional


def generate_trace_id() -> str:
    """Generate a random trace ID for error tracking"""
    return str(uuid.uuid4()).replace('-', '')[:16]


class AppError(Exception):
    """Application error class with standardized structure"""
    
    def __init__(
        self,
        code: str,
        message: str,
        details: Optional[Dict[str, Any]] = None,
        trace_id: Optional[str] = None
    ):
        self.code = code
        self.message = message
        self.details = details or {}
        self.trace_id = trace_id or generate_trace_id()
        self.timestamp = datetime.now()
        super().__init__(self.message)

    def to_dict(self) -> Dict[str, Any]:
        """Convert error to dictionary format"""
        return {
            'error': {
                'code': self.code,
                'message': self.message,
                'details': self.details,
                'timestamp': self.timestamp.isoformat(),
                'trace_id': self.trace_id,
            }
        }

    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'AppError':
        """Create AppError from dictionary"""
        error_data = data['error']
        
        return cls(
            code=error_data['code'],
            message=error_data['message'],
            details=error_data.get('details'),
            trace_id=error_data.get('trace_id'),
        )

    def __str__(self) -> str:
        return f'AppError(code={self.code}, message={self.message}, trace_id={self.trace_id})'

    def __repr__(self) -> str:
        return self.__str__()


class ErrorCodes:
    """Common error codes for the application"""
    
    # Trading errors (001-099)
    TRADING_INSUFFICIENT_BALANCE = 'TRADING_001'
    TRADING_INVALID_SYMBOL = 'TRADING_002'
    TRADING_INVALID_QUANTITY = 'TRADING_003'
    TRADING_INVALID_PRICE = 'TRADING_004'
    TRADING_ORDER_NOT_FOUND = 'TRADING_005'
    TRADING_MARKET_CLOSED = 'TRADING_006'
    TRADING_POSITION_NOT_FOUND = 'TRADING_007'
    TRADING_RISK_LIMIT_EXCEEDED = 'TRADING_008'
    
    # Authentication errors (100-199)
    AUTH_INVALID_CREDENTIALS = 'AUTH_100'
    AUTH_TOKEN_EXPIRED = 'AUTH_101'
    AUTH_TOKEN_INVALID = 'AUTH_102'
    AUTH_PERMISSION_DENIED = 'AUTH_103'
    AUTH_SIGNATURE_INVALID = 'AUTH_104'
    AUTH_NONCE_INVALID = 'AUTH_105'
    
    # Blockchain errors (200-299)
    BLOCKCHAIN_CONNECTION_FAILED = 'BLOCKCHAIN_200'
    BLOCKCHAIN_TRANSACTION_FAILED = 'BLOCKCHAIN_201'
    BLOCKCHAIN_INSUFFICIENT_GAS = 'BLOCKCHAIN_202'
    BLOCKCHAIN_CONTRACT_ERROR = 'BLOCKCHAIN_203'
    BLOCKCHAIN_INVALID_ADDRESS = 'BLOCKCHAIN_204'
    BLOCKCHAIN_NETWORK_ERROR = 'BLOCKCHAIN_205'
    
    # RAG/Knowledge base errors (300-399)
    RAG_INDEX_NOT_FOUND = 'RAG_300'
    RAG_SEARCH_FAILED = 'RAG_301'
    RAG_DOCUMENT_NOT_FOUND = 'RAG_302'
    RAG_PROCESSING_FAILED = 'RAG_303'
    RAG_DATABASE_ERROR = 'RAG_304'
    
    # API/Network errors (400-499)
    API_NETWORK_ERROR = 'API_400'
    API_TIMEOUT_ERROR = 'API_401'
    API_RATE_LIMIT_EXCEEDED = 'API_402'
    API_INVALID_REQUEST = 'API_403'
    API_INVALID_RESPONSE = 'API_404'
    API_SERVICE_UNAVAILABLE = 'API_405'
    
    # System errors (500-599)
    SYSTEM_CONFIGURATION_ERROR = 'SYSTEM_500'
    SYSTEM_DATABASE_ERROR = 'SYSTEM_501'
    SYSTEM_FILE_ERROR = 'SYSTEM_502'
    SYSTEM_MEMORY_ERROR = 'SYSTEM_503'
    SYSTEM_UNKNOWN_ERROR = 'SYSTEM_504'


class TradingError(AppError):
    """Trading-specific error class"""
    
    def __init__(
        self,
        code: str,
        message: str,
        details: Optional[Dict[str, Any]] = None,
        trace_id: Optional[str] = None
    ):
        super().__init__(code, message, details, trace_id)

    @classmethod
    def insufficient_balance(cls, required: float, available: float) -> 'TradingError':
        return cls(
            code=ErrorCodes.TRADING_INSUFFICIENT_BALANCE,
            message='Insufficient balance for trade',
            details={
                'required': required,
                'available': available,
            }
        )

    @classmethod
    def invalid_symbol(cls, symbol: str) -> 'TradingError':
        return cls(
            code=ErrorCodes.TRADING_INVALID_SYMBOL,
            message='Invalid trading symbol',
            details={'symbol': symbol}
        )

    @classmethod
    def invalid_quantity(cls, quantity: float) -> 'TradingError':
        return cls(
            code=ErrorCodes.TRADING_INVALID_QUANTITY,
            message='Invalid quantity for trade',
            details={'quantity': quantity}
        )

    @classmethod
    def order_not_found(cls, order_id: str) -> 'TradingError':
        return cls(
            code=ErrorCodes.TRADING_ORDER_NOT_FOUND,
            message='Order not found',
            details={'order_id': order_id}
        )

    @classmethod
    def market_closed(cls, symbol: str) -> 'TradingError':
        return cls(
            code=ErrorCodes.TRADING_MARKET_CLOSED,
            message='Market is closed for trading',
            details={'symbol': symbol}
        )


class AuthError(AppError):
    """Authentication-specific error class"""
    
    def __init__(
        self,
        code: str,
        message: str,
        details: Optional[Dict[str, Any]] = None,
        trace_id: Optional[str] = None
    ):
        super().__init__(code, message, details, trace_id)

    @classmethod
    def invalid_credentials(cls) -> 'AuthError':
        return cls(
            code=ErrorCodes.AUTH_INVALID_CREDENTIALS,
            message='Invalid credentials provided'
        )

    @classmethod
    def token_expired(cls) -> 'AuthError':
        return cls(
            code=ErrorCodes.AUTH_TOKEN_EXPIRED,
            message='Authentication token has expired'
        )

    @classmethod
    def invalid_signature(cls) -> 'AuthError':
        return cls(
            code=ErrorCodes.AUTH_SIGNATURE_INVALID,
            message='Invalid signature provided'
        )

    @classmethod
    def permission_denied(cls, resource: str) -> 'AuthError':
        return cls(
            code=ErrorCodes.AUTH_PERMISSION_DENIED,
            message='Permission denied for resource',
            details={'resource': resource}
        )


class BlockchainError(AppError):
    """Blockchain-specific error class"""
    
    def __init__(
        self,
        code: str,
        message: str,
        details: Optional[Dict[str, Any]] = None,
        trace_id: Optional[str] = None
    ):
        super().__init__(code, message, details, trace_id)

    @classmethod
    def connection_failed(cls, network: str = 'unknown') -> 'BlockchainError':
        return cls(
            code=ErrorCodes.BLOCKCHAIN_CONNECTION_FAILED,
            message='Failed to connect to blockchain network',
            details={'network': network}
        )

    @classmethod
    def transaction_failed(cls, tx_hash: str, reason: str = 'unknown') -> 'BlockchainError':
        return cls(
            code=ErrorCodes.BLOCKCHAIN_TRANSACTION_FAILED,
            message='Blockchain transaction failed',
            details={
                'transaction_hash': tx_hash,
                'reason': reason
            }
        )

    @classmethod
    def insufficient_gas(cls, required: float, available: float) -> 'BlockchainError':
        return cls(
            code=ErrorCodes.BLOCKCHAIN_INSUFFICIENT_GAS,
            message='Insufficient gas for transaction',
            details={
                'required': required,
                'available': available
            }
        )

    @classmethod
    def contract_error(cls, contract_address: str, error_message: str) -> 'BlockchainError':
        return cls(
            code=ErrorCodes.BLOCKCHAIN_CONTRACT_ERROR,
            message='Smart contract execution failed',
            details={
                'contract_address': contract_address,
                'error_message': error_message
            }
        )


class RagError(AppError):
    """RAG/Knowledge base specific error class"""
    
    def __init__(
        self,
        code: str,
        message: str,
        details: Optional[Dict[str, Any]] = None,
        trace_id: Optional[str] = None
    ):
        super().__init__(code, message, details, trace_id)

    @classmethod
    def search_failed(cls, query: str, reason: str = 'unknown') -> 'RagError':
        return cls(
            code=ErrorCodes.RAG_SEARCH_FAILED,
            message='RAG search failed',
            details={
                'query': query,
                'reason': reason
            }
        )

    @classmethod
    def document_not_found(cls, document_id: str) -> 'RagError':
        return cls(
            code=ErrorCodes.RAG_DOCUMENT_NOT_FOUND,
            message='Document not found in knowledge base',
            details={'document_id': document_id}
        )

    @classmethod
    def processing_failed(cls, operation: str, reason: str = 'unknown') -> 'RagError':
        return cls(
            code=ErrorCodes.RAG_PROCESSING_FAILED,
            message=f'RAG processing failed for operation: {operation}',
            details={
                'operation': operation,
                'reason': reason
            }
        )

    @classmethod
    def database_error(cls, operation: str, error_message: str) -> 'RagError':
        return cls(
            code=ErrorCodes.RAG_DATABASE_ERROR,
            message='RAG database operation failed',
            details={
                'operation': operation,
                'error_message': error_message
            }
        )