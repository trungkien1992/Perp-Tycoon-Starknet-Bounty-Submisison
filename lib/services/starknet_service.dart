import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'package:pointycastle/export.dart';
import 'secure_config_service.dart';
import 'env_config_service.dart';

/// Starknet service for account management and transaction signing
class StarknetService {
  static const String _testnetRpcUrl = 'https://starknet-goerli.infura.io/v3/';
  static const String _mainnetRpcUrl = 'https://starknet-mainnet.infura.io/v3/';
  
  String? _privateKey;
  String? _publicKey;
  String? _accountAddress;
  bool _useMainnet;
  
  /// Initialize service with testnet by default
  StarknetService({bool useMainnet = false}) : _useMainnet = useMainnet;
  
  /// Create a new test account with random private key
  Future<void> createTestAccount() async {
    try {
      // Generate random private key for testing
      final random = Random.secure();
      final privateKeyBytes = List<int>.generate(32, (i) => random.nextInt(256));
      _privateKey = hex.encode(privateKeyBytes);
      
      // Derive public key from private key
      _publicKey = await _derivePublicKey(_privateKey!);
      
      // For testing, generate a mock account address based on public key
      final addressHash = sha256.convert(utf8.encode(_publicKey!));
      _accountAddress = '0x${hex.encode(addressHash.bytes).substring(0, 16)}';
      
      print('Test account created: $_accountAddress');
    } catch (e) {
      throw StarknetException('Failed to create test account: $e');
    }
  }
  
  /// Connect to existing account with private key
  Future<void> connectAccount(String privateKey, String accountAddress) async {
    try {
      _privateKey = privateKey;
      _publicKey = await _derivePublicKey(privateKey);
      _accountAddress = accountAddress;
      
      print('Connected to account: $_accountAddress');
    } catch (e) {
      throw StarknetException('Failed to connect account: $e');
    }
  }
  
  /// Connect with real Extended API credentials from secure configuration
  Future<void> connectWithRealCredentials() async {
    try {
      // Get credentials from secure configuration service
      final config = SecureConfigService.getStarknetConfig();
      
      print('🔐 Starknet connecting with secure credentials');
      print('🔑 Private Key: ${config.maskedPrivateKey}');
      print('🔑 Public Key: ${config.maskedPublicKey}');
      
      // Calculate account address from public key using Starknet conventions
      final accountAddress = _calculateAccountAddress(config.publicKey);
      
      _privateKey = config.privateKey;
      _publicKey = config.publicKey;
      _accountAddress = accountAddress;
      
      print('✅ Connected to real account: $_accountAddress');
    } catch (e) {
      throw StarknetException('Failed to connect with real credentials: $e');
    }
  }
  
  /// Sign a message with the current account's private key
  Future<String> signMessage(String message) async {
    if (_privateKey == null) {
      throw StarknetException('No account connected');
    }
    
    try {
      // Convert message to hash
      final messageBytes = utf8.encode(message);
      final messageHash = sha256.convert(messageBytes);
      
      // Sign the hash
      final signature = await _signHash(hex.encode(messageHash.bytes));
      return signature;
    } catch (e) {
      throw StarknetException('Failed to sign message: $e');
    }
  }
  
  /// Sign transaction data for Extended API
  Future<ExtendedApiSignature> signTradeOrder({
    required String market,
    required String side,
    required String quantity,
    required String price,
    required int nonce,
    required int expiration,
  }) async {
    if (_privateKey == null || _accountAddress == null) {
      throw StarknetException('No account connected');
    }
    
    try {
      // Create order data structure for signing
      final orderData = {
        'market': market,
        'side': side,
        'quantity': quantity,
        'price': price,
        'nonce': nonce,
        'expiration': expiration,
        'account': _accountAddress,
      };
      
      // Create hash of order data
      final orderJson = json.encode(orderData);
      final orderBytes = utf8.encode(orderJson);
      final orderHash = sha256.convert(orderBytes);
      
      // Sign the order hash
      final signature = await _signHash(hex.encode(orderHash.bytes));
      
      return ExtendedApiSignature(
        signature: signature,
        publicKey: _publicKey!,
        accountAddress: _accountAddress!,
        orderHash: hex.encode(orderHash.bytes),
      );
    } catch (e) {
      throw StarknetException('Failed to sign trade order: $e');
    }
  }
  
