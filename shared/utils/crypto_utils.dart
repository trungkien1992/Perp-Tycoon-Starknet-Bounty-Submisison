import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

/// Cryptographic utility functions
class CryptoUtils {
  /// Generate a secure random string
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }
  
  /// Generate a secure random hex string
  static String generateRandomHex(int byteLength) {
    final random = Random.secure();
    final bytes = List<int>.generate(byteLength, (i) => random.nextInt(256));
    return hex.encode(bytes);
  }
  
  /// Hash a string using SHA-256
  static String sha256Hash(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// Hash bytes using SHA-256
  static String sha256HashBytes(List<int> bytes) {
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// Generate HMAC-SHA256
  static String hmacSha256(String message, String key) {
    final keyBytes = utf8.encode(key);
    final messageBytes = utf8.encode(message);
    final hmac = Hmac(sha256, keyBytes);
    final digest = hmac.convert(messageBytes);
    return digest.toString();
  }
  
  /// Encode data to Base64
  static String base64Encode(String data) {
    final bytes = utf8.encode(data);
    return base64.encode(bytes);
  }
  
  /// Decode data from Base64
  static String base64Decode(String data) {
    final bytes = base64.decode(data);
    return utf8.decode(bytes);
  }
  
  /// Encode data to Base64 URL-safe
  static String base64UrlEncode(String data) {
    final bytes = utf8.encode(data);
    return base64Url.encode(bytes);
  }
  
  /// Decode data from Base64 URL-safe
  static String base64UrlDecode(String data) {
    final bytes = base64Url.decode(data);
    return utf8.decode(bytes);
  }
  
  /// Convert hex string to bytes
  static List<int> hexToBytes(String hexString) {
    final cleanHex = hexString.replaceFirst('0x', '');
    return hex.decode(cleanHex);
  }
  
  /// Convert bytes to hex string
  static String bytesToHex(List<int> bytes, {bool withPrefix = false}) {
    final hexString = hex.encode(bytes);
    return withPrefix ? '0x$hexString' : hexString;
  }
  
  /// Validate hex string format
  static bool isValidHex(String hexString) {
    final cleanHex = hexString.replaceFirst('0x', '');
    return RegExp(r'^[a-fA-F0-9]+$').hasMatch(cleanHex) && cleanHex.length % 2 == 0;
  }
  
  /// Pad hex string to specified length
  static String padHex(String hexString, int targetLength) {
    final cleanHex = hexString.replaceFirst('0x', '');
    return cleanHex.padLeft(targetLength, '0');
  }
  
  /// Generate a UUID v4
  static String generateUuid() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (i) => random.nextInt(256));
    
    // Set version (4) and variant bits
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20, 32)}';
  }
  
  /// Generate a nonce (timestamp-based)
  static String generateNonce() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
  
  /// Generate a secure API key
  static String generateApiKey({int length = 32}) {
    return generateRandomHex(length);
  }
  
  /// Constant-time string comparison
  static bool constantTimeEquals(String a, String b) {
    if (a.length != b.length) {
      return false;
    }
    
    int result = 0;
    for (int i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    
    return result == 0;
  }
  
  /// Hash password with salt
  static Map<String, String> hashPassword(String password, {String? salt}) {
    salt ??= generateRandomHex(16);
    final combined = password + salt;
    final hash = sha256Hash(combined);
    
    return {
      'hash': hash,
      'salt': salt,
    };
  }
  
  /// Verify password against hash
  static bool verifyPassword(String password, String hash, String salt) {
    final combined = password + salt;
    final computedHash = sha256Hash(combined);
    return constantTimeEquals(computedHash, hash);
  }
  
  /// Create a checksum for data integrity
  static String createChecksum(String data) {
    return sha256Hash(data).substring(0, 8);
  }
  
  /// Verify data integrity using checksum
  static bool verifyChecksum(String data, String checksum) {
    final computedChecksum = createChecksum(data);
    return constantTimeEquals(computedChecksum, checksum);
  }
  
  /// Generate a JWT-style timestamp
  static int getJwtTimestamp() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }
  
  /// Check if timestamp is expired
  static bool isTimestampExpired(int timestamp, {int expirationSeconds = 3600}) {
    final now = getJwtTimestamp();
    return (now - timestamp) > expirationSeconds;
  }
  
  /// Encode integer to bytes (big-endian)
  static List<int> intToBytes(int value, {int byteLength = 4}) {
    final bytes = <int>[];
    for (int i = byteLength - 1; i >= 0; i--) {
      bytes.add((value >> (i * 8)) & 0xff);
    }
    return bytes;
  }
  
  /// Decode bytes to integer (big-endian)
  static int bytesToInt(List<int> bytes) {
    int result = 0;
    for (int i = 0; i < bytes.length; i++) {
      result = (result << 8) | bytes[i];
    }
    return result;
  }
  
  /// XOR two byte arrays
  static List<int> xorBytes(List<int> a, List<int> b) {
    if (a.length != b.length) {
      throw ArgumentError('Byte arrays must have the same length');
    }
    
    return List.generate(a.length, (i) => a[i] ^ b[i]);
  }
  
  /// Simple entropy estimation for strings
  static double estimateEntropy(String input) {
    if (input.isEmpty) return 0.0;
    
    final Map<String, int> charCount = {};
    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      charCount[char] = (charCount[char] ?? 0) + 1;
    }
    
    double entropy = 0.0;
    final length = input.length.toDouble();
    
    for (final count in charCount.values) {
      final probability = count / length;
      entropy -= probability * (log(probability) / ln2);
    }
    
    return entropy;
  }
  
  /// Check if string has sufficient entropy for security
  static bool hasSufficientEntropy(String input, {double minimumEntropy = 3.0}) {
    return estimateEntropy(input) >= minimumEntropy;
  }
}