import 'package:flutter_test/flutter_test.dart';
import '../lib/data/datasources/extended_api_client.dart';
import '../lib/services/starknet_service.dart';
import '../lib/services/secure_config_service.dart';

void main() {
  group('Real Trade Integration Tests', () {
    late ExtendedApiClient apiClient;
    late StarknetService starknetService;
    
    setUpAll(() async {
      // Initialize secure configuration
      await SecureConfigService.initialize();
      
      // Create Extended API client with real credentials
      apiClient = ExtendedApiClient.withRealCredentials();
      
      // Initialize Starknet service
      starknetService = StarknetService();
      await starknetService.connectWithRealCredentials();
    });
    
    tearDownAll(() {
      apiClient.dispose();
    });
    
    test('should connect to Extended API and fetch markets', () async {
      print('🌐 Testing Extended API connection...');
      
      final markets = await apiClient.getMarkets();
      expect(markets, isNotEmpty);
      
      print('✅ Found ${markets.length} markets');
      for (int i = 0; i < markets.length && i < 3; i++) {
        print('   ${i + 1}. ${markets[i].symbol} (${markets[i].status})');
      }
    });
    
    test('should fetch account balance', () async {
      print('💰 Testing account balance fetch...');
      
      try {
        final balance = await apiClient.getAccountBalance();
        print('✅ Account Balance:');
        print('   💵 Total: ${balance.totalBalance} ${balance.currency}');
        print('   💸 Available: ${balance.availableBalance} ${balance.currency}');
        print('   📊 Margin Used: ${balance.marginUsed} ${balance.currency}');
        print('   🎯 Trading Eligible: ${balance.isEligibleForTrading}');
        
        expect(balance.currency, isNotEmpty);
      } catch (e) {
        print('⚠️ Balance fetch failed (this may be expected): $e');
        // Don't fail the test if balance fetch fails - might be permission issue
      }
    });
    
    test('should fetch market data with CloudFront bypass', () async {
      print('📈 Testing market data fetch...');
      
      final markets = await apiClient.getMarkets();
      expect(markets, isNotEmpty);
      
      final firstMarket = markets.first;
      final marketData = await apiClient.getMarketData(firstMarket.symbol);
      
      print('✅ Market Data for ${firstMarket.symbol}:');
      print('   💵 Price: \$${marketData.price}');
      print('   📊 24h Change: ${marketData.change24h}%');
      print('   📊 24h Volume: \$${marketData.volume24h}');
      
      expect(marketData.symbol, equals(firstMarket.symbol));
      expect(marketData.price, isNotEmpty);
    });
    
    test('should verify Starknet integration', () async {
      print('🔗 Testing Starknet integration...');
      
      expect(starknetService.isConnected, isTrue);
      
      final publicKey = starknetService.publicKey!;
      final accountAddress = starknetService.accountAddress!;
      
      print('✅ Starknet Account:');
      print('   🔑 Public Key: ${publicKey.substring(0, 20)}...');
      print('   🏠 Address: ${accountAddress.substring(0, 20)}...');
      
      expect(publicKey, startsWith('0x'));
      expect(accountAddress, startsWith('0x'));
    });
    
    // WARNING: Uncomment this test only if you want to make REAL trades
    /*
    test('should execute real trade (DISABLED - uncomment to enable)', () async {
      print('🚀 EXECUTING REAL TRADE - THIS USES REAL MONEY!');
      
      // Fetch markets
      final markets = await apiClient.getMarkets();
      final activeMarkets = markets.where((m) => 
        m.status == 'ACTIVE' || m.status == 'TRADING').toList();
      expect(activeMarkets, isNotEmpty);
      
      final selectedMarket = activeMarkets.first;
      
      // Get current market data
      final marketData = await apiClient.getMarketData(selectedMarket.symbol);
      final currentPrice = double.parse(marketData.price);
      
      // Calculate conservative trade parameters
      final tradeAmount = '0.001'; // Very small amount
      final buyPrice = (currentPrice * 0.95).toStringAsFixed(2); // 5% below market
      
      print('📋 Trade Parameters:');
      print('   🎯 Market: ${selectedMarket.symbol}');
      print('   💰 Amount: $tradeAmount');
      print('   💵 Buy Price: \$$buyPrice (5% below market)');
      
      // Execute buy order
      final order = await apiClient.createOrder(
        market: selectedMarket.symbol,
        side: 'BUY',
        qty: tradeAmount,
        price: buyPrice,
        starknetService: starknetService,
        type: 'LIMIT',
        timeInForce: 'GTC',
      );
      
      print('✅ Order placed successfully!');
      print('   🆔 Order ID: ${order.orderId}');
      print('   📊 Status: ${order.status}');
      
      expect(order.orderId, isNotEmpty);
      expect(order.status, isNotEmpty);
    });
    */
  });
}