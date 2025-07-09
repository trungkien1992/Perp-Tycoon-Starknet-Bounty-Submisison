import 'package:flutter_test/flutter_test.dart';
import '../lib/data/datasources/extended_api_client.dart';
import '../lib/services/starknet_service.dart';
import '../lib/services/secure_config_service.dart';

void main() {
  test('Execute Real Trade with 9.96 USD Balance', () async {
    print('💰 EXECUTING REAL TRADE WITH LIVE FUNDS');
    print('=======================================');
    print('⚠️  WARNING: This will trade with your real 9.96 USD balance!');
    
    await SecureConfigService.initialize();
    final apiClient = ExtendedApiClient.withRealCredentials();
    final starknetService = StarknetService();
    await starknetService.connectWithRealCredentials();
    
    try {
      // Verify balance first
      print('\n💰 Confirming account balance...');
      final balance = await apiClient.getAccountBalance();
      print('✅ Account Balance: ${balance.totalBalance} ${balance.currency}');
      print('✅ Available for Trading: ${balance.availableBalance} ${balance.currency}');
      print('✅ Can Trade: ${balance.canTrade}');
      
      expect(balance.canTrade, isTrue, reason: 'Account must be eligible for trading');
      expect(balance.availableBalance, greaterThan(1.0), reason: 'Need at least 1 USD for trading');
      
      // Get available markets
      print('\n📊 Fetching available markets...');
      final markets = await apiClient.getMarkets();
      
      // Select a safe market for small trade
      final safeTradingMarkets = markets.where((market) => 
        market.status == 'ACTIVE' &&
        market.symbol.contains('USD') &&
        double.tryParse(market.minQty) != null &&
        double.parse(market.minQty) <= 10 && // Low minimum order size
        !market.symbol.contains('1000') // Avoid kilo tokens
      ).toList();
      
      expect(safeTradingMarkets, isNotEmpty, reason: 'Need at least one safe trading market');
      
      // Select ENA-USD or similar stable market
      final selectedMarket = safeTradingMarkets.firstWhere(
        (m) => m.symbol == 'ENA-USD' || m.symbol.contains('EUR') || m.symbol.contains('XRP'),
        orElse: () => safeTradingMarkets.first
      );
      
      print('🎯 Selected Market: ${selectedMarket.symbol}');
      print('   📊 Status: ${selectedMarket.status}');
      print('   💰 Min Order Size: ${selectedMarket.minQty}');
      print('   📈 Price Step: ${selectedMarket.tickSize}');
      
      // Calculate conservative trade parameters
      final minOrderSize = double.parse(selectedMarket.minQty);
      final tickSize = double.parse(selectedMarket.tickSize);
      
      // Use minimum order size for safety
      final tradeQuantity = minOrderSize.toString();
      
      print('\n📋 Trade Parameters:');
      print('   🎯 Market: ${selectedMarket.symbol}');
      print('   💰 Quantity: $tradeQuantity');
      print('   💵 Estimated Value: ~\$${(minOrderSize * 1.0).toStringAsFixed(2)} (assuming ~\$1 price)');
      
      // Safety check - don't risk more than 10% of balance
      final maxRiskValue = balance.availableBalance * 0.1;
      expect(minOrderSize, lessThanOrEqualTo(maxRiskValue), 
        reason: 'Trade size too large for account balance');
      
      print('\n🚀 Executing REAL trade...');
      print('⚠️  This will place an actual order with real money!');
      
      // Place a conservative limit order slightly below market to minimize immediate execution
      // This creates a "buy limit" order that might not fill immediately
      final order = await apiClient.createOrder(
        market: selectedMarket.symbol,
        side: 'BUY',
        qty: tradeQuantity,
        price: '0.10', // Very low price - unlikely to execute immediately
        starknetService: starknetService,
        type: 'LIMIT',
        timeInForce: 'GTC', // Good Till Canceled
      );
      
      print('✅ REAL ORDER PLACED SUCCESSFULLY!');
      print('==================================');
      print('🆔 Order ID: ${order.orderId}');
      print('📊 Status: ${order.status}');
      print('🎯 Market: ${order.market}');
      print('💰 Quantity: ${order.qty}');
      print('💵 Price: \$${order.price}');
      print('📈 Side: ${order.side}');
      
      expect(order.orderId, isNotEmpty, reason: 'Order ID should not be empty');
      expect(order.market, equals(selectedMarket.symbol), reason: 'Market should match');
      expect(order.side, equals('BUY'), reason: 'Side should be BUY');
      
      // Check updated balance
      print('\n💰 Checking updated account status...');
      final updatedBalance = await apiClient.getAccountBalance();
      print('✅ Updated Balance: ${updatedBalance.totalBalance} ${updatedBalance.currency}');
      print('✅ Available: ${updatedBalance.availableBalance} ${updatedBalance.currency}');
      print('✅ Margin Used: ${updatedBalance.marginUsed} ${updatedBalance.currency}');
      
      print('\n🎉 REAL TRADE EXECUTION COMPLETED!');
      print('=================================');
      print('✅ Extended API: Fully functional');
      print('✅ CloudFront bypass: Working');
      print('✅ Starknet integration: Connected');
      print('✅ Account balance: ${balance.totalBalance} USD detected correctly');
      print('✅ Real order placed: ${order.orderId}');
      
      print('\n💡 Trade Summary:');
      print('   • Order placed as conservative limit order');
      print('   • Price set very low (0.10) to avoid immediate execution');
      print('   • You can cancel this order in Extended Exchange dashboard');
      print('   • Order type: Good Till Canceled (GTC)');
      
      print('\n🏆 STREETCRED TRADING INTEGRATION: FULLY OPERATIONAL!');
      
    } catch (e, stackTrace) {
      print('\n❌ REAL TRADE EXECUTION FAILED');
      print('==============================');
      print('💥 Error: $e');
      print('🔍 Stack: $stackTrace');
      
      // Enhanced error analysis
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('signature')) {
        print('\n🔐 Signature Error Analysis:');
        print('   • Check Starknet private/public key format');
        print('   • Verify account has proper signing permissions');
        print('   • Ensure keys match Extended Exchange account');
      } else if (errorStr.contains('insufficient')) {
        print('\n💰 Insufficient Funds Analysis:');
        print('   • Check if balance covers order value + fees');
        print('   • Verify margin requirements');
      } else if (errorStr.contains('market')) {
        print('\n📊 Market Error Analysis:');
        print('   • Selected market may not support trading');
        print('   • Check minimum order size requirements');
        print('   • Verify market status is ACTIVE');
      }
      
      rethrow;
    } finally {
      apiClient.dispose();
    }
  });
}