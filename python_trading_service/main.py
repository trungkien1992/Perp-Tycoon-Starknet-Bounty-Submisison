"""
StreetCred Python Trading Service
Native Extended Exchange integration with proper StarkEx signatures
"""
import os
import asyncio
import time
from datetime import datetime, timedelta
from typing import Dict, List, Optional
import json
import logging
from decimal import Decimal

from fastapi import FastAPI, HTTPException, BackgroundTasks
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import httpx
from dotenv import load_dotenv

# Import our StarkEx crypto module
from starkex_crypto import create_order_signer

# Load environment variables
load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="StreetCred Trading Service",
    description="Native Python trading service for Extended Exchange",
    version="1.0.0"
)

# CORS middleware for Flutter frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure appropriately for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Configuration
class Config:
    EXTENDED_API_KEY = os.getenv("EXTENDED_API_KEY", "f1894fcb909e3619449c01a1f16ddde3")
    EXTENDED_BASE_URL = os.getenv("EXTENDED_BASE_URL", "https://api.extended.exchange/api/v1")
    EXTENDED_WS_URL = os.getenv("EXTENDED_WS_URL", "wss://api.extended.exchange/stream.extended.exchange/v1")
    EXTENDED_VAULT_ID = os.getenv("EXTENDED_VAULT_ID", "101420")
    STARK_PRIVATE_KEY = os.getenv("STARK_PRIVATE_KEY", "0x040662bc94150487d65b99006436a6587717f564705b3f011f673efaf9b7814d")
    
config = Config()

# Extended Exchange Asset IDs
ASSET_IDS = {
    'BTC-USD': {
        'synthetic': '0x4254432d38000000000000000000000',
        'collateral': '0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d'
    },
    'ETH-USD': {
        'synthetic': '0x4554482d38000000000000000000000',
        'collateral': '0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d'
    },
    'EUR-USD': {
        'synthetic': '0x4555522d5553442d38000000000000',
        'collateral': '0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d'
    }
}

# Request/Response Models
class Market(BaseModel):
    symbol: str
    base_asset: str
    quote_asset: str
    status: str
    min_qty: str
    max_qty: str
    tick_size: str

class MarketData(BaseModel):
    symbol: str
    price: str
    change_24h: str
    volume_24h: str
    high_24h: str
    low_24h: str
    timestamp: datetime

class OrderRequest(BaseModel):
    market: str
    side: str  # 'BUY' or 'SELL'
    qty: str
    price: str
    order_type: str = 'LIMIT'
    time_in_force: str = 'GTC'
    reduce_only: bool = False

class OrderResponse(BaseModel):
    order_id: str
    status: str
    market: str
    side: str
    qty: str
    price: str
    message: Optional[str] = None

class AccountBalance(BaseModel):
    total_balance: float
    available_balance: float
    margin_used: float
    unrealized_pnl: float
    currency: str
    is_eligible_for_trading: bool

