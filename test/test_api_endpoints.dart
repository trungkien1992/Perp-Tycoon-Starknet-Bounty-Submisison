import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Test different Extended API endpoints to find the correct one
void main() async {
  print('🔍 TESTING EXTENDED API ENDPOINTS');
  print('=================================');
  
  final apiKey = 'f1894fcb909e3619449c01a1f16ddde3';
  final vaultId = '101420';
  
  // List of possible Extended API base URLs
  final possibleUrls = [
    'https://api.extended.exchange',
    'https://extended.exchange/api',
    'https://api.extended.finance',
    'https://extended.finance/api',
    'https://api.extended.trade',
    'https://extended.trade/api',
    'https://testnet.extended.exchange',
    'https://sandbox.extended.exchange',
    'https://staging.extended.exchange',
    'https://demo.extended.exchange',
  ];
  
  final client = http.Client();
  
  for (final baseUrl in possibleUrls) {
    print('\\n🌐 Testing: $baseUrl');
    
    final headers = {
      'Content-Type': 'application/json',
      'X-Api-Key': apiKey,
      'X-Vault-Id': vaultId,
      'User-Agent': 'StreetCredClash/1.0.0',
    };
    
    // Test common endpoints
    final endpoints = [
      '/v1/markets',
      '/v1/account/balance',
      '/v1/health',
      '/health',
      '/status',
      '/api/v1/markets',
      '/api/v1/account/balance',
    ];
    
    bool foundWorking = false;
    
    for (final endpoint in endpoints) {
      try {
        final response = await client.get(
          Uri.parse('$baseUrl$endpoint'),
          headers: headers,
        ).timeout(Duration(seconds: 5));
        
        if (response.statusCode != 404) {
          print('✅ $endpoint -> ${response.statusCode}');
          if (response.statusCode == 200) {
            try {
              final data = json.decode(response.body);
              print('   📊 Response: ${data.toString().substring(0, 100)}...');
            } catch (e) {
              print('   📊 Response: ${response.body.substring(0, 100)}...');
            }
          } else {
            print('   📊 Response: ${response.body}');
          }
          foundWorking = true;
          break;
        }
      } catch (e) {
        // Timeout or connection error, continue
      }
    }
    
    if (!foundWorking) {
      print('❌ No working endpoints found');
    }
  }
  
  client.close();
  
  print('\\n📋 ENDPOINT DISCOVERY COMPLETE');
  print('===============================');
  print('If no working endpoints found:');
  print('• Extended API may use different domain');
  print('• API key may need activation');
  print('• Whitelist may be required');
  print('• Contact Extended support for correct endpoint');
}