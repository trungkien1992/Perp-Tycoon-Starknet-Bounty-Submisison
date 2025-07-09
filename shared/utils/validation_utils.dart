import '../types/trading_types.dart';
import '../errors/app_error.dart';

/// Validation utility functions
class ValidationUtils {
  /// Email validation regex
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  
  /// URL validation regex
  static final RegExp _urlRegex = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  );
  
  /// Trading symbol validation regex
  static final RegExp _symbolRegex = RegExp(r'^[A-Z]{2,10}-[A-Z]{2,10}$');
  
  /// Validate email address
  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email.trim());
  }
  
  /// Validate URL
  static bool isValidUrl(String url) {
    return _urlRegex.hasMatch(url.trim());
  }
  
  /// Validate trading symbol format
  static bool isValidTradingSymbol(String symbol) {
    return _symbolRegex.hasMatch(symbol.trim().toUpperCase());
  }
  
  /// Validate price (must be positive)
  static bool isValidPrice(double price) {
    return price > 0 && price.isFinite;
  }
  
  /// Validate quantity (must be positive)
  static bool isValidQuantity(double quantity) {
    return quantity > 0 && quantity.isFinite;
  }
  
  /// Validate string is not empty
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
  
  /// Validate string length
  static bool isValidLength(String? value, {int? minLength, int? maxLength}) {
    if (value == null) return false;
    
    final length = value.length;
    
    if (minLength != null && length < minLength) return false;
    if (maxLength != null && length > maxLength) return false;
    
    return true;
  }
  
  /// Validate numeric string
  static bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
  
  /// Validate integer string
  static bool isInteger(String value) {
    return int.tryParse(value) != null;
  }
  
  /// Validate hex string
  static bool isValidHex(String value) {
    final cleanValue = value.replaceFirst('0x', '');
    return RegExp(r'^[a-fA-F0-9]+$').hasMatch(cleanValue);
  }
  
  /// Validate Ethereum address format
  static bool isValidEthereumAddress(String address) {
    final cleanAddress = address.replaceFirst('0x', '');
    return cleanAddress.length == 40 && isValidHex(address);
  }
  
  /// Validate order side
  static bool isValidOrderSide(String side) {
    return ['buy', 'sell', 'BUY', 'SELL'].contains(side);
  }
  
  /// Validate order type
  static bool isValidOrderType(String type) {
    return ['market', 'limit', 'stop', 'stop_limit', 'MARKET', 'LIMIT', 'STOP', 'STOP_LIMIT'].contains(type);
  }
  
  /// Validate order request
  static List<String> validateOrderRequest(OrderRequest order) {
    final errors = <String>[];
    
    if (!isValidTradingSymbol(order.symbol)) {
      errors.add('Invalid trading symbol format');
    }
    
    if (!isValidQuantity(order.quantity)) {
      errors.add('Invalid quantity: must be positive');
    }
    
    if (order.type == OrderType.limit && (order.price == null || !isValidPrice(order.price!))) {
      errors.add('Invalid price: required for limit orders and must be positive');
    }
    
    if (order.type == OrderType.stop && (order.stopPrice == null || !isValidPrice(order.stopPrice!))) {
      errors.add('Invalid stop price: required for stop orders and must be positive');
    }
    
    return errors;
  }
  
  /// Validate market data
  static List<String> validateMarketData(MarketData marketData) {
    final errors = <String>[];
    
    if (!isValidTradingSymbol(marketData.symbol)) {
      errors.add('Invalid trading symbol format');
    }
    
    if (!isValidPrice(marketData.price)) {
      errors.add('Invalid price: must be positive');
    }
    
    if (!isValidPrice(marketData.high24h)) {
      errors.add('Invalid 24h high: must be positive');
    }
    
    if (!isValidPrice(marketData.low24h)) {
      errors.add('Invalid 24h low: must be positive');
    }
    
    if (marketData.volume24h < 0 || !marketData.volume24h.isFinite) {
      errors.add('Invalid 24h volume: must be non-negative');
    }
    
    return errors;
  }
  
  /// Validate balance
  static List<String> validateBalance(Balance balance) {
    final errors = <String>[];
    
    if (!isNotEmpty(balance.asset)) {
      errors.add('Asset symbol is required');
    }
    
    if (balance.available < 0 || !balance.available.isFinite) {
      errors.add('Available balance must be non-negative');
    }
    
    if (balance.locked < 0 || !balance.locked.isFinite) {
      errors.add('Locked balance must be non-negative');
    }
    
    if (balance.total < 0 || !balance.total.isFinite) {
      errors.add('Total balance must be non-negative');
    }
    
    // Check if total equals available + locked
    final expectedTotal = balance.available + balance.locked;
    if ((balance.total - expectedTotal).abs() > 0.000001) {
      errors.add('Total balance should equal available + locked');
    }
    
    return errors;
  }
  
  /// Validate Starknet signature
  static List<String> validateStarknetSignature(StarknetSignature signature) {
    final errors = <String>[];
    
    if (!isValidHex(signature.r)) {
      errors.add('Invalid signature r component: must be valid hex');
    }
    
    if (!isValidHex(signature.s)) {
      errors.add('Invalid signature s component: must be valid hex');
    }
    
    if (!isValidHex(signature.publicKey)) {
      errors.add('Invalid public key: must be valid hex');
    }
    
    if (!isValidHex(signature.messageHash)) {
      errors.add('Invalid message hash: must be valid hex');
    }
    
    if (signature.recovery < 0 || signature.recovery > 3) {
      errors.add('Invalid recovery value: must be 0-3');
    }
    
    return errors;
  }
  
  /// Sanitize string input
  static String sanitizeString(String input) {
    return input.trim().replaceAll(RegExp(r'[^\w\s\-\._@]'), '');
  }
  
  /// Sanitize numeric input
  static String sanitizeNumeric(String input) {
    return input.replaceAll(RegExp(r'[^0-9\.\-]'), '');
  }
  
  /// Validate and parse price
  static double? parsePrice(String priceStr) {
    final sanitized = sanitizeNumeric(priceStr);
    final price = double.tryParse(sanitized);
    
    if (price == null || !isValidPrice(price)) {
      return null;
    }
    
    return price;
  }
  
  /// Validate and parse quantity
  static double? parseQuantity(String quantityStr) {
    final sanitized = sanitizeNumeric(quantityStr);
    final quantity = double.tryParse(sanitized);
    
    if (quantity == null || !isValidQuantity(quantity)) {
      return null;
    }
    
    return quantity;
  }
  
  /// Validate trading pair configuration
  static bool isValidTradingPair(TradingPair pair) {
    return isNotEmpty(pair.symbol) &&
           isNotEmpty(pair.baseAsset) &&
           isNotEmpty(pair.quoteAsset) &&
           pair.decimals >= 0 &&
           pair.decimals <= 18;
  }
  
  /// Validate API key format
  static bool isValidApiKey(String apiKey) {
    return isValidLength(apiKey, minLength: 16, maxLength: 128) &&
           RegExp(r'^[a-fA-F0-9]+$').hasMatch(apiKey);
  }
  
  /// Validate timestamp (not too old or too far in future)
  static bool isValidTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final diff = timestamp.difference(now).abs();
    
    // Allow timestamps within 24 hours of current time
    return diff.inHours <= 24;
  }
  
  /// Validate nonce (must be unique and not too old)
  static bool isValidNonce(int nonce, {int maxAgeMinutes = 60}) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final nonceAge = now - nonce;
    
    // Nonce should be recent (within max age)
    return nonceAge >= 0 && nonceAge <= (maxAgeMinutes * 60 * 1000);
  }
  
  /// Create validation error from field errors
  static AppError createValidationError(String field, List<String> errors) {
    return AppError(
      code: ErrorCodes.apiInvalidRequest,
      message: 'Validation failed for field: $field',
      details: {
        'field': field,
        'errors': errors,
      },
    );
  }
  
  /// Validate all required fields are present
  static List<String> validateRequiredFields(Map<String, dynamic> data, List<String> requiredFields) {
    final errors = <String>[];
    
    for (final field in requiredFields) {
      if (!data.containsKey(field) || data[field] == null) {
        errors.add('Field $field is required');
      } else if (data[field] is String && (data[field] as String).trim().isEmpty) {
        errors.add('Field $field cannot be empty');
      }
    }
    
    return errors;
  }
  
  /// Validate data type
  static bool isValidType<T>(dynamic value) {
    return value is T;
  }
  
  /// Round price to valid precision
  static double roundPrice(double price, {int decimals = 8}) {
    final factor = pow(10, decimals);
    return (price * factor).round() / factor;
  }
  
  /// Round quantity to valid precision
  static double roundQuantity(double quantity, {int decimals = 8}) {
    final factor = pow(10, decimals);
    return (quantity * factor).round() / factor;
  }
}