# Extended Exchange Client
class ExtendedExchangeClient:
    def __init__(self):
        self.base_url = config.EXTENDED_BASE_URL
        self.api_key = config.EXTENDED_API_KEY
        self.vault_id = config.EXTENDED_VAULT_ID
        self.stark_private_key = config.STARK_PRIVATE_KEY
        
        # Initialize StarkEx signer
        self.signer = create_order_signer(self.stark_private_key, self.vault_id)
        
        self.headers = {
            'Content-Type': 'application/json',
            'X-Api-Key': self.api_key,
            'User-Agent': 'StreetCredPythonTrading/1.0.0'
        }

    async def _request(self, method: str, endpoint: str, **kwargs) -> httpx.Response:
        """Make HTTP request with proper error handling"""
        url = f"{self.base_url}{endpoint}"
        
        async with httpx.AsyncClient(timeout=30.0) as client:
            try:
                response = await client.request(
                    method=method,
                    url=url,
                    headers=self.headers,
                    **kwargs
                )
                
                logger.info(f"{method} {endpoint} -> {response.status_code}")
                
                return response
                
            except httpx.RequestError as e:
                logger.error(f"Request failed for {endpoint}: {e}")
                raise HTTPException(status_code=503, detail=f"Service unavailable: {e}")

    async def get_markets(self) -> List[Market]:
        """Get all available markets"""
        response = await self._request("GET", "/info/markets")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('status') == 'OK' and 'data' in data:
                markets = []
                for item in data['data']:
                    market = Market(
                        symbol=item.get('name', ''),
                        base_asset=item.get('assetName', ''),
                        quote_asset=item.get('collateralAssetName', ''),
                        status=item.get('status', ''),
                        min_qty=str(item.get('tradingConfig', {}).get('minOrderSize', '0')),
                        max_qty=str(item.get('tradingConfig', {}).get('maxPositionValue', '0')),
                        tick_size=str(item.get('tradingConfig', {}).get('minPriceChange', '0'))
                    )
                    markets.append(market)
                return markets
        
        raise HTTPException(status_code=response.status_code, detail="Failed to fetch markets")

    async def get_market_data(self, market: str) -> MarketData:
        """Get market data for specific market"""
        response = await self._request("GET", f"/info/markets/{market}/stats")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('status') == 'OK' and 'data' in data:
                market_info = data['data']
                stats = market_info.get('marketStats', {})
                
                return MarketData(
                    symbol=market_info.get('name', market),
                    price=str(stats.get('lastPrice', '0')),
                    change_24h=str(stats.get('dailyPriceChangePercentage', '0')),
                    volume_24h=str(stats.get('dailyVolume', '0')),
                    high_24h=str(stats.get('dailyHigh', '0')),
                    low_24h=str(stats.get('dailyLow', '0')),
                    timestamp=datetime.now()
                )
        
        raise HTTPException(status_code=response.status_code, detail=f"Failed to fetch market data for {market}")

    async def get_account_balance(self) -> AccountBalance:
        """Get account balance information"""
        response = await self._request("GET", "/user/balance")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('status') == 'OK' and 'data' in data:
                balance_data = data['data']
                
                return AccountBalance(
                    total_balance=float(balance_data.get('balance', '0')),
                    available_balance=float(balance_data.get('availableForTrade', '0')),
                    margin_used=float(balance_data.get('initialMargin', '0')),
                    unrealized_pnl=float(balance_data.get('unrealisedPnl', '0')),
                    currency=balance_data.get('collateralName', 'USD'),
                    is_eligible_for_trading=balance_data.get('status') == 'ACTIVE'
                )
        
        raise HTTPException(status_code=response.status_code, detail="Failed to fetch account balance")

    def _generate_stark_signature(self, market: str, side: str, qty: str, price: str, nonce: int, expiration: int) -> Dict:
        """
        Generate StarkEx signature for order using native Python implementation
        """
        try:
            # Use our StarkEx signer to generate proper signatures
            signature_result = self.signer.sign_order(
                market=market,
                side=side,
                quantity=qty,
                price=price,
                nonce=nonce,
                expiration_timestamp=expiration
            )
            
            logger.info(f"✅ Generated StarkEx signature for {market} {side} order")
            logger.info(f"📝 Message hash: {signature_result.get('msgHash')}")
            logger.info(f"🔐 Signature R: {signature_result['signature']['r']}")
            logger.info(f"🔐 Signature S: {signature_result['signature']['s']}")
            
            return {
                'signature': signature_result['signature'],
                'starkKey': signature_result['starkKey'],
                'collateralPosition': signature_result['collateralPosition']
            }
            
        except Exception as e:
            logger.error(f"❌ StarkEx signature generation failed: {e}")
            import traceback
            traceback.print_exc()
            
            # Re-raise the error since signatures are critical for trading
            raise HTTPException(
                status_code=500,
                detail=f"Failed to generate StarkEx signature: {str(e)}"
            )

    async def create_order(self, order_request: OrderRequest) -> OrderResponse:
        """Create a new trading order with proper StarkEx signature"""
        
        # Generate order parameters
        now = int(time.time() * 1000)
        expiration = int((datetime.now() + timedelta(hours=24)).timestamp() * 1000)
        nonce = now
        
        # Generate StarkEx signature
        settlement = self._generate_stark_signature(
            order_request.market,
            order_request.side,
            order_request.qty,
            order_request.price,
            nonce,
            expiration
        )
        
        # Create order payload
        order_data = {
            'id': f'streetcred_python_{now}',
            'market': order_request.market,
            'type': order_request.order_type.upper(),
            'side': order_request.side.upper(),
            'qty': order_request.qty,
            'price': order_request.price,
            'timeInForce': 'GTT',  # Good Till Time
            'expiryEpochMillis': expiration,
            'fee': '0.00025',  # Correct taker fee
            'nonce': str(nonce),
            'settlement': settlement,
            'reduceOnly': order_request.reduce_only,
            'postOnly': False,
            'selfTradeProtectionLevel': 'ACCOUNT'
        }
        
        logger.info(f"Creating order: {order_data}")
        
        response = await self._request("POST", "/user/order", json=order_data)
        
        if response.status_code in [200, 201]:
            data = response.json()
            return OrderResponse(
                order_id=data.get('data', {}).get('id', 'unknown'),
                status='CREATED',
                market=order_request.market,
                side=order_request.side,
                qty=order_request.qty,
                price=order_request.price,
                message="Order created successfully"
            )
        else:
            error_data = response.json()
            error_message = error_data.get('error', {}).get('message', 'Unknown error')
            
            return OrderResponse(
                order_id='',
                status='FAILED',
                market=order_request.market,
                side=order_request.side,
                qty=order_request.qty,
                price=order_request.price,
                message=f"Order failed: {error_message}"
            )

