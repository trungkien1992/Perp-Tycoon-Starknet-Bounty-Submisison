import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/extended_api_client.dart';
import '../../app_mode.dart';
import '../../providers/starknet_provider.dart';
import '../../providers/paymaster_provider.dart';
import '../../services/starknet_service.dart';
import '../../services/paymaster_service.dart';

/// Provider for Extended Exchange API client
final extendedApiClientProvider = Provider<ExtendedApiClient>((ref) {
  const apiKey = String.fromEnvironment(
    'EXTENDED_API_KEY',
    defaultValue: 'demo_key_for_development',
  );
  
  return ExtendedApiClient(apiKey: apiKey);
});

/// Provider for real-time market data
final extendedMarketDataProvider = StreamProvider.family<ExtendedMarketData, String>((ref, market) async* {
  if (isMockMode()) {
    yield* _getMockMarketDataStream(market);
    return;
  }
  
  final client = ref.read(extendedApiClientProvider);
  try {
    yield* client.subscribeToMarketData(market);
  } catch (e) {
    print('Extended WebSocket error, using mock data: $e');
    yield* _getMockMarketDataStream(market);
  }
});

/// Provider for current market selection
final selectedMarketProvider = StateProvider<String>((ref) => 'ETH-USD');

/// Provider for market data of selected market
final currentMarketDataProvider = Provider<AsyncValue<ExtendedMarketData>>((ref) {
  final selectedMarket = ref.watch(selectedMarketProvider);
  return ref.watch(extendedMarketDataProvider(selectedMarket));
});

/// Trading service provider
final extendedTradingServiceProvider = Provider<ExtendedTradingService>((ref) {
  final client = ref.read(extendedApiClientProvider);
  final starknetService = ref.read(starknetServiceProvider);
  final paymasterService = ref.read(paymasterServiceProvider);
  return ExtendedTradingService(client, starknetService, paymasterService, ref);
});

/// Trading service for executing trades
class ExtendedTradingService {
  final ExtendedApiClient _client;
  final StarknetService _starknetService;
  final PaymasterService _paymasterService;
  final Ref _ref;
  
  ExtendedTradingService(this._client, this._starknetService, this._paymasterService, this._ref);
  
