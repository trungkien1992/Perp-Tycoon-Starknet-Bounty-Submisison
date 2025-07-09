import 'dart:io';
import 'package:http/http.dart' as http;
import 'app_error.dart';
import '../logging/logger_service.dart';

/// Error handler for converting various exception types to AppError
class ErrorHandler {
  static final LoggerService _logger = LoggerService();

  /// Handle any error and convert to AppError
  static AppError handleError(dynamic error, {String? context}) {
    // Log the error
    _logger.log(
      level: LogLevel.error,
      message: 'Error occurred: ${error.toString()}',
      metadata: {
        'context': context,
        'error_type': error.runtimeType.toString(),
      },
      service: 'error_handler',
    );

    // Return AppError if it's already one
    if (error is AppError) {
      return error;
    }

    // Handle HTTP-related errors
    if (error is http.ClientException) {
      return AppError(
        code: ErrorCodes.apiNetworkError,
        message: 'Network request failed',
        details: {
          'original_error': error.message,
          'context': context,
        },
      );
    }

    if (error is SocketException) {
      return AppError(
        code: ErrorCodes.apiNetworkError,
        message: 'Network connection failed',
        details: {
          'original_error': error.message,
          'context': context,
        },
      );
    }

    if (error is HttpException) {
      return AppError(
        code: ErrorCodes.apiNetworkError,
        message: 'HTTP request failed',
        details: {
          'original_error': error.message,
          'context': context,
        },
      );
    }

    // Handle timeout errors
    if (error is TimeoutException) {
      return AppError(
        code: ErrorCodes.apiTimeoutError,
        message: 'Request timeout',
        details: {
          'original_error': error.message,
          'context': context,
        },
      );
    }

    // Handle format/parsing errors
    if (error is FormatException) {
      return AppError(
        code: ErrorCodes.apiInvalidResponse,
        message: 'Failed to parse response',
        details: {
          'original_error': error.message,
          'context': context,
        },
      );
    }

    // Handle file system errors
    if (error is FileSystemException) {
      return AppError(
        code: ErrorCodes.systemFileError,
        message: 'File system error',
        details: {
          'original_error': error.message,
          'path': error.path,
          'context': context,
        },
      );
    }

    // Handle argument errors
    if (error is ArgumentError) {
      return AppError(
        code: ErrorCodes.apiInvalidRequest,
        message: 'Invalid argument provided',
        details: {
          'original_error': error.message,
          'context': context,
        },
      );
    }

    // Handle state errors
    if (error is StateError) {
      return AppError(
        code: ErrorCodes.systemUnknownError,
        message: 'Invalid state',
        details: {
          'original_error': error.message,
          'context': context,
        },
      );
    }

    // Handle unsupported errors
    if (error is UnsupportedError) {
      return AppError(
        code: ErrorCodes.systemUnknownError,
        message: 'Unsupported operation',
        details: {
          'original_error': error.message,
          'context': context,
        },
      );
    }

    // Default error for unknown types
    return AppError(
      code: ErrorCodes.systemUnknownError,
      message: 'An unexpected error occurred',
      details: {
        'original_error': error.toString(),
        'error_type': error.runtimeType.toString(),
        'context': context,
      },
    );
  }

  /// Handle API response errors
  static AppError handleApiResponse(http.Response response, {String? context}) {
    _logger.log(
      level: LogLevel.warning,
      message: 'API error response: ${response.statusCode}',
      metadata: {
        'status_code': response.statusCode,
        'response_body': response.body,
        'context': context,
      },
      service: 'error_handler',
    );

    String errorCode;
    String errorMessage;
    Map<String, dynamic>? errorDetails;

    // Try to parse error from response body
    try {
      final responseData = jsonDecode(response.body);
      if (responseData is Map<String, dynamic> && responseData.containsKey('error')) {
        final error = responseData['error'] as Map<String, dynamic>;
        errorCode = error['code'] as String? ?? 'HTTP_${response.statusCode}';
        errorMessage = error['message'] as String? ?? _getDefaultHttpMessage(response.statusCode);
        errorDetails = error['details'] as Map<String, dynamic>?;
      } else {
        errorCode = 'HTTP_${response.statusCode}';
        errorMessage = _getDefaultHttpMessage(response.statusCode);
        errorDetails = {'response_body': response.body};
      }
    } catch (e) {
      errorCode = 'HTTP_${response.statusCode}';
      errorMessage = _getDefaultHttpMessage(response.statusCode);
      errorDetails = {'response_body': response.body};
    }

    return AppError(
      code: errorCode,
      message: errorMessage,
      details: {
        ...?errorDetails,
        'status_code': response.statusCode,
        'context': context,
      },
    );
  }