# Initialize client
client = ExtendedExchangeClient()

# API Endpoints
@app.get("/")
async def root():
    return {
        "service": "StreetCred Python Trading Service",
        "status": "running",
        "version": "1.0.0",
        "extended_api": "connected"
    }

@app.get("/health")
async def health_check():
    """Health check endpoint"""
    try:
        # Test connection to Extended Exchange
        response = await client._request("GET", "/info/markets")
        api_healthy = response.status_code == 200
        
        return {
            "status": "healthy" if api_healthy else "degraded",
            "extended_api": "connected" if api_healthy else "disconnected",
            "timestamp": datetime.now().isoformat()
        }
    except Exception as e:
        return {
            "status": "unhealthy",
            "extended_api": "disconnected",
            "error": str(e),
            "timestamp": datetime.now().isoformat()
        }

@app.get("/markets", response_model=List[Market])
async def get_markets():
    """Get all available markets"""
    return await client.get_markets()

@app.get("/markets/{market}/data", response_model=MarketData)
async def get_market_data(market: str):
    """Get market data for specific market"""
    return await client.get_market_data(market)

@app.get("/account/balance", response_model=AccountBalance)
async def get_account_balance():
    """Get account balance information"""
    return await client.get_account_balance()

@app.post("/orders", response_model=OrderResponse)
async def create_order(order_request: OrderRequest):
    """Create a new trading order"""
    return await client.create_order(order_request)

@app.get("/test/connection")
async def test_connection():
    """Test Extended Exchange API connection"""
    try:
        balance = await client.get_account_balance()
        markets = await client.get_markets()
        
        return {
            "status": "success",
            "connection": "working",
            "balance": f"${balance.available_balance:.2f} USD",
            "markets_count": len(markets),
            "message": "Extended Exchange API connection successful"
        }
    except Exception as e:
        return {
            "status": "error",
            "connection": "failed",
            "error": str(e),
            "message": "Extended Exchange API connection failed"
        }

if __name__ == "__main__":
    import uvicorn
    
    logger.info("🚀 Starting StreetCred Python Trading Service")
    logger.info("=" * 50)
    logger.info(f"🌐 Extended API: {config.EXTENDED_BASE_URL}")
    logger.info(f"🔑 API Key: {config.EXTENDED_API_KEY[:20]}...")
    logger.info(f"🏦 Vault ID: {config.EXTENDED_VAULT_ID}")
    logger.info("✅ Ready for native Extended Exchange trading")
    
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
        log_level="info"
    )