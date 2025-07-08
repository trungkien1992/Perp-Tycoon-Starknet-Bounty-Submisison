import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'env_config_service.dart';

/// Secure configuration service for managing sensitive credentials
class SecureConfigService {
  static bool _initialized = false;
  
  /// Initialize the secure configuration service
  static Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      // Load environment variables from .env file
      await dotenv.load(fileName: '.env');
      _initialized = true;
      print('✅ Secure configuration loaded');
    } catch (e) {
      // Fallback to simple env config for plain Dart environments
      try {
        await EnvConfigService.initialize();
        _initialized = true;
        print('✅ Configuration loaded via fallback service');
      } catch (e2) {
        print('⚠️ .env file not found, using environment variables only');
        _initialized = true;
      }
    }
  }
  
  /// Get Extended API configuration
  static ExtendedApiConfig getExtendedApiConfig() {
    _ensureInitialized();
    
    final apiKey = _getRequiredEnvVar('EXTENDED_API_KEY');
    final vaultId = _getRequiredEnvVar('EXTENDED_VAULT_ID');
    final baseUrl = _getEnvVar('EXTENDED_API_BASE_URL', 'https://extended.exchange/api');
    final wsUrl = _getEnvVar('EXTENDED_API_WS_URL', 'wss://extended.exchange/ws');
    
    return ExtendedApiConfig(
      apiKey: apiKey,
      vaultId: vaultId,
      baseUrl: baseUrl,
      wsUrl: wsUrl,
    );
  }
  
  /// Get Starknet configuration
  static StarknetConfig getStarknetConfig() {
    _ensureInitialized();
    
    final privateKey = _getRequiredEnvVar('STARKNET_PRIVATE_KEY');
    final publicKey = _getRequiredEnvVar('STARKNET_PUBLIC_KEY');
    
    // Validate key formats
    if (!_isValidPrivateKey(privateKey)) {
      throw SecureConfigException('Invalid STARKNET_PRIVATE_KEY format. Must be 64 hex characters with 0x prefix.');
    }
    if (!_isValidPublicKey(publicKey)) {
      throw SecureConfigException('Invalid STARKNET_PUBLIC_KEY format. Must be 64 hex characters with 0x prefix.');
    }
    
    return StarknetConfig(
      privateKey: privateKey,
      publicKey: publicKey,
    );
  }
  
  /// Get environment variable with validation
  static String _getRequiredEnvVar(String key) {
    final value = _getEnvVar(key, null);
    if (value == null || value.isEmpty) {
      throw SecureConfigException('Required environment variable $key is not set');
    }
    return value;
  }
  
  /// Get environment variable with optional default
  static String _getEnvVar(String key, String? defaultValue) {
    try {
      // First try dotenv (Flutter environment)
      if (_initialized && dotenv.env.containsKey(key)) {
        return dotenv.env[key]!;
      }
    } catch (e) {
      // dotenv not available, try fallback service
      try {
        return EnvConfigService.getEnvVar(key, defaultValue ?? '');
      } catch (e2) {
        // Fallback service also failed
      }
    }
    
    // Then try system environment
    final value = String.fromEnvironment(key, defaultValue: '');
    if (value.isNotEmpty) {
      return value;
    }
    
    // Return default
    if (defaultValue != null) {
      return defaultValue;
    }
    
    return '';
  }
  
  /// Validate private key format
  static bool _isValidPrivateKey(String key) {
    if (!key.startsWith('0x')) return false;
    final hexPart = key.substring(2);
    if (hexPart.length != 64) return false;
    return RegExp(r'^[0-9a-fA-F]+$').hasMatch(hexPart);
  }
  
  /// Validate public key format
  static bool _isValidPublicKey(String key) {
    if (!key.startsWith('0x')) return false;
    final hexPart = key.substring(2);
    if (hexPart.length != 64) return false;
    return RegExp(r'^[0-9a-fA-F]+$').hasMatch(hexPart);
  }
  
  /// Check if configuration is initialized
  static void _ensureInitialized() {
    if (!_initialized) {
      throw SecureConfigException('SecureConfigService not initialized. Call initialize() first.');
    }
  }
  
  /// Check if running in production environment
  static bool isProduction() {
    final env = _getEnvVar('FLUTTER_ENV', 'development');
    return env == 'production';
  }
  
  /// Get app mode
  static String getAppMode() {
    return _getEnvVar('APP_MODE', 'mock');
  }
}

/// Extended API configuration
class ExtendedApiConfig {
  final String apiKey;
  final String vaultId;
  final String baseUrl;
  final String wsUrl;
  
  const ExtendedApiConfig({
    required this.apiKey,
    required this.vaultId,
    required this.baseUrl,
    required this.wsUrl,
  });
  
  /// Masked API key for logging (shows only first 8 characters)
  String get maskedApiKey => '${apiKey.substring(0, 8)}...';
}

/// Starknet configuration
class StarknetConfig {
  final String privateKey;
  final String publicKey;
  
  const StarknetConfig({
    required this.privateKey,
    required this.publicKey,
  });
  
  /// Masked private key for logging (shows only first 8 characters)
  String get maskedPrivateKey => '${privateKey.substring(0, 10)}...';
  
  /// Masked public key for logging (shows only first 8 characters)
  String get maskedPublicKey => '${publicKey.substring(0, 10)}...';
}

/// Exception for secure configuration errors
class SecureConfigException implements Exception {
  final String message;
  
  SecureConfigException(this.message);
  
  @override
  String toString() => 'SecureConfigException: $message';
}