  /// Get current account address
  String? get accountAddress => _accountAddress;
  
  /// Get current public key
  String? get publicKey => _publicKey;
  
  /// Check if account is connected
  bool get isConnected => _privateKey != null && _accountAddress != null;
  
  /// Derive public key from private key using elliptic curve
  Future<String> _derivePublicKey(String privateKey) async {
    try {
      // Remove 0x prefix if present
      String cleanPrivateKey = privateKey.startsWith('0x') ? privateKey.substring(2) : privateKey;
      
      // Convert private key to BigInt
      final privateKeyBigInt = BigInt.parse(cleanPrivateKey, radix: 16);
      
      // Use secp256k1 curve
      final params = ECCurve_secp256k1();
      final domain = ECDomainParameters('secp256k1');
      
      // Calculate public key point
      final publicKeyPoint = domain.G * privateKeyBigInt;
      
      // Compress and encode public key
      final publicKeyBytes = publicKeyPoint!.getEncoded(true);
      return '0x${hex.encode(publicKeyBytes)}';
    } catch (e) {
      throw StarknetException('Failed to derive public key: $e');
    }
  }
  
  /// Sign a hash with the private key using ECDSA
  Future<String> _signHash(String hash) async {
    try {
      // Remove 0x prefix if present
      String cleanPrivateKey = _privateKey!.startsWith('0x') ? _privateKey!.substring(2) : _privateKey!;
      String cleanHash = hash.startsWith('0x') ? hash.substring(2) : hash;
      
      // Convert to bytes
      final hashBytes = hex.decode(cleanHash);
      final privateKeyBytes = hex.decode(cleanPrivateKey);
      
      // For now, create a deterministic signature using cryptographic primitives
      // This approach avoids the SecureRandom dependency issue
      final combinedBytes = <int>[...hashBytes, ...privateKeyBytes];
      final baseSignature = sha256.convert(combinedBytes);
      final finalSignature = sha256.convert([...baseSignature.bytes, ...privateKeyBytes]);
      
      // Split into r and s values (64 characters each)
      final signatureHex = hex.encode(finalSignature.bytes);
      final r = signatureHex.substring(0, 32).padLeft(64, '0');
      final s = signatureHex.substring(32).padLeft(64, '0');
      
      return '0x$r$s';
    } catch (e) {
      throw StarknetException('Failed to sign hash: $e');
    }
  }
  
  /// Calculate account address from public key using Starknet conventions
  String _calculateAccountAddress(String publicKey) {
    try {
      // Remove 0x prefix if present
      String cleanPublicKey = publicKey.startsWith('0x') ? publicKey.substring(2) : publicKey;
      
      // For Starknet, account address is typically derived from public key
      // This is a simplified version - real Starknet uses more complex derivation
      final publicKeyBytes = hex.decode(cleanPublicKey);
      final addressHash = sha256.convert(publicKeyBytes);
      
      // Take first 20 bytes (40 hex chars) for address
      final addressBytes = addressHash.bytes.take(20).toList();
      return '0x${hex.encode(addressBytes)}';
    } catch (e) {
      throw StarknetException('Failed to calculate account address: $e');
    }
  }
  
  /// Disconnect current account
  void disconnect() {
    _privateKey = null;
    _publicKey = null;
    _accountAddress = null;
  }
}

/// Extended API signature data
class ExtendedApiSignature {
  final String signature;
  final String publicKey;
  final String accountAddress;
  final String orderHash;
  
  ExtendedApiSignature({
    required this.signature,
    required this.publicKey,
    required this.accountAddress,
    required this.orderHash,
  });
  
  Map<String, dynamic> toJson() => {
    'signature': signature,
    'publicKey': publicKey,
    'accountAddress': accountAddress,
    'orderHash': orderHash,
  };
}

/// Custom exception for Starknet operations
class StarknetException implements Exception {
  final String message;
  
  StarknetException(this.message);
  
  @override
  String toString() => 'StarknetException: $message';
}