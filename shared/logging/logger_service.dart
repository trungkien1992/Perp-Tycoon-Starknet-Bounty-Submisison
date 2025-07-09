import 'dart:convert';
import 'dart:io';
import 'dart:math';

/// Log levels for filtering and categorizing logs
enum LogLevel {
  debug,
  info,
  warning,
  error,
  critical,
}

/// Extension for LogLevel to provide string representation
extension LogLevelExtension on LogLevel {
  String get name {
    switch (this) {
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warning:
        return 'WARNING';
      case LogLevel.error:
        return 'ERROR';
      case LogLevel.critical:
        return 'CRITICAL';
    }
  }

  int get priority {
    switch (this) {
      case LogLevel.debug:
        return 0;
      case LogLevel.info:
        return 1;
      case LogLevel.warning:
        return 2;
      case LogLevel.error:
        return 3;
      case LogLevel.critical:
        return 4;
    }
  }
}

/// Logger service for centralized logging across the application
class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  factory LoggerService() => _instance;
  LoggerService._internal();

  LogLevel _minimumLevel = LogLevel.info;
  bool _enableFileLogging = true;
  bool _enableConsoleLogging = true;
  String _logFilePath = '';
  final List<Map<String, dynamic>> _logBuffer = [];
  int _maxBufferSize = 100;

  /// Initialize the logger with configuration
  void initialize({
    LogLevel minimumLevel = LogLevel.info,
    bool enableFileLogging = true,
    bool enableConsoleLogging = true,
    String? logFilePath,
    int maxBufferSize = 100,
  }) {
    _minimumLevel = minimumLevel;
    _enableFileLogging = enableFileLogging;
    _enableConsoleLogging = enableConsoleLogging;
    _maxBufferSize = maxBufferSize;
    
    if (logFilePath != null) {
      _logFilePath = logFilePath;
    } else {
      _logFilePath = _getDefaultLogPath();
    }
  }

  /// Log a message with specified level
  void log({
    required LogLevel level,
    required String message,
    Map<String, dynamic>? metadata,
    String? service,
    String? traceId,
    String? userId,
    Exception? exception,
  }) {
    // Skip if level is below minimum
    if (level.priority < _minimumLevel.priority) {
      return;
    }

    final logEntry = _createLogEntry(
      level: level,
      message: message,
      metadata: metadata,
      service: service,
      traceId: traceId,
      userId: userId,
      exception: exception,
    );

    // Add to buffer
    _logBuffer.add(logEntry);
    if (_logBuffer.length > _maxBufferSize) {
      _logBuffer.removeAt(0);
    }

    // Output to console
    if (_enableConsoleLogging) {
      _logToConsole(logEntry);
    }

    // Output to file
    if (_enableFileLogging && _logFilePath.isNotEmpty) {
      _logToFile(logEntry);
    }

    // Send to centralized logging (placeholder for future implementation)
    _sendToLogAggregator(logEntry);
  }

  /// Log debug message
  void debug(String message, {Map<String, dynamic>? metadata, String? service, String? traceId}) {
    log(
      level: LogLevel.debug,
      message: message,
      metadata: metadata,
      service: service,
      traceId: traceId,
    );
  }

  /// Log info message
  void info(String message, {Map<String, dynamic>? metadata, String? service, String? traceId}) {
    log(
      level: LogLevel.info,
      message: message,
      metadata: metadata,
      service: service,
      traceId: traceId,
    );
  }

  /// Log warning message
  void warning(String message, {Map<String, dynamic>? metadata, String? service, String? traceId}) {
    log(
      level: LogLevel.warning,
      message: message,
      metadata: metadata,
      service: service,
      traceId: traceId,
    );
  }

  /// Log error message
  void error(
    String message, {
    Map<String, dynamic>? metadata,
    String? service,
    String? traceId,
    Exception? exception,
  }) {
    log(
      level: LogLevel.error,
      message: message,
      metadata: metadata,
      service: service,
      traceId: traceId,
      exception: exception,
    );
  }

  /// Log critical message
  void critical(
    String message, {
    Map<String, dynamic>? metadata,
    String? service,
    String? traceId,
    Exception? exception,
  }) {
    log(
      level: LogLevel.critical,
      message: message,
      metadata: metadata,
      service: service,
      traceId: traceId,
      exception: exception,
    );
  }

  /// Log HTTP request
  void logRequest(String method, String url, dynamic body, {String? traceId}) {
    log(
      level: LogLevel.info,
      message: '$method $url',
      metadata: {
        'type': 'http_request',
        'method': method,
        'url': url,
        'body': _sanitizeBody(body),
        'timestamp': DateTime.now().toIso8601String(),
      },
      service: 'api_client',
      traceId: traceId,
    );
  }

  /// Log HTTP response
  void logResponse(int statusCode, dynamic body, {String? traceId}) {
    log(
      level: statusCode >= 400 ? LogLevel.error : LogLevel.info,
      message: 'Response $statusCode',
      metadata: {
        'type': 'http_response',
        'status_code': statusCode,
        'body': _sanitizeBody(body),
        'timestamp': DateTime.now().toIso8601String(),
      },
      service: 'api_client',
      traceId: traceId,
    );
  }

  /// Get recent logs
  List<Map<String, dynamic>> getRecentLogs({int? limit}) {
    final logs = List<Map<String, dynamic>>.from(_logBuffer);
    if (limit != null && logs.length > limit) {
      return logs.sublist(logs.length - limit);
    }
    return logs;
  }

  /// Get logs by level
  List<Map<String, dynamic>> getLogsByLevel(LogLevel level) {
    return _logBuffer.where((log) => log['level'] == level.name).toList();
  }

  /// Get logs by service
  List<Map<String, dynamic>> getLogsByService(String service) {
    return _logBuffer.where((log) => log['service'] == service).toList();
  }

  /// Get logs by trace ID
  List<Map<String, dynamic>> getLogsByTraceId(String traceId) {
    return _logBuffer.where((log) => log['trace_id'] == traceId).toList();
  }

  /// Clear log buffer
  void clearLogs() {
    _logBuffer.clear();
  }

  /// Create log entry
  Map<String, dynamic> _createLogEntry({
    required LogLevel level,
    required String message,
    Map<String, dynamic>? metadata,
    String? service,
    String? traceId,
    String? userId,
    Exception? exception,
  }) {
    final entry = {
      'timestamp': DateTime.now().toIso8601String(),
      'level': level.name,
      'message': message,
      'service': service ?? 'unknown',
      'trace_id': traceId ?? _generateTraceId(),
      'user_id': userId,
      'metadata': metadata ?? {},
    };

    if (exception != null) {
      entry['exception'] = {
        'type': exception.runtimeType.toString(),
        'message': exception.toString(),
        'stack_trace': StackTrace.current.toString(),
      };
    }

    return entry;
  }

  /// Log to console with color formatting
  void _logToConsole(Map<String, dynamic> logEntry) {
    final level = logEntry['level'] as String;
    final message = logEntry['message'] as String;
    final service = logEntry['service'] as String;
    final timestamp = logEntry['timestamp'] as String;
    final traceId = logEntry['trace_id'] as String;

    // Color codes for different log levels
    const colors = {
      'DEBUG': '\x1b[36m',    // Cyan
      'INFO': '\x1b[32m',     // Green
      'WARNING': '\x1b[33m',  // Yellow
      'ERROR': '\x1b[31m',    // Red
      'CRITICAL': '\x1b[35m', // Magenta
    };
    const reset = '\x1b[0m';

    final color = colors[level] ?? '';
    final output = '$color[$level]$reset [$timestamp] [$service] [$traceId] $message';

    print(output);

    // Print metadata if present
    final metadata = logEntry['metadata'] as Map<String, dynamic>?;
    if (metadata != null && metadata.isNotEmpty) {
      print('  Metadata: ${jsonEncode(metadata)}');
    }

    // Print exception if present
    final exception = logEntry['exception'] as Map<String, dynamic>?;
    if (exception != null) {
      print('  Exception: ${exception['type']} - ${exception['message']}');
    }
  }

  /// Log to file
  void _logToFile(Map<String, dynamic> logEntry) {
    try {
      final file = File(_logFilePath);
      final jsonLog = jsonEncode(logEntry);
      file.writeAsStringSync('$jsonLog\n', mode: FileMode.append);
    } catch (e) {
      // If file logging fails, at least log to console
      print('Failed to write to log file: $e');
    }
  }

  /// Send to centralized log aggregator (placeholder)
  void _sendToLogAggregator(Map<String, dynamic> logEntry) {
    // This is a placeholder for future implementation
    // Could send to services like:
    // - Elasticsearch
    // - Splunk
    // - DataDog
    // - Custom log aggregation service
  }

  /// Generate a random trace ID
  String _generateTraceId() {
    final random = Random();
    final chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(16, (index) => chars[random.nextInt(chars.length)]).join();
  }

  /// Get default log file path
  String _getDefaultLogPath() {
    return 'logs/app_${DateTime.now().millisecondsSinceEpoch}.log';
  }

  /// Sanitize body for logging (remove sensitive data)
  dynamic _sanitizeBody(dynamic body) {
    if (body is Map<String, dynamic>) {
      final sanitized = <String, dynamic>{};
      body.forEach((key, value) {
        if (_isSensitiveField(key)) {
          sanitized[key] = '[REDACTED]';
        } else if (value is Map<String, dynamic>) {
          sanitized[key] = _sanitizeBody(value);
        } else {
          sanitized[key] = value;
        }
      });
      return sanitized;
    }
    
    if (body is String) {
      // Check if it's JSON and sanitize
      try {
        final parsed = jsonDecode(body);
        return jsonEncode(_sanitizeBody(parsed));
      } catch (e) {
        return body;
      }
    }
    
    return body;
  }

  /// Check if field contains sensitive data
  bool _isSensitiveField(String fieldName) {
    const sensitiveFields = {
      'password',
      'secret',
      'token',
      'key',
      'private_key',
      'api_key',
      'auth_token',
      'authorization',
      'signature',
      'pin',
      'ssn',
      'credit_card',
      'card_number',
    };
    
    return sensitiveFields.any((field) => 
      fieldName.toLowerCase().contains(field));
  }
}