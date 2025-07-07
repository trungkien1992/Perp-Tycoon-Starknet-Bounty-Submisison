import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

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
  
  /// Derive public key from private key
  Future<String> _derivePublicKey(String privateKey) async {
    try {
      // For now, return a mock public key derived from private key
      // In production, use proper Starknet key derivation
      final privateKeyBytes = hex.decode(privateKey);
      final publicKeyHash = sha256.convert(privateKeyBytes);
      return hex.encode(publicKeyHash.bytes);
    } catch (e) {
      throw StarknetException('Failed to derive public key: $e');
    }
  }
  
  /// Sign a hash with the private key
  Future<String> _signHash(String hash) async {
    try {
      // For testing, create a mock signature
      // In production, use proper Starknet signature algorithm
      final hashBytes = hex.decode(hash);
      final privateKeyBytes = hex.decode(_privateKey!);
      
      // Create deterministic signature for testing
      final combinedBytes = [...hashBytes, ...privateKeyBytes];
      final signatureHash = sha256.convert(combinedBytes);
      
      return hex.encode(signatureHash.bytes);
    } catch (e) {
      throw StarknetException('Failed to sign hash: $e');
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