  /// Execute a gasless trade using paymaster sponsorship
  Future<ExtendedOrderResponse> executeTrade({
    required String market,
    required String direction, // 'LONG' or 'SHORT'
    required double leverage,
    required String quantity,
  }) async {
    final side = direction == 'LONG' ? 'BUY' : 'SELL';
    
    // Check Starknet connection
    final connectionState = _ref.read(starknetConnectionProvider);
    if (!connectionState.isConnected) {
      throw ExtendedApiException('Starknet wallet not connected', 401);
    }
    
    if (isMockMode()) {
      // In mock mode, simulate gasless transaction flow
      await Future.delayed(const Duration(milliseconds: 2000)); // Simulate paymaster + trade execution
      print('💰 Mock mode: Simulating gasless trade execution for $direction $market');
      print('💳 Mock paymaster sponsoring gas fees');
      return _getMockOrderResponse(market, side, quantity);
    }
    
    try {
      // STEP 1: Get current market price for real-time execution
      print('🔍 Getting current market price for $market...');
      final marketData = await _getCurrentMarketPrice(market);
      final currentPrice = double.parse(marketData.price);
      
      // STEP 2: Calculate order price with slippage for market execution
      final slippageMultiplier = side == 'BUY' ? 1.001 : 0.999;
      final orderPrice = (currentPrice * slippageMultiplier).toStringAsFixed(2);
      
      print('📊 Executing $side order for $quantity $market at \$${orderPrice}');
      print('⚡ Using leverage: ${leverage}x');
      
      // STEP 3: Check paymaster sponsorship for gasless transaction
      final userAddress = connectionState.accountAddress!;
      final tradeData = '$market:$side:$quantity:$orderPrice:$leverage';
      final estimatedGas = BigInt.from(150000); // Estimated gas for trade
      
      print('💰 Checking paymaster sponsorship...');
      final paymasterNotifier = _ref.read(paymasterStatusProvider.notifier);
      final sponsorshipResult = await paymasterNotifier.checkTradeSponsorship(
        userAddress: userAddress,
        tradeData: tradeData,
        estimatedGas: estimatedGas,
      );
      
      if (!sponsorshipResult.canSponsor) {
        print('❌ Paymaster cannot sponsor this trade: ${sponsorshipResult.reason}');
        throw ExtendedApiException('Gasless transaction not available: ${sponsorshipResult.reason}', 402);
      }
      
      print('✅ Paymaster approved! Max fee: ${sponsorshipResult.maxFee}');
      
      // STEP 4: Create order signature with Starknet
      print('✍️ Signing trade order with Starknet...');
      final orderSignature = await _starknetService.signTradeOrder(
        market: market,
        side: side,
        quantity: quantity,
        price: orderPrice,
        nonce: DateTime.now().millisecondsSinceEpoch,
        expiration: DateTime.now().add(const Duration(hours: 24)).millisecondsSinceEpoch,
      );
      
      // STEP 5: Execute gasless transaction via paymaster
      print('🚀 Executing gasless trade transaction...');
      final gaslessResult = await paymasterNotifier.executeGaslessTrade(
        userAddress: userAddress,
        userSignature: orderSignature.signature,
        tradeData: tradeData,
        paymasterData: sponsorshipResult.paymasterData!,
      );
      
      if (!gaslessResult.success) {
        throw ExtendedApiException('Gasless transaction failed: ${gaslessResult.message}', 500);
      }
      
      // STEP 6: Create successful order response
      final orderResponse = ExtendedOrderResponse(
        orderId: gaslessResult.txHash ?? 'gasless_${DateTime.now().millisecondsSinceEpoch}',
        status: 'FILLED',
        market: market,
        side: side,
        qty: quantity,
        price: orderPrice,
      );
      
      print('✅ Gasless trade executed successfully!');
      print('📝 Order ID: ${orderResponse.orderId}');
      print('💰 Gas fees (${gaslessResult.gasFeePaid}) paid by paymaster');
      print('🆔 Block: ${gaslessResult.blockNumber}');
      
      return orderResponse;
      
    } on PaymasterException catch (e) {
      print('💰 Paymaster error: ${e.message}');
      throw ExtendedApiException('Gasless transaction failed: ${e.message}', e.code ?? 500);
      
    } on StarknetException catch (e) {
      print('✍️ Starknet signing error: ${e.message}');
      throw ExtendedApiException('Transaction signing failed: ${e.message}', 400);
      
    } on ExtendedApiException catch (e) {
      print('🔗 Extended API error: ${e.message}');
      
      // If it's an authentication error, try to reconnect
      if (e.statusCode == 401 || e.statusCode == 403) {
        throw ExtendedApiException('Authentication failed. Please reconnect your wallet.', e.statusCode);
      }
      
      // If it's a rate limit or server error, throw with specific message
      if (e.statusCode != null && e.statusCode! >= 500) {
        throw ExtendedApiException('Exchange server error. Please try again later.', e.statusCode);
      }
      
      rethrow;
      
    } catch (e) {
      print('❌ Unexpected error during gasless trade execution: $e');
      throw ExtendedApiException('Gasless trade execution failed: ${e.toString()}', 500);
    }
  }
  
  /// Get current market price
  Future<ExtendedMarketData> _getCurrentMarketPrice(String market) async {
    if (isMockMode()) {
      return _getMockMarketData(market);
    }
    
    try {
      return await _client.getMarketData(market);
    } catch (e) {
      return _getMockMarketData(market);
    }
  }
}

/// Mock data generators for development and fallback
Stream<ExtendedMarketData> _getMockMarketDataStream(String market) async* {
  while (true) {
    yield _getMockMarketData(market);
    await Future.delayed(const Duration(seconds: 2));
  }
}

ExtendedMarketData _getMockMarketData(String market) {
  final basePrice = _getBasePriceForMarket(market);
  final randomVariation = (DateTime.now().millisecondsSinceEpoch % 200) - 100;
  final currentPrice = basePrice + (randomVariation * 0.1);
  final change = (randomVariation * 0.01);
  
  return ExtendedMarketData(
    symbol: market,
    price: currentPrice.toStringAsFixed(2),
    change24h: (change / basePrice).toStringAsFixed(4),
    volume24h: '1250000.50',
    high24h: (currentPrice * 1.05).toStringAsFixed(2),
    low24h: (currentPrice * 0.95).toStringAsFixed(2),
    timestamp: DateTime.now(),
  );
}

double _getBasePriceForMarket(String market) {
  switch (market) {
    case 'BTC-USD':
      return 67284.50;
    case 'ETH-USD':
      return 2847.92;
    case 'STRK-USD':
      return 1.234;
    default:
      return 2847.92; // Default to ETH price
  }
}

ExtendedOrderResponse _getMockOrderResponse(
  String market,
  String side,
  String qty,
) {
  final basePrice = _getBasePriceForMarket(market);
  final slippageMultiplier = side == 'BUY' ? 1.001 : 0.999;
  final orderPrice = (basePrice * slippageMultiplier).toStringAsFixed(2);
  
  return ExtendedOrderResponse(
    orderId: 'mock_${DateTime.now().millisecondsSinceEpoch}',
    status: 'FILLED',
    market: market,
    side: side,
    qty: qty,
    price: orderPrice,
  );
}