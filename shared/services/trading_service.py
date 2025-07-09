"""
Trading Service - Python implementation
Client for Python trading service integration
"""

import asyncio
import aiohttp
import json
from typing import List, Dict, Optional, Any
from datetime import datetime

from ..api.base_api_client import ExtendedApiClient
from ..types.trading_types import (
    OrderSide, OrderType, OrderStatus, TradingPair, 
    OrderRequest, OrderResponse, MarketData, Balance
)
from ..errors.app_error import TradingError, ErrorCodes
from ..logging.logger_service import LoggerService


class TradingService(ExtendedApiClient):
    """Python Trading Service Client"""
    
    def __init__(self, base_url: str = "http://localhost:8000"):
        super().__init__(base_url)
        self.logger = LoggerService()
    
    async def get_markets(self) -> List[TradingPair]:
        """Get available markets"""
        try:
            response = await self.get("/markets")
            
            if response.status == 200:
                markets_data = await response.json()
                markets = []
                
                for market_json in markets_data:
                    market = TradingPair(
                        base_asset=market_json.get('base_asset', ''),
                        quote_asset=market_json.get('quote_asset', ''),
                        symbol=market_json.get('symbol', ''),
                        min_quantity=float(market_json.get('min_qty', '0')),
                        max_quantity=float(market_json.get('max_qty', '0')),
                        price_precision=8,
                        quantity_precision=8,
                        is_active=market_json.get('status') == 'ACTIVE'
                    )
                    markets.append(market)
                
                return markets
            
            raise TradingError(
                code=ErrorCodes.TRADING_API_ERROR,
                message=f"Failed to fetch markets: {response.status}"
            )
            
        except Exception as e:
            self.logger.error(
                "Failed to get markets",
                metadata={"error": str(e)},
                service="trading_service"
            )
            
            if isinstance(e, TradingError):
                raise e
            
            raise TradingError(
                code=ErrorCodes.TRADING_API_ERROR,
                message=f"Failed to get markets: {e}"
            )
    
    async def get_market_data(self, symbol: str) -> MarketData:
        """Get market data for specific symbol"""
        try:
            response = await self.get(f"/markets/{symbol}/data")
            
            if response.status == 200:
                data_json = await response.json()
                
                return MarketData(
                    symbol=data_json.get('symbol', symbol),
                    price=float(data_json.get('price', '0')),
                    change_24h=float(data_json.get('change_24h', '0')),
                    volume_24h=float(data_json.get('volume_24h', '0')),
                    high_24h=float(data_json.get('high_24h', '0')),
                    low_24h=float(data_json.get('low_24h', '0')),
                    timestamp=datetime.now()
                )
            
            raise TradingError(
                code=ErrorCodes.TRADING_API_ERROR,
                message=f"Failed to fetch market data: {response.status}"
            )
            
        except Exception as e:
            self.logger.error(
                "Failed to get market data",
                metadata={"symbol": symbol, "error": str(e)},
                service="trading_service"
            )
            
            if isinstance(e, TradingError):
                raise e
            
            raise TradingError(
                code=ErrorCodes.TRADING_API_ERROR,
                message=f"Failed to get market data: {e}"
            )
    
    async def get_account_balance(self) -> Balance:
        """Get account balance"""
        try:
            response = await self.get("/account/balance")
            
            if response.status == 200:
                balance_json = await response.json()
                
                return Balance(
                    total_balance=float(balance_json.get('total_balance', '0')),
                    available_balance=float(balance_json.get('available_balance', '0')),
                    reserved_balance=float(balance_json.get('margin_used', '0')),
                    currency=balance_json.get('currency', 'USD')
                )
            
            raise TradingError(
                code=ErrorCodes.TRADING_API_ERROR,
                message=f"Failed to fetch balance: {response.status}"
            )
            
        except Exception as e:
            self.logger.error(
                "Failed to get account balance",
                metadata={"error": str(e)},
                service="trading_service"
            )
            
            if isinstance(e, TradingError):
                raise e
            
            raise TradingError(
                code=ErrorCodes.TRADING_API_ERROR,
                message=f"Failed to get account balance: {e}"
            )
    
    async def create_order(self, order_request: OrderRequest) -> OrderResponse:
        """Create trading order"""
        try:
            order_json = {
                'market': order_request.symbol,
                'side': order_request.side.value.upper(),
                'qty': str(order_request.quantity),
                'price': str(order_request.price),
                'order_type': order_request.type.value.upper(),
                'time_in_force': 'GTC',
                'reduce_only': False,
            }
            
            response = await self.post("/orders", json=order_json)
            
            if response.status == 200:
                response_json = await response.json()
                
                return OrderResponse(
                    order_id=response_json.get('order_id', ''),
                    symbol=order_request.symbol,
                    side=order_request.side,
                    quantity=order_request.quantity,
                    price=order_request.price,
                    status=OrderStatus.CREATED if response_json.get('status') == 'CREATED' else OrderStatus.FAILED,
                    message=response_json.get('message', ''),
                    timestamp=datetime.now()
                )
            
            # Handle error response
            if response.status == 400:
                error_json = await response.json()
                error_message = error_json.get('detail', 'Order creation failed')
                raise TradingError(
                    code=ErrorCodes.TRADING_INVALID_ORDER,
                    message=error_message
                )
            
            raise TradingError(
                code=ErrorCodes.TRADING_API_ERROR,
                message=f"Failed to create order: {response.status}"
            )
            
        except Exception as e:
            self.logger.error(
                "Failed to create order",
                metadata={
                    "symbol": order_request.symbol,
                    "side": order_request.side.value,
                    "quantity": str(order_request.quantity),
                    "price": str(order_request.price),
                    "error": str(e),
                },
                service="trading_service"
            )
            
            if isinstance(e, TradingError):
                raise e
            
            raise TradingError(
                code=ErrorCodes.TRADING_API_ERROR,
                message=f"Failed to create order: {e}"
            )
    
    async def test_connection(self) -> bool:
        """Test connection to trading service"""
        try:
            response = await self.get("/test/connection")
            
            if response.status == 200:
                connection_json = await response.json()
                return connection_json.get('status') == 'success'
            
            return False
            
        except Exception as e:
            self.logger.error(
                "Trading service connection test failed",
                metadata={"error": str(e)},
                service="trading_service"
            )
            return False
    
    async def get_health_status(self) -> Dict[str, Any]:
        """Get service health status"""
        try:
            response = await self.get("/health")
            
            if response.status == 200:
                return await response.json()
            
            return {'status': 'unhealthy', 'error': f'HTTP {response.status}'}
            
        except Exception as e:
            return {'status': 'unhealthy', 'error': str(e)}
    
    async def execute_trade(
        self,
        symbol: str,
        side: OrderSide,
        quantity: float,
        price: float,
        order_type: OrderType = OrderType.LIMIT
    ) -> OrderResponse:
        """Execute a trade with automatic signature generation"""
        
        self.logger.info(
            'Executing trade via Python service',
            metadata={
                'symbol': symbol,
                'side': side.value,
                'quantity': str(quantity),
                'price': str(price),
                'type': order_type.value,
            },
            service="trading_service"
        )
        
        order_request = OrderRequest(
            symbol=symbol,
            side=side,
            quantity=quantity,
            price=price,
            type=order_type,
        )
        
        return await self.create_order(order_request)


class TradingServiceConfig:
    """Trading Service Configuration"""
    
    DEFAULT_BASE_URL = "http://localhost:8000"
    DEFAULT_TIMEOUT = 30
    MAX_RETRIES = 3
    
    @staticmethod
    async def is_service_available(base_url: str = DEFAULT_BASE_URL) -> bool:
        """Check if trading service is available"""
        try:
            async with aiohttp.ClientSession(timeout=aiohttp.ClientTimeout(total=5)) as session:
                async with session.get(f"{base_url}/health") as response:
                    return response.status == 200
        except Exception:
            return False