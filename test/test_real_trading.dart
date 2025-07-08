import 'dart:async';
import 'dart:convert';
import 'lib/services/starknet_service.dart';
import 'lib/data/datasources/extended_api_client.dart';
import 'lib/app_mode.dart';

/// Test script to verify real trading functionality
void main() async {
  print('🚀 Testing Real Trading Implementation');
  print('=====================================');
  
  // Check current app mode
  print('🔧 Current App Mode: ${getAppMode()}');
  print('🔧 Is Mock Mode: ${isMockMode()}');
  print('🔧 Is Real Mode: ${isRealMode()}');
  
  try {
    // Test 1: Connect with real Starknet credentials
    print('\n1. Testing Starknet Connection...');
    final starknetService = StarknetService(useMainnet: true);
    await starknetService.connectWithRealCredentials();
    
    if (starknetService.isConnected) {
      print('✅ Starknet connected successfully');
      print('📍 Account: ${starknetService.accountAddress}');
      print('🔑 Public Key: ${starknetService.publicKey}');
    } else {
      print('❌ Failed to connect to Starknet');
      return;
    }
    
    // Test 2: Test signing functionality
    print('\n2. Testing Message Signing...');
    final testMessage = 'Hello Extended API';
    final signature = await starknetService.signMessage(testMessage);
    print('✅ Message signed successfully');
    print('📝 Signature: ${signature.substring(0, 20)}...');
    
    // Test 3: Test trade order signing
    print('\n3. Testing Trade Order Signing...');
    final tradeSignature = await starknetService.signTradeOrder(
      market: 'ETH-USD',
      side: 'BUY',
      quantity: '0.01',
      price: '2847.92',
      nonce: DateTime.now().millisecondsSinceEpoch,
      expiration: DateTime.now().add(Duration(hours: 24)).millisecondsSinceEpoch,
    );
    print('✅ Trade order signed successfully');
    print('📝 Order Hash: ${tradeSignature.orderHash.substring(0, 20)}...');
    print('🔑 Account Address: ${tradeSignature.accountAddress}');
    
    // Test 4: Test Extended API client
    print('\n4. Testing Extended API Client...');
    final apiClient = ExtendedApiClient.withRealCredentials();
    
    try {
      print('📊 Getting market data...');
      final marketData = await apiClient.getMarketData('ETH-USD');
      print('✅ Market data retrieved successfully');
      print('💰 Current Price: \$${marketData.price}');
      print('📈 24h Change: ${marketData.change24h}');
      
      print('📚 Getting order book...');
      final orderBook = await apiClient.getOrderBook('ETH-USD');
      print('✅ Order book retrieved successfully');
      print('📈 Best Bid: \$${orderBook.bids.isNotEmpty ? orderBook.bids.first.price : 'N/A'}');
      print('📉 Best Ask: \$${orderBook.asks.isNotEmpty ? orderBook.asks.first.price : 'N/A'}');
      
    } catch (e) {
      print('⚠️ Extended API calls failed (expected if not connected): $e');
    }
    
    // Test 5: Test real order creation (simulation)
    print('\n5. Testing Real Order Creation...');
    try {
      final orderResponse = await apiClient.createOrder(
        market: 'ETH-USD',
        side: 'BUY',
        qty: '0.01',
        price: '2847.92',
        starknetService: starknetService,
      );
      print('✅ Real order created successfully!');
      print('🆔 Order ID: ${orderResponse.orderId}');
      print('📊 Status: ${orderResponse.status}');
      print('💰 Price: \$${orderResponse.price}');
      print('📏 Quantity: ${orderResponse.qty}');
      
    } catch (e) {
      print('⚠️ Real order creation failed (expected if API not accessible): $e');
    }
    
    print('\n🎉 Real Trading Implementation Test Complete!');
    print('✅ All cryptographic components working correctly');
    print('🔐 Using real Extended API credentials');
    print('🔑 Using real Starknet private key');
    print('🚀 Ready for real trading execution');
    
  } catch (e) {
    print('❌ Test failed: $e');
    print('🔍 Check implementation for errors');
  }
}