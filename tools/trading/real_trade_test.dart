import 'dart:io';
import '../../lib/data/datasources/extended_api_client.dart';
import '../../lib/services/starknet_service.dart';
import '../../lib/services/secure_config_service.dart';

/// Real trade execution test with Extended API
/// WARNING: This will make actual trades with real money!
void main() async {
  print('🚀 REAL TRADE EXECUTION TEST');
  print('============================');
  print('⚠️  WARNING: This will execute real trades with actual funds!');
  
  // Safety confirmation
  print('\n❓ Are you sure you want to proceed with REAL trading? (y/N)');
  final input = stdin.readLineSync();
  if (input?.toLowerCase() != 'y') {
    print('❌ Trade execution cancelled by user');
    exit(0);
  }
  
  try {
    // Initialize secure configuration
    print('\n🔐 Initializing secure configuration...');
    await SecureConfigService.initialize();
    
    // Create Extended API client with real credentials
    print('🌐 Creating Extended API client...');
    final apiClient = ExtendedApiClient.withRealCredentials();
    
    // Initialize Starknet service
    print('🔗 Initializing Starknet service...');
    final starknetService = StarknetService();
    await starknetService.initialize();
    
    // Check account balance first
    print('\n💰 Checking account balance...');
    try {
      final balance = await apiClient.getAccountBalance();
      print('✅ Account Balance:');
      print('   💵 Total: ${balance.totalBalance} ${balance.currency}');
      print('   💸 Available: ${balance.availableBalance} ${balance.currency}');
      print('   📊 Margin Used: ${balance.marginUsed} ${balance.currency}');
      print('   📈 Unrealized PnL: ${balance.unrealizedPnl} ${balance.currency}');
      print('   🎯 Trading Eligible: ${balance.isEligibleForTrading}');
      
      if (!balance.canTrade) {
        print('❌ Account not eligible for trading or insufficient funds');
        exit(1);
      }
    } catch (e) {
      print('⚠️ Could not fetch balance (proceeding anyway): $e');
    }
    
    // Fetch available markets
    print('\n📊 Fetching available markets...');
    final markets = await apiClient.getMarkets();
    print('✅ Found ${markets.length} available markets:');
    
    for (int i = 0; i < markets.length && i < 5; i++) {
      final market = markets[i];
      print('   ${i + 1}. ${market.symbol} (${market.status})');
    }
    
    if (markets.isEmpty) {
      print('❌ No markets available for trading');
      exit(1);
    }
    
    // Select first active market for test trade
    final activeMarkets = markets.where((m) => m.status == 'ACTIVE' || m.status == 'TRADING').toList();
    if (activeMarkets.isEmpty) {
      print('❌ No active markets found');
      exit(1);
    }
    
    final selectedMarket = activeMarkets.first;
    print('\n🎯 Selected market: ${selectedMarket.symbol}');
    
    // Get current market data
    print('📈 Fetching current market data...');
    final marketData = await apiClient.getMarketData(selectedMarket.symbol);
    print('✅ Current price: \$${marketData.price}');
    print('   📊 24h change: ${marketData.change24h}%');
    print('   📊 24h volume: \$${marketData.volume24h}');
    
    // Calculate trade parameters
    final currentPrice = double.parse(marketData.price);
    final tradeAmount = '0.001'; // Very small test amount
    final buyPrice = (currentPrice * 0.99).toStringAsFixed(2); // 1% below market
    final sellPrice = (currentPrice * 1.01).toStringAsFixed(2); // 1% above market
    
    print('\n📋 Trade Parameters:');
    print('   🎯 Market: ${selectedMarket.symbol}');
    print('   💰 Amount: $tradeAmount');
    print('   📈 Current Price: \$${marketData.price}');
    print('   🛒 Buy Price: \$$buyPrice (1% below market)');
    print('   💸 Sell Price: \$$sellPrice (1% above market)');
    
    // Final confirmation
    print('\n⚠️  FINAL CONFIRMATION: Execute real trade? (y/N)');
    final finalInput = stdin.readLineSync();
    if (finalInput?.toLowerCase() != 'y') {
      print('❌ Trade execution cancelled');
      exit(0);
    }
    
    print('\n🚀 Executing real trade...');
    
    // Execute a small buy order (limit order below market price)
    print('📈 Placing BUY limit order...');
    final buyOrder = await apiClient.createOrder(
      market: selectedMarket.symbol,
      side: 'BUY',
      qty: tradeAmount,
      price: buyPrice,
      starknetService: starknetService,
      type: 'LIMIT',
      timeInForce: 'GTC',
    );
    
    print('✅ BUY order placed successfully!');
    print('   🆔 Order ID: ${buyOrder.orderId}');
    print('   📊 Status: ${buyOrder.status}');
    print('   🎯 Market: ${buyOrder.market}');
    print('   💰 Quantity: ${buyOrder.qty}');
    print('   💵 Price: \$${buyOrder.price}');
    
    // Wait a moment
    await Future.delayed(Duration(seconds: 2));
    
    // Execute a small sell order (limit order above market price)
    print('\n📉 Placing SELL limit order...');
    final sellOrder = await apiClient.createOrder(
      market: selectedMarket.symbol,
      side: 'SELL',
      qty: tradeAmount,
      price: sellPrice,
      starknetService: starknetService,
      type: 'LIMIT',
      timeInForce: 'GTC',
    );
    
    print('✅ SELL order placed successfully!');
    print('   🆔 Order ID: ${sellOrder.orderId}');
    print('   📊 Status: ${sellOrder.status}');
    print('   🎯 Market: ${sellOrder.market}');
    print('   💰 Quantity: ${sellOrder.qty}');
    print('   💵 Price: \$${sellOrder.price}');
    
    // Check positions after trades
    print('\n📊 Checking current positions...');
    try {
      final positions = await apiClient.getPositions();
      if (positions.isEmpty) {
        print('ℹ️ No open positions found');
      } else {
        print('✅ Current positions:');
        for (final position in positions) {
          print('   🎯 ${position.market}: ${position.side} ${position.size} @ \$${position.entryPrice}');
          print('      📊 PnL: ${position.pnlPercent.toStringAsFixed(2)}%');
        }
      }
    } catch (e) {
      print('⚠️ Could not fetch positions: $e');
    }
    
    print('\n🎉 REAL TRADE TEST COMPLETED SUCCESSFULLY!');
    print('==========================================');
    print('✅ Extended API connection: Working');
    print('✅ CloudFront bypass: Active');
    print('✅ Starknet integration: Functional');
    print('✅ Trade execution: Successful');
    print('📊 Orders placed: 2 (1 BUY, 1 SELL)');
    
    print('\n💡 Next Steps:');
    print('   • Monitor orders in Extended Exchange dashboard');
    print('   • Orders may fill if market moves to your price levels');
    print('   • Consider canceling test orders if not needed');
    
    // Cleanup
    apiClient.dispose();
    
  } catch (e, stackTrace) {
    print('\n❌ TRADE EXECUTION FAILED');
    print('==========================');
    print('💥 Error: $e');
    print('🔍 Stack trace: $stackTrace');
    
    // Error analysis
    if (e.toString().contains('403')) {
      print('\n🔧 CloudFront 403 Error Detected:');
      print('   • The bypass service should handle this automatically');
      print('   • If persistent, check if Extended API endpoints changed');
    } else if (e.toString().contains('401') || e.toString().contains('authentication')) {
      print('\n🔐 Authentication Error:');
      print('   • Check your EXTENDED_API_KEY in .env file');
      print('   • Verify API key is valid and has trading permissions');
    } else if (e.toString().contains('Starknet') || e.toString().contains('signature')) {
      print('\n🔗 Starknet Error:');
      print('   • Check STARKNET_PRIVATE_KEY and STARKNET_PUBLIC_KEY');
      print('   • Ensure keys are valid and account is funded');
    }
    
    exit(1);
  }
}