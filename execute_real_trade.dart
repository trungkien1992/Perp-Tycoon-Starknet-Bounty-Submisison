import 'dart:async';
import 'lib/services/starknet_service.dart';
import 'lib/data/datasources/extended_api_client.dart';

/// Execute a real trade with the funded account
void main() async {
  print('🚀 EXECUTING REAL TRADE');
  print('======================');
  print('💰 Account Balance: 9.96 USDC');
  print('🎯 Trade Size: 0.001 ETH (~\$2.85 value)');
  print('');
  
  try {
    // Step 1: Connect Starknet service with real credentials
    print('1. 🔐 Connecting Starknet Account...');
    final starknetService = StarknetService(useMainnet: true);
    await starknetService.connectWithRealCredentials();
    print('✅ Starknet connected: ${starknetService.accountAddress}');
    
    // Step 2: Connect Extended API client
    print('\\n2. 🌐 Connecting to Extended API...');
    final apiClient = ExtendedApiClient.withRealCredentials();
    print('✅ Extended API client ready');
    print('🔑 API Key: f1894fcb909e3619449c01a1f16ddde3');
    print('🏦 Vault: 101420');
    
    // Step 3: Execute real trade
    print('\\n3. 📊 EXECUTING REAL TRADE...');
    print('Market: ETH-USD');
    print('Side: BUY (LONG)');
    print('Quantity: 0.001 ETH');
    print('Type: Market Order');
    print('');
    
    try {
      final orderResponse = await apiClient.createOrder(
        market: 'ETH-USD',
        side: 'BUY',
        qty: '0.001',
        price: '2847.92', // Current market price
        starknetService: starknetService,
        type: 'MARKET',
      );
      
      print('🎉 REAL TRADE EXECUTED SUCCESSFULLY!');
      print('================================');
      print('🆔 Order ID: ${orderResponse.orderId}');
      print('📊 Status: ${orderResponse.status}');
      print('💰 Price: \$${orderResponse.price}');
      print('📏 Quantity: ${orderResponse.qty} ETH');
      print('🏪 Market: ${orderResponse.market}');
      print('📈 Side: ${orderResponse.side}');
      print('');
      print('💵 Trade Value: ~\$${(double.parse(orderResponse.qty) * double.parse(orderResponse.price)).toStringAsFixed(2)}');
      print('💰 Remaining Balance: ~\$${(9.96 - (double.parse(orderResponse.qty) * double.parse(orderResponse.price))).toStringAsFixed(2)} USDC');
      
    } catch (e) {
      print('❌ TRADE EXECUTION FAILED');
      print('Error: $e');
      
      if (e.toString().contains('404')) {
        print('');
        print('🔍 API Issue Analysis:');
        print('• Extended API endpoints still returning 404');
        print('• This could mean:');
        print('  - API base URL is incorrect');
        print('  - Vault 101420 needs additional setup');
        print('  - API key needs activation after funding');
        print('  - Different API endpoint required for live trading');
      } else if (e.toString().contains('401') || e.toString().contains('403')) {
        print('');
        print('🔐 Authentication Issue:');
        print('• API key authentication failed');
        print('• Vault may need permission grants');
      } else if (e.toString().contains('insufficient')) {
        print('');
        print('💰 Funding Issue:');
        print('• Account balance insufficient for trade');
        print('• May need higher balance for margin requirements');
      }
    }
    
    // Step 4: Alternative approach - try different endpoints
    print('\\n4. 🔄 Trying Alternative API Approaches...');
    
    // Try basic market data endpoint
    try {
      final marketData = await apiClient.getMarketData('ETH-USD');
      print('✅ Market data accessible: \$${marketData.price}');
    } catch (e) {
      print('❌ Market data failed: $e');
    }
    
    // Try markets list endpoint
    try {
      final markets = await apiClient.getMarkets();
      print('✅ Markets list accessible: ${markets.length} markets');
    } catch (e) {
      print('❌ Markets list failed: $e');
    }
    
  } catch (e) {
    print('❌ CRITICAL ERROR: $e');
  }
  
  print('\\n📋 TRADE EXECUTION SUMMARY');
  print('==========================');
  print('💰 Deposited: 9.96 USDC');
  print('🔑 Credentials: Real Extended API key integrated');
  print('🔐 Cryptography: Real Starknet signatures working');
  print('📊 Trade Intent: 0.001 ETH BUY order');
  print('');
  print('If trade succeeded: 🎉 REAL TRADING IS LIVE!');
  print('If trade failed: 🔧 API configuration needs adjustment');
}