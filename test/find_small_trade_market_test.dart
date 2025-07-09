import 'package:flutter_test/flutter_test.dart';
import '../lib/data/datasources/extended_api_client.dart';
import '../lib/services/secure_config_service.dart';

void main() {
  test('Find suitable market for small trade', () async {
    await SecureConfigService.initialize();
    final apiClient = ExtendedApiClient.withRealCredentials();
    
    try {
      print('🔍 FINDING SUITABLE MARKETS FOR SMALL TRADES');
      print('===========================================');
      
      final balance = await apiClient.getAccountBalance();
      print('💰 Available Balance: ${balance.availableBalance} USD');
      
      final maxTradeValue = balance.availableBalance * 0.2; // 20% of balance for safety
      print('💰 Max Trade Value: \$${maxTradeValue.toStringAsFixed(2)}');
      
      final markets = await apiClient.getMarkets();
      print('📊 Total Markets: ${markets.length}');
      
      print('\n🔍 Analyzing markets for small trades...');
      
      for (final market in markets) {
        if (market.status != 'ACTIVE') continue;
        if (!market.symbol.contains('USD')) continue;
        
        final minQty = double.tryParse(market.minQty) ?? 0;
        final tickSize = double.tryParse(market.tickSize) ?? 0;
        
        if (minQty == 0 || tickSize == 0) continue;
        
        // Estimate minimum trade value (assuming price around $0.1 to $100)
        // Use a conservative estimate
        final estimatedMinValue = minQty * 0.1; // Assume minimum price ~$0.10
        final estimatedMaxValue = minQty * 100;  // Assume maximum price ~$100
        
        if (estimatedMinValue <= maxTradeValue) {
          print('✅ ${market.symbol}:');
          print('   Min Qty: ${market.minQty}');
          print('   Tick Size: ${market.tickSize}');
          print('   Est Min Value: \$${estimatedMinValue.toStringAsFixed(2)}');
          print('   Est Max Value: \$${estimatedMaxValue.toStringAsFixed(2)}');
          print('   Status: ${market.status}');
          print('');
        }
      }
      
      // Find the best market
      final suitableMarkets = markets.where((market) {
        if (market.status != 'ACTIVE') return false;
        if (!market.symbol.contains('USD')) return false;
        
        final minQty = double.tryParse(market.minQty) ?? double.infinity;
        final estimatedMinValue = minQty * 0.1;
        
        return estimatedMinValue <= maxTradeValue && minQty > 0;
      }).toList();
      
      suitableMarkets.sort((a, b) {
        final aMinQty = double.parse(a.minQty);
        final bMinQty = double.parse(b.minQty);
        return aMinQty.compareTo(bMinQty);
      });
      
      print('🎯 RECOMMENDED MARKETS FOR TRADING:');
      print('===================================');
      
      for (int i = 0; i < suitableMarkets.length && i < 5; i++) {
        final market = suitableMarkets[i];
        final minQty = double.parse(market.minQty);
        final estimatedValue = minQty * 1.0; // Assume $1 average price
        
        print('${i + 1}. ${market.symbol}');
        print('   Min Order: ${market.minQty} units');
        print('   Est Value: ~\$${estimatedValue.toStringAsFixed(2)}');
        print('   Tick Size: ${market.tickSize}');
        print('');
      }
      
      if (suitableMarkets.isNotEmpty) {
        final bestMarket = suitableMarkets.first;
        final minQty = double.parse(bestMarket.minQty);
        final estimatedValue = minQty * 1.0;
        
        print('🏆 BEST MARKET: ${bestMarket.symbol}');
        print('   Reason: Smallest minimum order size');
        print('   Min Order: ${bestMarket.minQty} units');
        print('   Est Value: ~\$${estimatedValue.toStringAsFixed(2)}');
        print('   Safe for ${balance.availableBalance.toStringAsFixed(2)} USD balance');
      } else {
        print('❌ No suitable markets found for current balance');
      }
      
    } finally {
      apiClient.dispose();
    }
  });
}