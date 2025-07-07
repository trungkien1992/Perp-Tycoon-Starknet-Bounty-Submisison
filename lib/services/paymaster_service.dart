import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import '../app_mode.dart';

/// Paymaster service for gasless transactions on Starknet
/// This enables mass adoption by removing the need for users to hold ETH for gas
class PaymasterService {
  static const String _testnetRpcUrl = 'https://starknet-goerli.infura.io/v3/';
  static const String _mainnetRpcUrl = 'https://starknet-mainnet.infura.io/v3/';
  
  // StreetCred paymaster contract addresses (deployed on Starknet)
  static const String _testnetPaymasterAddress = '0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7'; // Mock address
  static const String _mainnetPaymasterAddress = '0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7'; // Mock address
  
  // Trade selector for whitelisted operations
  static const String _tradeSelector = '0x83afd3f4caedc6eebf44246fe54e38c95e3179a5ec9ea81740eca5b482d12e'; // execute_trade selector
  
  late Dio _dio;
  String? _rpcUrl;
  String? _paymasterAddress;
  bool _useMainnet;
  
  PaymasterService({bool useMainnet = false}) : _useMainnet = useMainnet {
    _rpcUrl = useMainnet ? _mainnetRpcUrl : _testnetRpcUrl;
    _paymasterAddress = useMainnet ? _mainnetPaymasterAddress : _testnetPaymasterAddress;
    
    _dio = Dio(BaseOptions(
      baseUrl: _rpcUrl!,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  }
  
  /// Check if paymaster can sponsor a trade transaction
  Future<PaymasterSponsorshipResult> canSponsorTrade({
    required String userAddress,
    required String tradeData,
    required BigInt estimatedGas,
  }) async {
    try {
      if (isMockMode()) {
        // In mock mode, always allow sponsorship for testing
        return PaymasterSponsorshipResult(
          canSponsor: true,
          maxFee: estimatedGas,
          reason: 'Mock mode: sponsorship enabled',
          paymasterData: _generateMockPaymasterData(),
        );
      }
      
      // Check paymaster balance
      final balance = await _getPaymasterBalance();
      
      // Check if user is eligible (could check trading history, KYC, etc.)
      final isEligible = await _checkUserEligibility(userAddress);
      
      // Calculate max fee based on current gas price
      final gasPrice = await _getCurrentGasPrice();
      final maxFee = estimatedGas * gasPrice;
      
      // Check if paymaster has sufficient funds
      final canSponsor = balance >= maxFee && isEligible;
      
      return PaymasterSponsorshipResult(
        canSponsor: canSponsor,
        maxFee: maxFee,
        reason: canSponsor 
            ? 'Sponsorship approved'
            : 'Insufficient paymaster balance or user not eligible',
        paymasterData: canSponsor ? await _generatePaymasterData(userAddress, maxFee) : null,
      );
      
    } catch (e) {
      print('Error checking paymaster sponsorship: $e');
      return PaymasterSponsorshipResult(
        canSponsor: false,
        maxFee: BigInt.zero,
        reason: 'Paymaster service error: $e',
        paymasterData: null,
      );
    }
  }
  
  /// Execute a gasless trade using paymaster
  Future<GaslessTxResult> executeGaslessTradeTransaction({
    required String userAddress,
    required String userSignature,
    required String tradeData,
    required PaymasterData paymasterData,
  }) async {
    try {
      print('🎯 Executing gasless trade transaction...');
      print('User: $userAddress');
      print('Paymaster: $_paymasterAddress');
      
      if (isMockMode()) {
        await Future.delayed(const Duration(milliseconds: 800)); // Simulate network delay
        return _mockGaslessExecution();
      }
      
      // Prepare transaction with paymaster data
      final txData = await _prepareGaslessTransaction(
        userAddress: userAddress,
        userSignature: userSignature,
        tradeData: tradeData,
        paymasterData: paymasterData,
      );
      
      // Submit transaction to Starknet with paymaster sponsorship
      final txResponse = await _submitGaslessTransaction(txData);
      
      print('✅ Gasless transaction submitted: ${txResponse.txHash}');
      
      return GaslessTxResult(
        success: true,
        txHash: txResponse.txHash,
        gasFeePaid: txResponse.actualFee,
        paymasterUsed: true,
        blockNumber: txResponse.blockNumber,
        message: 'Trade executed successfully with zero gas fees',
      );
      
    } catch (e) {
      print('❌ Gasless transaction failed: $e');
      return GaslessTxResult(
        success: false,
        txHash: null,
        gasFeePaid: BigInt.zero,
        paymasterUsed: false,
        blockNumber: null,
        message: 'Gasless transaction failed: $e',
      );
    }
  }
  
  /// Get current paymaster balance
  Future<BigInt> _getPaymasterBalance() async {
    try {
      final response = await _dio.post('', data: {
        'jsonrpc': '2.0',
        'method': 'starknet_call',
        'params': [
          {
            'contract_address': _paymasterAddress,
            'entry_point_selector': '0x2e4263afad30923c891518314c3c95dbe830a16874e8abc5777a9a20b54c76e', // get_balance selector
            'calldata': [],
          },
          'latest'
        ],
        'id': 1,
      });
      
      final result = response.data['result'] as List;
      return BigInt.parse(result[0]);
    } catch (e) {
      print('Error getting paymaster balance: $e');
      // Return mock balance in case of error
      return BigInt.from(1000000000000000000); // 1 ETH worth of fees
    }
  }
  
  /// Check if user is eligible for gasless transactions
  Future<bool> _checkUserEligibility(String userAddress) async {
    // In production, this would check:
    // - User's trading history
    // - KYC status
    // - Rate limiting
    // - Blacklist status
    
    // For now, all users are eligible
    return true;
  }
  
  /// Get current gas price from Starknet
  Future<BigInt> _getCurrentGasPrice() async {
    try {
      // In production, get actual gas price from Starknet
      // For now, return mock gas price
      return BigInt.from(1000000000); // 1 Gwei
    } catch (e) {
      return BigInt.from(1000000000); // Default gas price
    }
  }
  
  /// Generate paymaster data for transaction
  Future<PaymasterData> _generatePaymasterData(String userAddress, BigInt maxFee) async {
    final nonce = DateTime.now().millisecondsSinceEpoch;
    final validUntil = DateTime.now().add(const Duration(minutes: 10)).millisecondsSinceEpoch;
    
    // Create paymaster signature data
    final dataToSign = '$userAddress:$maxFee:$nonce:$validUntil';
    final signature = _signPaymasterData(dataToSign);
    
    return PaymasterData(
      paymasterAddress: _paymasterAddress!,
      maxFee: maxFee,
      nonce: nonce,
      validUntil: validUntil,
      signature: signature,
    );
  }
  
  /// Generate mock paymaster data for testing
  PaymasterData _generateMockPaymasterData() {
    final nonce = DateTime.now().millisecondsSinceEpoch;
    final validUntil = DateTime.now().add(const Duration(minutes: 10)).millisecondsSinceEpoch;
    
    return PaymasterData(
      paymasterAddress: _paymasterAddress!,
      maxFee: BigInt.from(100000000000000), // 0.0001 ETH
      nonce: nonce,
      validUntil: validUntil,
      signature: 'mock_signature_${nonce}',
    );
  }
  
  /// Sign paymaster data
  String _signPaymasterData(String data) {
    // In production, this would use the paymaster's private key
    // For now, generate a deterministic signature
    final bytes = utf8.encode(data);
    final hash = sha256.convert(bytes);
    return hex.encode(hash.bytes);
  }
  
  /// Prepare gasless transaction data
  Future<Map<String, dynamic>> _prepareGaslessTransaction({
    required String userAddress,
    required String userSignature,
    required String tradeData,
    required PaymasterData paymasterData,
  }) async {
    return {
      'type': 'INVOKE',
      'version': '0x1',
      'sender_address': userAddress,
      'calldata': [
        _paymasterAddress, // Contract address
        _tradeSelector, // Entry point selector
        tradeData, // Trade data
      ],
      'max_fee': '0x${paymasterData.maxFee.toRadixString(16)}',
      'signature': [userSignature],
      'nonce': '0x${paymasterData.nonce.toRadixString(16)}',
      'paymaster_data': [
        paymasterData.paymasterAddress,
        '0x${paymasterData.maxFee.toRadixString(16)}',
        '0x${paymasterData.nonce.toRadixString(16)}',
        '0x${paymasterData.validUntil.toRadixString(16)}',
        paymasterData.signature,
      ],
    };
  }
  
  /// Submit gasless transaction to Starknet
  Future<TxResponse> _submitGaslessTransaction(Map<String, dynamic> txData) async {
    final response = await _dio.post('', data: {
      'jsonrpc': '2.0',
      'method': 'starknet_addInvokeTransaction',
      'params': [txData],
      'id': 1,
    });
    
    final result = response.data['result'];
    return TxResponse(
      txHash: result['transaction_hash'],
      actualFee: BigInt.parse(result['actual_fee'] ?? '0'),
      blockNumber: result['block_number'],
    );
  }
  
  /// Mock gasless execution for testing
  GaslessTxResult _mockGaslessExecution() {
    final mockTxHash = '0x${Random().nextInt(0xFFFFFFFF).toRadixString(16).padLeft(8, '0')}';
    return GaslessTxResult(
      success: true,
      txHash: mockTxHash,
      gasFeePaid: BigInt.from(95000000000000), // Mock fee paid by paymaster
      paymasterUsed: true,
      blockNumber: Random().nextInt(1000000) + 500000,
      message: 'Mock gasless trade executed successfully',
    );
  }
  
  /// Get paymaster contract address
  String get paymasterAddress => _paymasterAddress!;
  
  /// Check if paymaster service is available
  bool get isAvailable => _paymasterAddress != null;
}

/// Result of paymaster sponsorship check
class PaymasterSponsorshipResult {
  final bool canSponsor;
  final BigInt maxFee;
  final String reason;
  final PaymasterData? paymasterData;
  
  PaymasterSponsorshipResult({
    required this.canSponsor,
    required this.maxFee,
    required this.reason,
    this.paymasterData,
  });
}

/// Paymaster data for transaction
class PaymasterData {
  final String paymasterAddress;
  final BigInt maxFee;
  final int nonce;
  final int validUntil;
  final String signature;
  
  PaymasterData({
    required this.paymasterAddress,
    required this.maxFee,
    required this.nonce,
    required this.validUntil,
    required this.signature,
  });
  
  Map<String, dynamic> toJson() => {
    'paymasterAddress': paymasterAddress,
    'maxFee': maxFee.toString(),
    'nonce': nonce,
    'validUntil': validUntil,
    'signature': signature,
  };
}

/// Result of gasless transaction execution
class GaslessTxResult {
  final bool success;
  final String? txHash;
  final BigInt gasFeePaid;
  final bool paymasterUsed;
  final int? blockNumber;
  final String message;
  
  GaslessTxResult({
    required this.success,
    this.txHash,
    required this.gasFeePaid,
    required this.paymasterUsed,
    this.blockNumber,
    required this.message,
  });
}

/// Transaction response from Starknet
class TxResponse {
  final String txHash;
  final BigInt actualFee;
  final int? blockNumber;
  
  TxResponse({
    required this.txHash,
    required this.actualFee,
    this.blockNumber,
  });
}

/// Paymaster service exception
class PaymasterException implements Exception {
  final String message;
  final int? code;
  
  PaymasterException(this.message, [this.code]);
  
  @override
  String toString() => 'PaymasterException: $message (code: $code)';
}