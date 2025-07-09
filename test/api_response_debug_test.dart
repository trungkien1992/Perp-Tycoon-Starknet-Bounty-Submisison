import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import '../lib/data/datasources/extended_api_client.dart';
import '../lib/services/secure_config_service.dart';

void main() {
  test('Debug API response structure', () async {
    // Initialize secure configuration
    await SecureConfigService.initialize();
    
    // Create Extended API client with real credentials
    final apiClient = ExtendedApiClient.withRealCredentials();
    
    // Make raw request to see response structure
    final response = await apiClient._bypassGet('/info/markets');
    
    print('🔍 Response Status: ${response.statusCode}');
    print('🔍 Response Headers: ${response.headers}');
    print('🔍 Response Body: ${response.body}');
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('🔍 Parsed Data Type: ${data.runtimeType}');
      print('🔍 Parsed Data: $data');
      
      if (data is Map) {
        print('🔍 Map Keys: ${data.keys.toList()}');
        if (data.containsKey('markets')) {
          print('🔍 Markets Type: ${data['markets'].runtimeType}');
          print('🔍 Markets Data: ${data['markets']}');
        }
      }
    }
    
    apiClient.dispose();
  });
}