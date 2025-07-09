import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import '../lib/data/datasources/extended_api_client.dart';
import '../lib/services/secure_config_service.dart';
import '../lib/services/cloudfront_bypass_service.dart';

void main() {
  test('Debug account balance response', () async {
    await SecureConfigService.initialize();
    final apiClient = ExtendedApiClient.withRealCredentials();
    
    print('🔍 DEBUGGING ACCOUNT BALANCE RESPONSE');
    print('====================================');
    
    // Create a separate client to make raw request
    final rawClient = ExtendedApiClient.withRealCredentials();
    
    // Use the CloudFront bypass service directly
    final headers = {
      'Content-Type': 'application/json',
      'X-Api-Key': 'f1894fcb909e3619449c01a1f16ddde3',
      'X-Vault-Id': '101420',
      'User-Agent': 'StreetCredClash/1.0.0',
    };
    
    final response = await CloudFrontBypassService.bypassGet(
      Uri.parse('https://api.extended.exchange/api/v1/user/balance'),
      headers: headers,
    );
    
    print('📊 Response Status: ${response.statusCode}');
    print('📊 Response Headers: ${response.headers}');
    print('📊 Raw Response Body:');
    print(response.body);
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('\n🔍 Parsed Response Type: ${data.runtimeType}');
      print('🔍 Parsed Response Data:');
      print(json.encode(data));
      
      if (data is Map) {
        print('\n🔍 Response Structure:');
        data.forEach((key, value) {
          print('   $key: ${value.runtimeType} = $value');
        });
        
        if (data.containsKey('data')) {
          print('\n🔍 Data Section:');
          final dataSection = data['data'];
          if (dataSection is Map) {
            dataSection.forEach((key, value) {
              print('   data.$key: ${value.runtimeType} = $value');
            });
          }
        }
      }
    }
    
    // Test current parsing
    print('\n💰 Testing Current Balance Parsing:');
    try {
      final balance = await apiClient.getAccountBalance();
      print('✅ Parsed Balance:');
      print('   💵 Total: ${balance.totalBalance} ${balance.currency}');
      print('   💸 Available: ${balance.availableBalance} ${balance.currency}');
      print('   📊 Margin Used: ${balance.marginUsed} ${balance.currency}');
      print('   🎯 Can Trade: ${balance.canTrade}');
    } catch (e) {
      print('❌ Balance parsing failed: $e');
    }
    
    apiClient.dispose();
  });
}