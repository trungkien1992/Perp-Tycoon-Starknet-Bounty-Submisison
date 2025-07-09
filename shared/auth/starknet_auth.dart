import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import '../errors/app_error.dart';
import '../logging/logger_service.dart';
import '../types/trading_types.dart';

/// Starknet authentication and signature utilities
class StarknetAuth {
  static const String starknetMessagePrefix = "StarkEx Message";
  static const String networkMainnet = "mainnet";
  static const String networkTestnet = "testnet";
  static const String networkSepolia = "sepolia";
  
  static final LoggerService _logger = LoggerService();
  
  /// Asset configurations for Extended Exchange
  static const Map<String, Map<String, dynamic>> assetConfigs = {
    'BTC-USD': {
      'synthetic_id': 0x4254432d38000000000000000000000,
      'collateral_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d,
      'synthetic_decimals': 10,
      'collateral_decimals': 6
    },
    'ETH-USD': {
      'synthetic_id': 0x4554482d38000000000000000000000,
      'collateral_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d,
      'synthetic_decimals': 10,
      'collateral_decimals': 6
    },
    'EUR-USD': {
      'synthetic_id': 0x4555522d5553442d38000000000000,
      'collateral_id': 0x2893294412a4c8f915f75892b395ebbf6859ec246ec365c3b1f56f47c3a0a5d,
      'synthetic_decimals': 10,
      'collateral_decimals': 6
    }
  };
  
