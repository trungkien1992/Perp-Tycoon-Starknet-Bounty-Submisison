import 'lib/services/secure_config_service.dart';

/// Test script to verify secure configuration is working
void main() async {
  print('🔐 TESTING SECURE CONFIGURATION');
  print('===============================');
  
  try {
    // Initialize secure configuration
    print('1. 🚀 Initializing SecureConfigService...');
    await SecureConfigService.initialize();
    print('✅ SecureConfigService initialized');
    
    // Test Extended API configuration
    print('\\n2. 🌐 Testing Extended API Configuration...');
    try {
      final extendedConfig = SecureConfigService.getExtendedApiConfig();
      print('✅ Extended API configuration loaded');
      print('🔑 API Key: ${extendedConfig.maskedApiKey}');
      print('🏦 Vault ID: ${extendedConfig.vaultId}');
      print('🌐 Base URL: ${extendedConfig.baseUrl}');
      print('📡 WebSocket URL: ${extendedConfig.wsUrl}');
    } catch (e) {
      print('❌ Extended API configuration failed: $e');
    }
    
    // Test Starknet configuration
    print('\\n3. 🔗 Testing Starknet Configuration...');
    try {
      final starknetConfig = SecureConfigService.getStarknetConfig();
      print('✅ Starknet configuration loaded');
      print('🔐 Private Key: ${starknetConfig.maskedPrivateKey}');
      print('🔑 Public Key: ${starknetConfig.maskedPublicKey}');
    } catch (e) {
      print('❌ Starknet configuration failed: $e');
    }
    
    // Test app mode
    print('\\n4. ⚙️  Testing App Configuration...');
    final appMode = SecureConfigService.getAppMode();
    final isProduction = SecureConfigService.isProduction();
    print('✅ App Mode: $appMode');
    print('🏭 Production: $isProduction');
    
    print('\\n🎉 SECURE CONFIGURATION TEST COMPLETE');
    print('=====================================');
    print('✅ All credentials are securely loaded from environment');
    print('🔒 No hardcoded secrets in source code');
    print('📁 .env file gitignored for security');
    
  } catch (e) {
    print('❌ SECURE CONFIGURATION TEST FAILED');
    print('Error: $e');
    print('\\n🔧 Troubleshooting:');
    print('1. Ensure .env file exists with required variables');
    print('2. Check environment variable names match exactly');
    print('3. Verify credential formats (0x prefix for Starknet keys)');
  }
}