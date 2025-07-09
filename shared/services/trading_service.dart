/// Trading Service
/// Connects to Python trading service for Extended Exchange integration
library;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../api/base_api_client.dart';
import '../types/trading_types.dart';
import '../errors/app_error.dart';
import '../logging/logger_service.dart';

/// Python Trading Service Client
class TradingService extends BaseApiClient {
  static const String _baseUrl = 'http://localhost:8000';
  
  TradingService() : super(_baseUrl);
  
  /// Get available markets
  Future<List<TradingPair>> getMarkets() async {
    try {
      final response = await get('/markets');
      
      if (response.statusCode == 200) {
        final List<dynamic> marketsJson = json.decode(response.body);
        return marketsJson.map((json) => TradingPair.fromJson(json)).toList();
      }
      
      throw TradingError.apiError('Failed to fetch markets: ${response.statusCode}');
    } catch (e) {
      LoggerService().error('Failed to get markets', metadata: {'error': e.toString()});
      throw TradingError.apiError('Failed to get markets: $e');
    }
  }
  
  /// Get market data for specific symbol
  Future<MarketData> getMarketData(String symbol) async {
    try {
      final response = await get('/markets/$symbol/data');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> dataJson = json.decode(response.body);
        return MarketData.fromJson(dataJson);
      }
      
      throw TradingError.apiError('Failed to fetch market data: ${response.statusCode}');
    } catch (e) {
      LoggerService().error('Failed to get market data', metadata: {'symbol': symbol, 'error': e.toString()});
      throw TradingError.apiError('Failed to get market data: $e');
    }
  }
  
  /// Get account balance
  Future<Balance> getAccountBalance() async {
    try {
      final response = await get('/account/balance');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> balanceJson = json.decode(response.body);
        return Balance.fromJson(balanceJson);
      }
      
      throw TradingError.apiError('Failed to fetch balance: ${response.statusCode}');
    } catch (e) {
      LoggerService().error('Failed to get account balance', metadata: {'error': e.toString()});
      throw TradingError.apiError('Failed to get account balance: $e');
    }
  }
  
  /// Create trading order
  Future<OrderResponse> createOrder(OrderRequest orderRequest) async {
    try {
      final orderJson = {
        'market': orderRequest.symbol,
        'side': orderRequest.side.name.toUpperCase(),
        'qty': orderRequest.quantity.toString(),
        'price': orderRequest.price.toString(),
        'order_type': orderRequest.type.name.toUpperCase(),
        'time_in_force': 'GTC',
        'reduce_only': false,
      };
      
      final response = await post('/orders', body: json.encode(orderJson));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = json.decode(response.body);
        return OrderResponse.fromJson(responseJson);
      }
      
      // Handle error response
      if (response.statusCode == 400) {
        final Map<String, dynamic> errorJson = json.decode(response.body);
        final errorMessage = errorJson['detail'] ?? 'Order creation failed';
        throw TradingError.invalidOrder(errorMessage);
      }
      
      throw TradingError.apiError('Failed to create order: ${response.statusCode}');
    } catch (e) {
      LoggerService().error(
        'Failed to create order',
        metadata: {
          'symbol': orderRequest.symbol,
          'side': orderRequest.side.name,
          'quantity': orderRequest.quantity.toString(),
          'price': orderRequest.price.toString(),
          'error': e.toString(),
        },
      );
      
      if (e is TradingError) {
        rethrow;
      }
      
      throw TradingError.apiError('Failed to create order: $e');
    }
  }
  
  /// Test connection to trading service
  Future<bool> testConnection() async {
    try {
      final response = await get('/test/connection');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> connectionJson = json.decode(response.body);
        return connectionJson['status'] == 'success';
      }
      
      return false;
    } catch (e) {
      LoggerService().error('Trading service connection test failed', metadata: {'error': e.toString()});
      return false;
    }
  }
  
  /// Get service health status
  Future<Map<String, dynamic>> getHealthStatus() async {
    try {
      final response = await get('/health');
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      
      return {'status': 'unhealthy', 'error': 'HTTP ${response.statusCode}'};
    } catch (e) {
      return {'status': 'unhealthy', 'error': e.toString()};
    }
  }
}

/// Trading Service Provider Extensions
extension TradingServiceExtensions on TradingService {
  /// Execute a trade with automatic signature generation
  Future<OrderResponse> executeTrade({
    required String symbol,
    required OrderSide side,
    required double quantity,
    required double price,
    OrderType type = OrderType.limit,
  }) async {
    LoggerService().info(
      'Executing trade via Python service',
      metadata: {
        'symbol': symbol,
        'side': side.name,
        'quantity': quantity.toString(),
        'price': price.toString(),
        'type': type.name,
      },
    );
    
    final orderRequest = OrderRequest(
      symbol: symbol,
      side: side,
      quantity: quantity,
      price: price,
      type: type,
    );
    
    return await createOrder(orderRequest);
  }
  
  /// Get real-time market data with caching
  Future<MarketData> getCachedMarketData(String symbol) async {
    // This could be enhanced with caching logic
    return await getMarketData(symbol);
  }
}

/// Trading Service Configuration
class TradingServiceConfig {
  static const String defaultBaseUrl = 'http://localhost:8000';
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  
  /// Check if trading service is available
  static Future<bool> isServiceAvailable() async {
    try {
      final client = http.Client();
      final response = await client.get(
        Uri.parse('$defaultBaseUrl/health'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));
      
      client.close();
      
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}