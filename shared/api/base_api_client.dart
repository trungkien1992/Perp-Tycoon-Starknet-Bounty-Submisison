import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../errors/app_error.dart';
import '../logging/logger_service.dart';

/// Base API Client for standardized HTTP communication
/// Provides common functionality for all API clients
abstract class BaseApiClient {
  final String baseUrl;
  final Map<String, String> defaultHeaders;
  final Duration timeout;
  final LoggerService _logger = LoggerService();

  BaseApiClient({
    required this.baseUrl,
    required this.defaultHeaders,
    this.timeout = const Duration(seconds: 30),
  });

  /// GET request with standardized error handling
  Future<T> get<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final requestHeaders = _buildHeaders(headers);

    _logger.logRequest('GET', uri.toString(), null);

    try {
      final response = await http
          .get(uri, headers: requestHeaders)
          .timeout(timeout);

      _logger.logResponse(response.statusCode, response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        return fromJson != null ? fromJson(responseData) : responseData as T;
      } else {
        throw _handleHttpError(response);
      }
    } on SocketException catch (e) {
      throw AppError(
        code: 'NETWORK_001',
        message: 'Network connection failed',
        details: {'original_error': e.toString()},
      );
    } on HttpException catch (e) {
      throw AppError(
        code: 'HTTP_001',
        message: 'HTTP request failed',
        details: {'original_error': e.toString()},
      );
    } on FormatException catch (e) {
      throw AppError(
        code: 'PARSE_001',
        message: 'Failed to parse response',
        details: {'original_error': e.toString()},
      );
    } catch (e) {
      throw AppError(
        code: 'UNKNOWN_001',
        message: 'Unknown error occurred',
        details: {'original_error': e.toString()},
      );
    }
  }

  /// POST request with standardized error handling
  Future<T> post<T>(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final requestHeaders = _buildHeaders(headers);
    final requestBody = body != null ? jsonEncode(body) : null;

    _logger.logRequest('POST', uri.toString(), body);

    try {
      final response = await http
          .post(uri, headers: requestHeaders, body: requestBody)
          .timeout(timeout);

      _logger.logResponse(response.statusCode, response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        return fromJson != null ? fromJson(responseData) : responseData as T;
      } else {
        throw _handleHttpError(response);
      }
    } on SocketException catch (e) {
      throw AppError(
        code: 'NETWORK_001',
        message: 'Network connection failed',
        details: {'original_error': e.toString()},
      );
    } on HttpException catch (e) {
      throw AppError(
        code: 'HTTP_001',
        message: 'HTTP request failed',
        details: {'original_error': e.toString()},
      );
    } on FormatException catch (e) {
      throw AppError(
        code: 'PARSE_001',
        message: 'Failed to parse response',
        details: {'original_error': e.toString()},
      );
    } catch (e) {
      throw AppError(
        code: 'UNKNOWN_001',
        message: 'Unknown error occurred',
        details: {'original_error': e.toString()},
      );
    }
  }

  /// PUT request with standardized error handling
  Future<T> put<T>(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final requestHeaders = _buildHeaders(headers);
    final requestBody = body != null ? jsonEncode(body) : null;

    _logger.logRequest('PUT', uri.toString(), body);

    try {
      final response = await http
          .put(uri, headers: requestHeaders, body: requestBody)
          .timeout(timeout);

      _logger.logResponse(response.statusCode, response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        return fromJson != null ? fromJson(responseData) : responseData as T;
      } else {
        throw _handleHttpError(response);
      }
    } on SocketException catch (e) {
      throw AppError(
        code: 'NETWORK_001',
        message: 'Network connection failed',
        details: {'original_error': e.toString()},
      );
    } on HttpException catch (e) {
      throw AppError(
        code: 'HTTP_001',
        message: 'HTTP request failed',
        details: {'original_error': e.toString()},
      );
    } on FormatException catch (e) {
      throw AppError(
        code: 'PARSE_001',
        message: 'Failed to parse response',
        details: {'original_error': e.toString()},
      );
    } catch (e) {
      throw AppError(
        code: 'UNKNOWN_001',
        message: 'Unknown error occurred',
        details: {'original_error': e.toString()},
      );
    }
  }

  /// DELETE request with standardized error handling
  Future<T> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final requestHeaders = _buildHeaders(headers);

    _logger.logRequest('DELETE', uri.toString(), null);

    try {
      final response = await http
          .delete(uri, headers: requestHeaders)
          .timeout(timeout);

      _logger.logResponse(response.statusCode, response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        return fromJson != null ? fromJson(responseData) : responseData as T;
      } else {
        throw _handleHttpError(response);
      }
    } on SocketException catch (e) {
      throw AppError(
        code: 'NETWORK_001',
        message: 'Network connection failed',
        details: {'original_error': e.toString()},
      );
    } on HttpException catch (e) {
      throw AppError(
        code: 'HTTP_001',
        message: 'HTTP request failed',
        details: {'original_error': e.toString()},
      );
    } on FormatException catch (e) {
      throw AppError(
        code: 'PARSE_001',
        message: 'Failed to parse response',
        details: {'original_error': e.toString()},
      );
    } catch (e) {
      throw AppError(
        code: 'UNKNOWN_001',
        message: 'Unknown error occurred',
        details: {'original_error': e.toString()},
      );
    }
  }

  /// Build URI with query parameters
  Uri _buildUri(String endpoint, Map<String, String>? queryParameters) {
    final url = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    final fullUrl = '$url${endpoint.startsWith('/') ? endpoint.substring(1) : endpoint}';
    
    if (queryParameters != null && queryParameters.isNotEmpty) {
      return Uri.parse(fullUrl).replace(queryParameters: queryParameters);
    }
    
    return Uri.parse(fullUrl);
  }

  /// Build headers by merging default and custom headers
  Map<String, String> _buildHeaders(Map<String, String>? customHeaders) {
    final headers = Map<String, String>.from(defaultHeaders);
    
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    
    // Ensure content-type is set for POST/PUT requests
    if (!headers.containsKey('Content-Type')) {
      headers['Content-Type'] = 'application/json';
    }
    
    return headers;
  }

  /// Handle HTTP errors and convert to AppError
  AppError _handleHttpError(http.Response response) {
    String errorCode;
    String errorMessage;
    Map<String, dynamic>? errorDetails;

    try {
      final responseData = jsonDecode(response.body);
      
      if (responseData is Map<String, dynamic> && responseData.containsKey('error')) {
        final error = responseData['error'];
        errorCode = error['code'] ?? 'HTTP_${response.statusCode}';
        errorMessage = error['message'] ?? 'HTTP Error ${response.statusCode}';
        errorDetails = error['details'];
      } else {
        errorCode = 'HTTP_${response.statusCode}';
        errorMessage = 'HTTP Error ${response.statusCode}';
        errorDetails = {'response_body': response.body};
      }
    } catch (e) {
      errorCode = 'HTTP_${response.statusCode}';
      errorMessage = 'HTTP Error ${response.statusCode}';
      errorDetails = {'response_body': response.body};
    }

    return AppError(
      code: errorCode,
      message: errorMessage,
      details: errorDetails,
    );
  }
}

/// Extended API Client specifically for Extended Exchange
class ExtendedApiClient extends BaseApiClient {
  final String apiKey;

  ExtendedApiClient({
    required String baseUrl,
    required this.apiKey,
    Duration timeout = const Duration(seconds: 30),
  }) : super(
          baseUrl: baseUrl,
          defaultHeaders: {
            'Content-Type': 'application/json',
            'X-API-Key': apiKey,
          },
          timeout: timeout,
        );

  /// Add Extended Exchange specific methods here
  Future<Map<String, dynamic>> getMarketData(String symbol) async {
    return await get<Map<String, dynamic>>(
      '/market/data',
      queryParameters: {'symbol': symbol},
    );
  }

  Future<Map<String, dynamic>> placeOrder(Map<String, dynamic> orderData) async {
    return await post<Map<String, dynamic>>(
      '/orders',
      body: orderData,
    );
  }

  Future<List<Map<String, dynamic>>> getOrderHistory() async {
    final response = await get<Map<String, dynamic>>('/orders/history');
    return (response['orders'] as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> getBalance() async {
    return await get<Map<String, dynamic>>('/account/balance');
  }
}