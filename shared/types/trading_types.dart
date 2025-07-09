// Trading Types - Shared between Dart and Python services
// This file contains all trading-related type definitions

class TradingPair {
  final String symbol;
  final String baseAsset;
  final String quoteAsset;
  final int decimals;
  
  const TradingPair({
    required this.symbol,
    required this.baseAsset,
    required this.quoteAsset,
    required this.decimals,
  });
  
  factory TradingPair.fromJson(Map<String, dynamic> json) {
    return TradingPair(
      symbol: json['symbol'] as String,
      baseAsset: json['base_asset'] as String,
      quoteAsset: json['quote_asset'] as String,
      decimals: json['decimals'] as int,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'base_asset': baseAsset,
      'quote_asset': quoteAsset,
      'decimals': decimals,
    };
  }
}

enum OrderSide { buy, sell }

enum OrderType { market, limit, stop, stopLimit }

enum OrderStatus { 
  pending, 
  partiallyFilled, 
  filled, 
  cancelled, 
  rejected 
}

class OrderRequest {
  final String symbol;
  final OrderSide side;
  final OrderType type;
  final double quantity;
  final double? price;
  final double? stopPrice;
  final String? clientOrderId;
  final int? timeInForce;
  
  const OrderRequest({
    required this.symbol,
    required this.side,
    required this.type,
    required this.quantity,
    this.price,
    this.stopPrice,
    this.clientOrderId,
    this.timeInForce,
  });
  
  factory OrderRequest.fromJson(Map<String, dynamic> json) {
    return OrderRequest(
      symbol: json['symbol'] as String,
      side: OrderSide.values.firstWhere(
        (e) => e.name == json['side'],
      ),
      type: OrderType.values.firstWhere(
        (e) => e.name == json['type'],
      ),
      quantity: (json['quantity'] as num).toDouble(),
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      stopPrice: json['stop_price'] != null ? (json['stop_price'] as num).toDouble() : null,
      clientOrderId: json['client_order_id'] as String?,
      timeInForce: json['time_in_force'] as int?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'side': side.name,
      'type': type.name,
      'quantity': quantity,
      'price': price,
      'stop_price': stopPrice,
      'client_order_id': clientOrderId,
      'time_in_force': timeInForce,
    };
  }
}

class OrderResponse {
  final String orderId;
  final String symbol;
  final OrderSide side;
  final OrderType type;
  final double quantity;
  final double filledQuantity;
  final double? price;
  final double? averagePrice;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? clientOrderId;
  final String? message;
  
  const OrderResponse({
    required this.orderId,
    required this.symbol,
    required this.side,
    required this.type,
    required this.quantity,
    required this.filledQuantity,
    this.price,
    this.averagePrice,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.clientOrderId,
    this.message,
  });
  
  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      orderId: json['order_id'] as String,
      symbol: json['symbol'] as String,
      side: OrderSide.values.firstWhere(
        (e) => e.name == json['side'],
      ),
      type: OrderType.values.firstWhere(
        (e) => e.name == json['type'],
      ),
      quantity: (json['quantity'] as num).toDouble(),
      filledQuantity: (json['filled_quantity'] as num).toDouble(),
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      averagePrice: json['average_price'] != null ? (json['average_price'] as num).toDouble() : null,
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
      clientOrderId: json['client_order_id'] as String?,
      message: json['message'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'symbol': symbol,
      'side': side.name,
      'type': type.name,
      'quantity': quantity,
      'filled_quantity': filledQuantity,
      'price': price,
      'average_price': averagePrice,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'client_order_id': clientOrderId,
      'message': message,
    };
  }
}

class MarketData {
  final String symbol;
  final double price;
  final double high24h;
  final double low24h;
  final double volume24h;
  final double change24h;
  final double changePercent24h;
  final DateTime timestamp;
  
  const MarketData({
    required this.symbol,
    required this.price,
    required this.high24h,
    required this.low24h,
    required this.volume24h,
    required this.change24h,
    required this.changePercent24h,
    required this.timestamp,
  });
  
  factory MarketData.fromJson(Map<String, dynamic> json) {
    return MarketData(
      symbol: json['symbol'] as String,
      price: (json['price'] as num).toDouble(),
      high24h: (json['high_24h'] as num).toDouble(),
      low24h: (json['low_24h'] as num).toDouble(),
      volume24h: (json['volume_24h'] as num).toDouble(),
      change24h: (json['change_24h'] as num).toDouble(),
      changePercent24h: (json['change_percent_24h'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'price': price,
      'high_24h': high24h,
      'low_24h': low24h,
      'volume_24h': volume24h,
      'change_24h': change24h,
      'change_percent_24h': changePercent24h,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class Balance {
  final String asset;
  final double available;
  final double locked;
  final double total;
  
  const Balance({
    required this.asset,
    required this.available,
    required this.locked,
    required this.total,
  });
  
  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      asset: json['asset'] as String,
      available: (json['available'] as num).toDouble(),
      locked: (json['locked'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'asset': asset,
      'available': available,
      'locked': locked,
      'total': total,
    };
  }
}

class StarknetSignature {
  final String r;
  final String s;
  final String publicKey;
  final String messageHash;
  final int recovery;
  
  const StarknetSignature({
    required this.r,
    required this.s,
    required this.publicKey,
    required this.messageHash,
    required this.recovery,
  });
  
  factory StarknetSignature.fromJson(Map<String, dynamic> json) {
    return StarknetSignature(
      r: json['r'] as String,
      s: json['s'] as String,
      publicKey: json['public_key'] as String,
      messageHash: json['message_hash'] as String,
      recovery: json['recovery'] as int,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'r': r,
      's': s,
      'public_key': publicKey,
      'message_hash': messageHash,
      'recovery': recovery,
    };
  }
}