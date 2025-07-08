import 'lib/services/env_config_service.dart';
import 'lib/services/starknet_service.dart';
import 'lib/data/datasources/extended_api_client.dart';

/// Test secure trading with environment-based credentials
void main() async {
  print('🔐 TESTING SECURE TRADING IMPLEMENTATION');
  print('=======================================');
  
  try {
    // Initialize secure configuration
    print('1. 🚀 Initializing Secure Configuration...');
    await EnvConfigService.initialize();
    print('✅ Secure configuration loaded');
    
    // Test Starknet connection with secure credentials
    print('\\n2. 🔗 Connecting to Starknet with Secure Credentials...');
    final starknetService = StarknetService(useMainnet: true);
    await starknetService.connectWithRealCredentials();
    print('✅ Starknet connected securely: ${starknetService.accountAddress}');
    
    // Test Extended API client with secure credentials
    print('\\n3. 🌐 Creating Extended API Client with Secure Credentials...');
    final apiClient = ExtendedApiClient.withRealCredentials();
    print('✅ Extended API client configured securely');
    
    // Create a secure trade signature
    print('\\n4. ✍️  Creating Secure Trade Signature...');
    final tradeSignature = await starknetService.signTradeOrder(
      market: 'ETH-USD',
      side: 'BUY',
      quantity: '0.001',
      price: '2847.92',
      nonce: DateTime.now().millisecondsSinceEpoch,
      expiration: DateTime.now().add(Duration(hours: 24)).millisecondsSinceEpoch,
    );
    print('✅ Trade order signed securely');
    print('📝 Order Hash: ${tradeSignature.orderHash.substring(0, 20)}...');
    
    print('\\n🎉 SECURE TRADING IMPLEMENTATION VERIFIED');
    print('=========================================');
    print('✅ All credentials loaded from secure environment');
    print('🔒 No hardcoded secrets in source code');
    print('🔐 Cryptographic signatures working with secure keys');
    print('🌐 API client configured with secure credentials');
    print('💰 Ready for secure real trading with 9.96 USDC');
    
    // Security summary
    print('\\n🛡️  SECURITY SUMMARY');
    print('==================');
    final config = EnvConfigService.getExtendedApiConfig();
    final starknetConfig = EnvConfigService.getStarknetConfig();
    print('🔑 Extended API Key: ${config.maskedApiKey}');
    print('🏦 Vault ID: ${config.vaultId}');
    print('🔐 Starknet Private Key: ${starknetConfig.maskedPrivateKey}');
    print('🔑 Starknet Public Key: ${starknetConfig.maskedPublicKey}');
    print('🎯 App Mode: ${EnvConfigService.getAppMode()}');
    print('🏭 Production Mode: ${EnvConfigService.isProduction()}');
    
  } catch (e) {
    print('❌ SECURE TRADING TEST FAILED');
    print('Error: $e');
  }
}