  /// Get default HTTP error message based on status code
  static String _getDefaultHttpMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 405:
        return 'Method Not Allowed';
      case 408:
        return 'Request Timeout';
      case 409:
        return 'Conflict';
      case 422:
        return 'Unprocessable Entity';
      case 429:
        return 'Too Many Requests';
      case 500:
        return 'Internal Server Error';
      case 502:
        return 'Bad Gateway';
      case 503:
        return 'Service Unavailable';
      case 504:
        return 'Gateway Timeout';
      default:
        return 'HTTP Error $statusCode';
    }
  }

  /// Create trading error from validation
  static TradingError createTradingError({
    required String code,
    required String message,
    Map<String, dynamic>? details,
    String? context,
  }) {
    _logger.log(
      level: LogLevel.error,
      message: 'Trading error: $message',
      metadata: {
        'code': code,
        'details': details,
        'context': context,
      },
      service: 'error_handler',
    );

    return TradingError(
      code: code,
      message: message,
      details: {
        ...?details,
        'context': context,
      },
    );
  }

  /// Create blockchain error from validation
  static BlockchainError createBlockchainError({
    required String code,
    required String message,
    Map<String, dynamic>? details,
    String? context,
  }) {
    _logger.log(
      level: LogLevel.error,
      message: 'Blockchain error: $message',
      metadata: {
        'code': code,
        'details': details,
        'context': context,
      },
      service: 'error_handler',
    );

    return BlockchainError(
      code: code,
      message: message,
      details: {
        ...?details,
        'context': context,
      },
    );
  }

  /// Create auth error from validation
  static AuthError createAuthError({
    required String code,
    required String message,
    Map<String, dynamic>? details,
    String? context,
  }) {
    _logger.log(
      level: LogLevel.error,
      message: 'Authentication error: $message',
      metadata: {
        'code': code,
        'details': details,
        'context': context,
      },
      service: 'error_handler',
    );

    return AuthError(
      code: code,
      message: message,
      details: {
        ...?details,
        'context': context,
      },
    );
  }

  /// Log error for debugging
  static void logError(AppError error, {String? additionalContext}) {
    _logger.log(
      level: LogLevel.error,
      message: 'AppError: ${error.message}',
      metadata: {
        'code': error.code,
        'details': error.details,
        'trace_id': error.traceId,
        'timestamp': error.timestamp.toIso8601String(),
        'additional_context': additionalContext,
      },
      service: 'error_handler',
    );
  }
}

/// Extension methods for easier error handling
extension ErrorHandlerExtension on Exception {
  /// Convert any exception to AppError
  AppError toAppError({String? context}) {
    return ErrorHandler.handleError(this, context: context);
  }
}

/// Mixin for classes that need error handling
mixin ErrorHandlerMixin {
  /// Handle error and log it
  AppError handleError(dynamic error, {String? context}) {
    return ErrorHandler.handleError(error, context: context);
  }

  /// Handle API response error
  AppError handleApiResponse(http.Response response, {String? context}) {
    return ErrorHandler.handleApiResponse(response, context: context);
  }

  /// Create and log trading error
  TradingError createTradingError({
    required String code,
    required String message,
    Map<String, dynamic>? details,
    String? context,
  }) {
    return ErrorHandler.createTradingError(
      code: code,
      message: message,
      details: details,
      context: context,
    );
  }
}