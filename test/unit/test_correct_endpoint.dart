import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Test the working Extended API endpoint we discovered
void main() async {
  print('🔍 TESTING WORKING EXTENDED API ENDPOINT');
  print('========================================');
  
  final apiKey = 'f1894fcb909e3619449c01a1f16ddde3';
  final vaultId = '101420';
  final baseUrl = 'https://extended.exchange/api';
  
  final client = http.Client();
  
  final headers = {
    'Content-Type': 'application/json',
    'X-Api-Key': apiKey,
    'X-Vault-Id': vaultId,
    'User-Agent': 'StreetCredClash/1.0.0',
  };
  
  // Test health endpoint first
  print('1. 🏥 Testing Health Endpoint...');
  try {
    final response = await client.get(
      Uri.parse('$baseUrl/health'),
      headers: headers,
    );
    print('✅ Health check: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('📊 Response: ${response.body}');
    }
  } catch (e) {
    print('❌ Health check failed: $e');
  }
  
  // Test different API structures
  final apiStructures = [
    // Standard REST API paths
    '/v1/account/balance',
    '/v1/accounts/balance',
    '/v1/user/balance',
    '/v1/wallet/balance',
    '/account/balance',
    '/accounts/balance',
    '/user/balance',
    '/wallet/balance',
    '/balance',
    
    // Trading specific paths
    '/v1/trading/account',
    '/v1/trading/balance',
    '/trading/account',
    '/trading/balance',
    
    // Market data paths
    '/v1/markets',
    '/v1/market/ETH-USD',
    '/markets',
    '/market/ETH-USD',
    
    // Position paths
    '/v1/positions',
    '/v1/position',
    '/positions',
    '/position',
    
    // Order paths
    '/v1/orders',
    '/v1/order',
    '/orders',
    '/order',
  ];
  
  print('\\n2. 🔍 Testing API Structures...');
  
  for (final path in apiStructures) {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl$path'),
        headers: headers,
      ).timeout(Duration(seconds: 3));
      
      if (response.statusCode != 404) {
        print('✅ $path -> ${response.statusCode}');
        if (response.statusCode == 200) {
          try {
            final data = json.decode(response.body);
            print('   📊 Data: ${data.toString()}');
          } catch (e) {
            print('   📊 Response: ${response.body}');
          }
        } else if (response.statusCode == 401) {
          print('   🔐 Authentication required');
        } else if (response.statusCode == 403) {
          print('   🚫 Forbidden - check permissions');
        } else {
          print('   📊 Response: ${response.body}');
        }
      }
    } catch (e) {
      // Skip timeouts and errors
    }
  }
  
  // Test account-specific paths with vault ID
  print('\\n3. 🏦 Testing Vault-Specific Paths...');
  final vaultPaths = [
    '/v1/vault/$vaultId/balance',
    '/v1/vault/$vaultId/account',
    '/v1/vault/$vaultId/positions',
    '/vault/$vaultId/balance',
    '/vault/$vaultId/account',
    '/vault/$vaultId/positions',
  ];
  
  for (final path in vaultPaths) {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl$path'),
        headers: headers,
      ).timeout(Duration(seconds: 3));
      
      if (response.statusCode != 404) {
        print('✅ $path -> ${response.statusCode}');
        if (response.statusCode == 200) {
          try {
            final data = json.decode(response.body);
            print('   💰 Balance Data: ${data.toString()}');
          } catch (e) {
            print('   📊 Response: ${response.body}');
          }
        } else {
          print('   📊 Status: ${response.statusCode} - ${response.body}');
        }
      }
    } catch (e) {
      // Skip timeouts and errors
    }
  }
  
  client.close();
  
  print('\\n📋 ENDPOINT TESTING COMPLETE');
  print('============================');
  print('💰 Account has 9.96 USDC deposited');
  print('🔑 Using API Key: f1894fcb909e3619449c01a1f16ddde3');
  print('🏦 Testing Vault: 101420');
}