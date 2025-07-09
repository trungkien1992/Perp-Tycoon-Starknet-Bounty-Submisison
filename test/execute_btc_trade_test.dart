import 'package:flutter_test/flutter_test.dart';
import '../lib/data/datasources/extended_api_client.dart';
import '../lib/services/starknet_service.dart';
import '../lib/services/secure_config_service.dart';

void main() {
  test('Execute Real BTC Trade', () async {
    print('🚀 EXECUTING REAL BTC TRADE');
    print('===========================');
    print('⚠️  WARNING: Trading with real 9.96 USD balance!');
    
    await SecureConfigService.initialize();
    final apiClient = ExtendedApiClient.withRealCredentials();
    final starknetService = StarknetService();
    await starknetService.connectWithRealCredentials();
    
    try {
      // Verify balance
      final balance = await apiClient.getAccountBalance();
      print('💰 Available Balance: ${balance.availableBalance} USD');
      print('✅ Can Trade: ${balance.canTrade}');
      
      expect(balance.canTrade, isTrue);
      
      // BTC-USD market parameters
      const market = 'BTC-USD';
      const minQty = '0.0001'; // Minimum BTC order size
      const safePrice = '50000'; // Very low price - unlikely to execute
      
      print('\n📋 TRADE PARAMETERS:');
      print('🎯 Market: $market');
      print('💰 Quantity: $minQty BTC');
      print('💵 Limit Price: \$$safePrice (very low - safety order)');
      print('📊 Side: BUY');
      print('🕐 Type: LIMIT GTC (Good Till Canceled)');
      
      // Estimate trade value at safe price
      final estimatedValue = double.parse(minQty) * double.parse(safePrice);
      print('💵 Estimated Value: \$${estimatedValue.toStringAsFixed(2)}');
      
      expect(estimatedValue, lessThan(balance.availableBalance), 
        reason: 'Trade value must be less than available balance');
      
      print('\n🚨 EXECUTING REAL TRADE...');
      print('This will place an actual limit order!');
      
      // Execute the trade
      final order = await apiClient.createOrder(
        market: market,
        side: 'BUY',
        qty: minQty,
        price: safePrice,
        starknetService: starknetService,
        type: 'LIMIT',
        timeInForce: 'GTC',
      );
      
      print('\n🎉 REAL BTC ORDER PLACED SUCCESSFULLY!');
      print('====================================');
      print('🆔 Order ID: ${order.orderId}');
      print('📊 Status: ${order.status}');
      print('🎯 Market: ${order.market}');
      print('💰 Quantity: ${order.qty} BTC');
      print('💵 Price: \$${order.price}');
      print('📈 Side: ${order.side}');
      print('🕐 Type: LIMIT');
      
      expect(order.orderId, isNotEmpty);
      expect(order.market, equals(market));
      expect(order.side, equals('BUY'));
      expect(order.qty, equals(minQty));
      
      // Check updated balance
      print('\n💰 Checking updated balance...');
      final updatedBalance = await apiClient.getAccountBalance();
      print('✅ Updated Balance: ${updatedBalance.totalBalance} USD');
      print('✅ Available: ${updatedBalance.availableBalance} USD');
      print('✅ Margin Used: ${updatedBalance.marginUsed} USD');
      
      print('\n🏆 REAL TRADING EXECUTION COMPLETE!');
      print('==================================');
      print('✅ Extended API: Fully operational');
      print('✅ CloudFront bypass: Working perfectly');
      print('✅ Starknet integration: Connected and signing');
      print('✅ Account balance: Correctly parsed (${balance.totalBalance} USD)');
      print('✅ Real BTC order: ${order.orderId}');
      
      print('\n💡 ORDER DETAILS:');
      print('   • Market: Bitcoin (BTC-USD)');
      print('   • Size: 0.0001 BTC (~\$${(0.0001 * 100000).toStringAsFixed(0)} at market price)');
      print('   • Limit Price: \$50,000 (well below market)');
      print('   • Type: Buy limit order, Good Till Canceled');
      print('   • Execution: Unlikely to fill at this low price');
      print('   • Safety: Conservative order designed not to execute immediately');
      
      print('\n🎯 NEXT STEPS:');
      print('   • Order is live on Extended Exchange');
      print('   • You can view it in your Extended Exchange dashboard');
      print('   • Cancel anytime if desired');
      print('   • Order will remain open until filled or canceled');
      
      print('\n🚀 STREETCRED REAL TRADING: FULLY OPERATIONAL!');
      
    } catch (e, stackTrace) {
      print('\n❌ TRADE EXECUTION FAILED');
      print('=========================');
      print('💥 Error: $e');
      print('🔍 Stack: $stackTrace');
      
      final errorStr = e.toString();
      if (errorStr.contains('signature') || errorStr.contains('Starknet')) {
        print('\n🔐 STARKNET SIGNATURE ERROR:');
        print('   • The order signing process failed');
        print('   • This could be due to key format or network issues');
        print('   • The API integration is working, but signature failed');
      } else if (errorStr.contains('balance') || errorStr.contains('insufficient')) {
        print('\n💰 BALANCE ERROR:');
        print('   • Insufficient funds for this trade');
        print('   • Check margin requirements and fees');
      } else if (errorStr.contains('market') || errorStr.contains('404')) {
        print('\n📊 MARKET ERROR:');
        print('   • Market may not exist or be unavailable');
        print('   • Check market status and trading hours');
      } else {
        print('\n❓ UNKNOWN ERROR:');
        print('   • Unexpected error occurred during trade execution');
        print('   • API integration is working, but order placement failed');
      }
      
      rethrow;
    } finally {
      apiClient.dispose();
    }
  });
}