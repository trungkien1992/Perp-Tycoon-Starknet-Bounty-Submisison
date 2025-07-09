"""
Shared Module - Python Package
Consolidated utilities for cross-service functionality
"""

from .types.trading_types import (
    OrderSide,
    OrderType, 
    OrderStatus,
    TradingPair,
    OrderRequest,
    OrderResponse,
    MarketData,
    Balance,
    StarknetSignature,
)

from .api.base_api_client import (
    BaseApiClient,
    ExtendedApiClient,
)

from .auth.starknet_auth import (
    StarknetAuth,
    StarkExOrderSigner,
    create_order_signer,
)

from .errors.app_error import (
    AppError,
    ErrorCodes,
    TradingError,
    AuthError,
    BlockchainError,
    RagError,
)

from .logging.logger_service import (
    LoggerService,
    LogLevel,
    logger,
)

from .services.trading_service import (
    TradingService,
    TradingServiceConfig,
)

__version__ = "1.0.0"
__author__ = "StreetCred Team"
__description__ = "Shared utilities for StreetCred application"

__all__ = [
    # Types
    "OrderSide",
    "OrderType",
    "OrderStatus", 
    "TradingPair",
    "OrderRequest",
    "OrderResponse",
    "MarketData",
    "Balance",
    "StarknetSignature",
    
    # API Clients
    "BaseApiClient",
    "ExtendedApiClient",
    
    # Authentication
    "StarknetAuth",
    "StarkExOrderSigner",
    "create_order_signer",
    
    # Error Handling
    "AppError",
    "ErrorCodes",
    "TradingError",
    "AuthError",
    "BlockchainError",
    "RagError",
    
    # Logging
    "LoggerService",
    "LogLevel",
    "logger",
    
    # Services
    "TradingService",
    "TradingServiceConfig",
]