import 'dart:io';

/// Environment configuration service that works without Flutter dependencies
class EnvConfigService {
  static Map<String, String>? _envVars;
  static bool _initialized = false;
  
  /// Initialize the configuration service
  static Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      // Try to load .env file
      final envFile = File('.env');
      if (await envFile.exists()) {
        final contents = await envFile.readAsString();
        _envVars = _parseEnvFile(contents);
        print('✅ Environment configuration loaded from .env file');
      } else {
        print('⚠️ .env file not found, using system environment variables only');
        _envVars = <String, String>{};
      }
      _initialized = true;
    } catch (e) {
      print('⚠️ Error loading .env file: $e');
      _envVars = <String, String>{};
      _initialized = true;
    }
  }
  
  /// Parse .env file contents
  static Map<String, String> _parseEnvFile(String contents) {
    final Map<String, String> env = {};
    
    for (final line in contents.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.isEmpty || trimmed.startsWith('#')) continue;
      
      final separatorIndex = trimmed.indexOf('=');
      if (separatorIndex == -1) continue;
      
      final key = trimmed.substring(0, separatorIndex).trim();
      final value = trimmed.substring(separatorIndex + 1).trim();
      
      env[key] = value;
    }
    return env;
  }
  
  /// Get Extended API configuration
  static ExtendedApiConfig getExtendedApiConfig() {
    _ensureInitialized();
    
    final apiKey = _getRequiredEnvVar('EXTENDED_API_KEY');
    final vaultId = _getRequiredEnvVar('EXTENDED_VAULT_ID');
    final baseUrl = getEnvVar('EXTENDED_API_BASE_URL', 'https://extended.exchange/api');
    final wsUrl = getEnvVar('EXTENDED_API_WS_URL', 'wss://extended.exchange/ws');
    
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
      throw EnvConfigException('Invalid STARKNET_PRIVATE_KEY format. Must be 64 hex characters with 0x prefix.');
    }
    if (!_isValidPublicKey(publicKey)) {
      throw EnvConfigException('Invalid STARKNET_PUBLIC_KEY format. Must be 64 hex characters with 0x prefix.');
    }
    
    return StarknetConfig(
      privateKey: privateKey,
      publicKey: publicKey,
    );
  }
  
  /// Get environment variable with validation
  static String _getRequiredEnvVar(String key) {
    final value = getEnvVar(key, null);
    if (value == null || value.isEmpty) {
      throw EnvConfigException('Required environment variable $key is not set');
    }
    return value;
  }
  
  /// Get environment variable with optional default
  static String getEnvVar(String key, String? defaultValue) {
    // First try loaded .env file
    if (_envVars != null && _envVars!.containsKey(key)) {
      return _envVars![key]!;
    }
    
    // Then try system environment
    final systemValue = Platform.environment[key];
    if (systemValue != null && systemValue.isNotEmpty) {
      return systemValue;
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
      throw EnvConfigException('EnvConfigService not initialized. Call initialize() first.');
    }
  }
  
  /// Check if running in production environment
  static bool isProduction() {
    final env = getEnvVar('FLUTTER_ENV', 'development');
    return env == 'production';
  }
  
  /// Get app mode
  static String getAppMode() {
    return getEnvVar('APP_MODE', 'mock');
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

/// Exception for environment configuration errors
class EnvConfigException implements Exception {
  final String message;
  
  EnvConfigException(this.message);
  
  @override
  String toString() => 'EnvConfigException: $message';
}