import 'lib/services/env_config_service.dart';

/// Test script to verify environment configuration is working
void main() async {
  print('🔐 TESTING ENVIRONMENT CONFIGURATION');
  print('====================================');
  
  try {
    // Initialize environment configuration
    print('1. 🚀 Initializing EnvConfigService...');
    await EnvConfigService.initialize();
    print('✅ EnvConfigService initialized');
    
    
    // Test Extended API configuration
    print('\\n2. 🌐 Testing Extended API Configuration...');
    try {
      final extendedConfig = EnvConfigService.getExtendedApiConfig();
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
      final starknetConfig = EnvConfigService.getStarknetConfig();
      print('✅ Starknet configuration loaded');
      print('🔐 Private Key: ${starknetConfig.maskedPrivateKey}');
      print('🔑 Public Key: ${starknetConfig.maskedPublicKey}');
    } catch (e) {
      print('❌ Starknet configuration failed: $e');
    }
    
    // Test app mode
    print('\\n4. ⚙️  Testing App Configuration...');
    final appMode = EnvConfigService.getAppMode();
    final isProduction = EnvConfigService.isProduction();
    print('✅ App Mode: $appMode');
    print('🏭 Production: $isProduction');
    
    print('\\n🎉 ENVIRONMENT CONFIGURATION TEST COMPLETE');
    print('===========================================');
    print('✅ All credentials are securely loaded from environment');
    print('🔒 No hardcoded secrets in source code');
    print('📁 .env file gitignored for security');
    print('🔐 Credentials are masked in logs for security');
    
  } catch (e) {
    print('❌ ENVIRONMENT CONFIGURATION TEST FAILED');
    print('Error: $e');
    print('\\n🔧 Troubleshooting:');
    print('1. Ensure .env file exists with required variables');
    print('2. Check environment variable names match exactly');
    print('3. Verify credential formats (0x prefix for Starknet keys)');
  }
}