import 'dart:math';

/// Generate a random trace ID for error tracking
String generateTraceId() {
  final random = Random();
  final characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
  
  return List.generate(
    16,
    (index) => characters[random.nextInt(characters.length)],
  ).join();
}

/// Application error class with standardized structure
class AppError implements Exception {
  final String code;
  final String message;
  final Map<String, dynamic>? details;
  final String traceId;
  final DateTime timestamp;

  AppError({
    required this.code,
    required this.message,
    this.details,
    String? traceId,
  })  : traceId = traceId ?? generateTraceId(),
        timestamp = DateTime.now();

  /// Convert error to JSON format
  Map<String, dynamic> toJson() {
    return {
      'error': {
        'code': code,
        'message': message,
        'details': details,
        'timestamp': timestamp.toIso8601String(),
        'trace_id': traceId,
      }
    };
  }

  /// Create AppError from JSON
  factory AppError.fromJson(Map<String, dynamic> json) {
    final errorData = json['error'] as Map<String, dynamic>;
    
    return AppError(
      code: errorData['code'] as String,
      message: errorData['message'] as String,
      details: errorData['details'] as Map<String, dynamic>?,
      traceId: errorData['trace_id'] as String?,
    );
  }

  /// Convert to string representation
  @override
  String toString() {
    return 'AppError(code: $code, message: $message, traceId: $traceId)';
  }

  /// Create a copy with optional modifications
  AppError copyWith({
    String? code,
    String? message,
    Map<String, dynamic>? details,
    String? traceId,
  }) {
    return AppError(
      code: code ?? this.code,
      message: message ?? this.message,
      details: details ?? this.details,
      traceId: traceId ?? this.traceId,
    );
  }
}

/// Common error codes for the application
class ErrorCodes {
  // Trading errors (001-099)
  static const String tradingInsufficientBalance = 'TRADING_001';
  static const String tradingInvalidSymbol = 'TRADING_002';
  static const String tradingInvalidQuantity = 'TRADING_003';
  static const String tradingInvalidPrice = 'TRADING_004';
  static const String tradingOrderNotFound = 'TRADING_005';
  static const String tradingMarketClosed = 'TRADING_006';
  static const String tradingPositionNotFound = 'TRADING_007';
  static const String tradingRiskLimitExceeded = 'TRADING_008';
  
  // Authentication errors (100-199)
  static const String authInvalidCredentials = 'AUTH_100';
  static const String authTokenExpired = 'AUTH_101';
  static const String authTokenInvalid = 'AUTH_102';
  static const String authPermissionDenied = 'AUTH_103';
  static const String authSignatureInvalid = 'AUTH_104';
  static const String authNonceInvalid = 'AUTH_105';
  
  // Blockchain errors (200-299)
  static const String blockchainConnectionFailed = 'BLOCKCHAIN_200';
  static const String blockchainTransactionFailed = 'BLOCKCHAIN_201';
  static const String blockchainInsufficientGas = 'BLOCKCHAIN_202';
  static const String blockchainContractError = 'BLOCKCHAIN_203';
  static const String blockchainInvalidAddress = 'BLOCKCHAIN_204';
  static const String blockchainNetworkError = 'BLOCKCHAIN_205';
  
  // RAG/Knowledge base errors (300-399)
  static const String ragIndexNotFound = 'RAG_300';
  static const String ragSearchFailed = 'RAG_301';
  static const String ragDocumentNotFound = 'RAG_302';
  static const String ragProcessingFailed = 'RAG_303';
  static const String ragDatabaseError = 'RAG_304';
  
  // API/Network errors (400-499)
  static const String apiNetworkError = 'API_400';
  static const String apiTimeoutError = 'API_401';
  static const String apiRateLimitExceeded = 'API_402';
  static const String apiInvalidRequest = 'API_403';
  static const String apiInvalidResponse = 'API_404';
  static const String apiServiceUnavailable = 'API_405';
  
  // System errors (500-599)
  static const String systemConfigurationError = 'SYSTEM_500';
  static const String systemDatabaseError = 'SYSTEM_501';
  static const String systemFileError = 'SYSTEM_502';
  static const String systemMemoryError = 'SYSTEM_503';
  static const String systemUnknownError = 'SYSTEM_504';
}

/// Trading-specific error classes
class TradingError extends AppError {
  TradingError({
    required String code,
    required String message,
    Map<String, dynamic>? details,
    String? traceId,
  }) : super(
          code: code,
          message: message,
          details: details,
          traceId: traceId,
        );

  factory TradingError.insufficientBalance({
    required double required,
    required double available,
  }) {
    return TradingError(
      code: ErrorCodes.tradingInsufficientBalance,
      message: 'Insufficient balance for trade',
      details: {
        'required': required,
        'available': available,
      },
    );
  }

  factory TradingError.invalidSymbol(String symbol) {
    return TradingError(
      code: ErrorCodes.tradingInvalidSymbol,
      message: 'Invalid trading symbol',
      details: {'symbol': symbol},
    );
  }

  factory TradingError.invalidQuantity(double quantity) {
    return TradingError(
      code: ErrorCodes.tradingInvalidQuantity,
      message: 'Invalid quantity for trade',
      details: {'quantity': quantity},
    );
  }
}

/// Authentication-specific error classes
class AuthError extends AppError {
  AuthError({
    required String code,
    required String message,
    Map<String, dynamic>? details,
    String? traceId,
  }) : super(
          code: code,
          message: message,
          details: details,
          traceId: traceId,
        );

  factory AuthError.invalidCredentials() {
    return AuthError(
      code: ErrorCodes.authInvalidCredentials,
      message: 'Invalid credentials provided',
    );
  }

  factory AuthError.tokenExpired() {
    return AuthError(
      code: ErrorCodes.authTokenExpired,
      message: 'Authentication token has expired',
    );
  }

  factory AuthError.invalidSignature() {
    return AuthError(
      code: ErrorCodes.authSignatureInvalid,
      message: 'Invalid signature provided',
    );
  }
}

/// Blockchain-specific error classes
class BlockchainError extends AppError {
  BlockchainError({
    required String code,
    required String message,
    Map<String, dynamic>? details,
    String? traceId,
  }) : super(
          code: code,
          message: message,
          details: details,
          traceId: traceId,
        );

  factory BlockchainError.connectionFailed() {
    return BlockchainError(
      code: ErrorCodes.blockchainConnectionFailed,
      message: 'Failed to connect to blockchain network',
    );
  }

  factory BlockchainError.transactionFailed(String txHash) {
    return BlockchainError(
      code: ErrorCodes.blockchainTransactionFailed,
      message: 'Blockchain transaction failed',
      details: {'transaction_hash': txHash},
    );
  }

  factory BlockchainError.insufficientGas({
    required double required,
    required double available,
  }) {
    return BlockchainError(
      code: ErrorCodes.blockchainInsufficientGas,
      message: 'Insufficient gas for transaction',
      details: {
        'required': required,
        'available': available,
      },
    );
  }
}