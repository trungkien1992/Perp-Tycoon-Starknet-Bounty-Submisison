"""
Trading Types - Python equivalent of Dart types
Shared between Python services and Dart frontend
"""

from enum import Enum
from typing import Optional, Dict, Any
from datetime import datetime
from dataclasses import dataclass
from pydantic import BaseModel


class OrderSide(Enum):
    BUY = "buy"
    SELL = "sell"


class OrderType(Enum):
    MARKET = "market"
    LIMIT = "limit"
    STOP = "stop"
    STOP_LIMIT = "stopLimit"


class OrderStatus(Enum):
    PENDING = "pending"
    PARTIALLY_FILLED = "partiallyFilled"
    FILLED = "filled"
    CANCELLED = "cancelled"
    REJECTED = "rejected"


@dataclass
class TradingPair:
    symbol: str
    base_asset: str
    quote_asset: str
    decimals: int

    def to_dict(self) -> Dict[str, Any]:
        return {
            'symbol': self.symbol,
            'base_asset': self.base_asset,
            'quote_asset': self.quote_asset,
            'decimals': self.decimals,
        }

    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'TradingPair':
        return cls(
            symbol=data['symbol'],
            base_asset=data['base_asset'],
            quote_asset=data['quote_asset'],
            decimals=data['decimals'],
        )


class OrderRequest(BaseModel):
    symbol: str
    side: OrderSide
    type: OrderType
    quantity: float
    price: Optional[float] = None
    stop_price: Optional[float] = None
    client_order_id: Optional[str] = None
    time_in_force: Optional[int] = None

    def to_dict(self) -> Dict[str, Any]:
        return {
            'symbol': self.symbol,
            'side': self.side.value,
            'type': self.type.value,
            'quantity': self.quantity,
            'price': self.price,
            'stop_price': self.stop_price,
            'client_order_id': self.client_order_id,
            'time_in_force': self.time_in_force,
        }

    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'OrderRequest':
        return cls(
            symbol=data['symbol'],
            side=OrderSide(data['side']),
            type=OrderType(data['type']),
            quantity=data['quantity'],
            price=data.get('price'),
            stop_price=data.get('stop_price'),
            client_order_id=data.get('client_order_id'),
            time_in_force=data.get('time_in_force'),
        )


class OrderResponse(BaseModel):
    order_id: str
    symbol: str
    side: OrderSide
    type: OrderType
    quantity: float
    filled_quantity: float
    price: Optional[float] = None
    average_price: Optional[float] = None
    status: OrderStatus
    created_at: datetime
    updated_at: Optional[datetime] = None
    client_order_id: Optional[str] = None
    message: Optional[str] = None

    def to_dict(self) -> Dict[str, Any]:
        return {
            'order_id': self.order_id,
            'symbol': self.symbol,
            'side': self.side.value,
            'type': self.type.value,
            'quantity': self.quantity,
            'filled_quantity': self.filled_quantity,
            'price': self.price,
            'average_price': self.average_price,
            'status': self.status.value,
            'created_at': self.created_at.isoformat(),
            'updated_at': self.updated_at.isoformat() if self.updated_at else None,
            'client_order_id': self.client_order_id,
            'message': self.message,
        }

    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'OrderResponse':
        return cls(
            order_id=data['order_id'],
            symbol=data['symbol'],
            side=OrderSide(data['side']),
            type=OrderType(data['type']),
            quantity=data['quantity'],
            filled_quantity=data['filled_quantity'],
            price=data.get('price'),
            average_price=data.get('average_price'),
            status=OrderStatus(data['status']),
            created_at=datetime.fromisoformat(data['created_at']),
            updated_at=datetime.fromisoformat(data['updated_at']) if data.get('updated_at') else None,
            client_order_id=data.get('client_order_id'),
            message=data.get('message'),
        )


class MarketData(BaseModel):
    symbol: str
    price: float
    high_24h: float
    low_24h: float
    volume_24h: float
    change_24h: float
    change_percent_24h: float
    timestamp: datetime

    def to_dict(self) -> Dict[str, Any]:
        return {
            'symbol': self.symbol,
            'price': self.price,
            'high_24h': self.high_24h,
            'low_24h': self.low_24h,
            'volume_24h': self.volume_24h,
            'change_24h': self.change_24h,
            'change_percent_24h': self.change_percent_24h,
            'timestamp': self.timestamp.isoformat(),
        }

    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'MarketData':
        return cls(
            symbol=data['symbol'],
            price=data['price'],
            high_24h=data['high_24h'],
            low_24h=data['low_24h'],
            volume_24h=data['volume_24h'],
            change_24h=data['change_24h'],
            change_percent_24h=data['change_percent_24h'],
            timestamp=datetime.fromisoformat(data['timestamp']),
        )


class Balance(BaseModel):
    asset: str
    available: float
    locked: float
    total: float

    def to_dict(self) -> Dict[str, Any]:
        return {
            'asset': self.asset,
            'available': self.available,
            'locked': self.locked,
            'total': self.total,
        }

    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'Balance':
        return cls(
            asset=data['asset'],
            available=data['available'],
            locked=data['locked'],
            total=data['total'],
        )


class StarknetSignature(BaseModel):
    r: str
    s: str
    public_key: str
    message_hash: str
    recovery: int

    def to_dict(self) -> Dict[str, Any]:
        return {
            'r': self.r,
            's': self.s,
            'public_key': self.public_key,
            'message_hash': self.message_hash,
            'recovery': self.recovery,
        }

    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'StarknetSignature':
        return cls(
            r=data['r'],
            s=data['s'],
            public_key=data['public_key'],
            message_hash=data['message_hash'],
            recovery=data['recovery'],
        )