  /// Generate a random private key for testing
  static String generatePrivateKey() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (i) => random.nextInt(256));
    return hex.encode(bytes);
  }
  
  /// Derive public key from private key
  static String derivePublicKey(String privateKeyHex) {
    try {
      // This is a simplified implementation
      // In production, use the official StarkWare libraries
      final privateKeyBytes = hex.decode(privateKeyHex);
      final hash = sha256.convert(privateKeyBytes);
      return hex.encode(hash.bytes);
    } catch (e) {
      _logger.error(
        'Failed to derive public key',
        metadata: {'error': e.toString()},
        service: 'starknet_auth',
      );
      throw AuthError.invalidCredentials();
    }
  }
  
  /// Generate account address from public key
  static String generateAccountAddress(String publicKey) {
    try {
      final addressHash = sha256.convert(utf8.encode(publicKey));
      return '0x${hex.encode(addressHash.bytes).substring(0, 16)}';
    } catch (e) {
      _logger.error(
        'Failed to generate account address',
        metadata: {'error': e.toString()},
        service: 'starknet_auth',
      );
      throw AuthError.invalidCredentials();
    }
  }
  
  /// Create a test account with random credentials
  static Map<String, String> createTestAccount() {
    final privateKey = generatePrivateKey();
    final publicKey = derivePublicKey(privateKey);
    final accountAddress = generateAccountAddress(publicKey);
    
    _logger.info(
      'Test account created',
      metadata: {
        'address': accountAddress,
        'public_key': publicKey,
      },
      service: 'starknet_auth',
    );
    
    return {
      'private_key': privateKey,
      'public_key': publicKey,
      'account_address': accountAddress,
    };
  }
  
  /// Validate private key format
  static bool isValidPrivateKey(String privateKey) {
    try {
      final cleanKey = privateKey.replaceFirst('0x', '');
      return cleanKey.length == 64 && RegExp(r'^[a-fA-F0-9]+\$').hasMatch(cleanKey);
    } catch (e) {
      return false;
    }
  }
  
  /// Validate account address format
  static bool isValidAccountAddress(String address) {
    try {
      final cleanAddress = address.replaceFirst('0x', '');
      return cleanAddress.length >= 16 && 
             cleanAddress.length <= 64 && 
             RegExp(r'^[a-fA-F0-9]+\$').hasMatch(cleanAddress);
    } catch (e) {
      return false;
    }
  }
  
  /// Scale amount to StarkEx format
  static int scaleAmount(String amount, int decimals) {
    try {
      final amountDouble = double.parse(amount);
      final scaled = amountDouble * pow(10, decimals);
      return scaled.toInt();
    } catch (e) {
      _logger.error(
        'Failed to scale amount',
        metadata: {
          'amount': amount,
          'decimals': decimals,
          'error': e.toString(),
        },
        service: 'starknet_auth',
      );
      throw TradingError.invalidQuantity(double.tryParse(amount) ?? 0);
    }
  }
  
  /// Calculate trading fee
  static int calculateFee(int collateralAmount, {double feeRate = 0.00025}) {
    return (collateralAmount * feeRate).toInt();
  }
  
  /// Simple Pedersen hash fallback (for testing only)
  static int pedersenHashFallback(int a, int b) {
    final combined = '$a$b';
    final hash = sha256.convert(utf8.encode(combined));
    final hashInt = BigInt.parse(hex.encode(hash.bytes), radix: 16);
    return (hashInt % BigInt.from(pow(2, 251))).toInt();
  }
  
  /// Generate message hash for limit order
  static int generateOrderMessageHash({
    required int syntheticAssetId,
    required int collateralAssetId,
    required int isBuyingSynthetic,
    required int feeAssetId,
    required int amountSynthetic,
    required int amountCollateral,
    required int maxFee,
    required int nonce,
    required int vaultId,
    required int expirationHours,
  }) {
    try {
      // Instruction type for limit order
      const instructionType = 0;
      
      // Build message components
      final vaultSell = vaultId;
      final vaultBuy = vaultId;
      final amountSell = isBuyingSynthetic == 1 ? amountCollateral : amountSynthetic;
      final amountBuy = isBuyingSynthetic == 1 ? amountSynthetic : amountCollateral;
      final tokenSell = isBuyingSynthetic == 1 ? collateralAssetId : syntheticAssetId;
      final tokenBuy = isBuyingSynthetic == 1 ? syntheticAssetId : collateralAssetId;
      
      // Create packed message for hashing
      var part1 = pedersenHashFallback(instructionType, vaultSell);
      part1 = pedersenHashFallback(part1, vaultBuy);
      part1 = pedersenHashFallback(part1, amountSell);
      part1 = pedersenHashFallback(part1, amountBuy);
      part1 = pedersenHashFallback(part1, tokenSell);
      part1 = pedersenHashFallback(part1, tokenBuy);
      part1 = pedersenHashFallback(part1, feeAssetId);
      part1 = pedersenHashFallback(part1, maxFee);
      part1 = pedersenHashFallback(part1, nonce);
      part1 = pedersenHashFallback(part1, expirationHours);
      
      return part1;
    } catch (e) {
      _logger.error(
        'Failed to generate order message hash',
        metadata: {'error': e.toString()},
        service: 'starknet_auth',
      );
      throw AuthError.invalidSignature();
    }
  }
  
  /// Sign message hash (simplified implementation)
  static StarknetSignature signMessage(String privateKeyHex, int messageHash) {
    try {
      final privateKey = BigInt.parse(privateKeyHex, radix: 16);
      
      // Simple signature generation (placeholder)
      // In production, use official StarkWare signature libraries
      final r = (messageHash + privateKey.toInt()) % pow(2, 251).toInt();
      final s = (messageHash * 2 + privateKey.toInt()) % pow(2, 251).toInt();
      
      return StarknetSignature(
        r: '0x${r.toRadixString(16).padLeft(64, '0')}',
        s: '0x${s.toRadixString(16).padLeft(64, '0')}',
        publicKey: derivePublicKey(privateKeyHex),
        messageHash: '0x${messageHash.toRadixString(16).padLeft(64, '0')}',
        recovery: 0,
      );
    } catch (e) {
      _logger.error(
        'Failed to sign message',
        metadata: {'error': e.toString()},
        service: 'starknet_auth',
      );
      throw AuthError.invalidSignature();
    }
  }
  
  /// Sign trading order for Extended Exchange
  static Map<String, dynamic> signOrder({
    required String privateKeyHex,
    required int vaultId,
    required String market,
    required String side,
    required String quantity,
    required String price,
    required int nonce,
    required int expirationTimestamp,
  }) {
    try {
      if (!assetConfigs.containsKey(market)) {
        throw TradingError.invalidSymbol(market);
      }
      
      final config = assetConfigs[market]!;
      
      // Scale amounts to StarkEx format
      final amountSynthetic = scaleAmount(quantity, config['synthetic_decimals']);
      final quantityDouble = double.parse(quantity);
      final priceDouble = double.parse(price);
      final amountCollateral = scaleAmount(
        (quantityDouble * priceDouble).toString(),
        config['collateral_decimals']
      );
      
      // Calculate fee
      final maxFee = calculateFee(amountCollateral);
      
      // Determine buy/sell direction
      final isBuyingSynthetic = side.toUpperCase() == 'BUY' ? 1 : 0;
      
      // Convert expiration to hours
      final expirationHours = expirationTimestamp ~/ (1000 * 3600);
      
      // Calculate message hash
      final messageHash = generateOrderMessageHash(
        syntheticAssetId: config['synthetic_id'],
        collateralAssetId: config['collateral_id'],
        isBuyingSynthetic: isBuyingSynthetic,
        feeAssetId: config['collateral_id'],
        amountSynthetic: amountSynthetic,
        amountCollateral: amountCollateral,
        maxFee: maxFee,
        nonce: nonce,
        vaultId: vaultId,
        expirationHours: expirationHours,
      );
      
      // Sign the message hash
      final signature = signMessage(privateKeyHex, messageHash);
      
      _logger.info(
        'Order signed successfully',
        metadata: {
          'market': market,
          'side': side,
          'quantity': quantity,
          'price': price,
          'message_hash': signature.messageHash,
        },
        service: 'starknet_auth',
      );
      
      return {
        'signature': {
          'r': signature.r,
          's': signature.s,
        },
        'starkKey': signature.publicKey,
        'collateralPosition': vaultId.toString(),
        'msgHash': signature.messageHash,
        'orderDetails': {
          'market': market,
          'side': side,
          'amountSynthetic': amountSynthetic,
          'amountCollateral': amountCollateral,
          'maxFee': maxFee,
          'nonce': nonce,
          'expirationHours': expirationHours,
        },
      };
    } catch (e) {
      _logger.error(
        'Failed to sign order',
        metadata: {
          'market': market,
          'side': side,
          'error': e.toString(),
        },
        service: 'starknet_auth',
      );
      
      if (e is AppError) {
        rethrow;
      }
      
      throw TradingError(
        code: ErrorCodes.tradingInvalidQuantity,
        message: 'Failed to sign order: $e',
      );
    }
  }
  
  /// Verify signature (simplified implementation)
  static bool verifySignature(StarknetSignature signature) {
    try {
      // In production, use official StarkWare verification libraries
      final r = BigInt.parse(signature.r.replaceFirst('0x', ''), radix: 16);
      final s = BigInt.parse(signature.s.replaceFirst('0x', ''), radix: 16);
      
      // Simple verification (placeholder)
      return r.toInt() > 0 && s.toInt() > 0;
    } catch (e) {
      _logger.error(
        'Failed to verify signature',
        metadata: {'error': e.toString()},
        service: 'starknet_auth',
      );
      return false;
    }
  }
  
  /// Get network RPC URL
  static String getNetworkRpcUrl(String network) {
    switch (network) {
      case networkMainnet:
        return 'https://starknet-mainnet.infura.io/v3/';
      case networkTestnet:
        return 'https://starknet-goerli.infura.io/v3/';
      case networkSepolia:
        return 'https://starknet-sepolia.infura.io/v3/';
      default:
        throw ArgumentError('Unsupported network: $network');
    }
  }
  
  /// Generate nonce for order
  static int generateNonce() {
    return DateTime.now().millisecondsSinceEpoch;
  }
  
  /// Generate expiration timestamp (1 hour from now)
  static int generateExpirationTimestamp({int hoursFromNow = 1}) {
    return DateTime.now().millisecondsSinceEpoch + (hoursFromNow * 60 * 60 * 1000);
  }
}