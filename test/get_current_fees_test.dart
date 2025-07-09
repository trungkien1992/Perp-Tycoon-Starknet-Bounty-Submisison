import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import '../lib/services/secure_config_service.dart';
import '../lib/services/cloudfront_bypass_service.dart';

void main() {
  test('Get Current Trading Fees from Extended API', () async {
    await SecureConfigService.initialize();
    
    final headers = {
      'Content-Type': 'application/json',
      'X-Api-Key': 'f1894fcb909e3619449c01a1f16ddde3',
      'User-Agent': 'StreetCredClash/1.0.0',
    };
    
    print('🔍 GETTING CURRENT TRADING FEES');
    print('===============================');
    
    try {
      // Get fees for BTC-USD market
      print('📊 Fetching fees for BTC-USD market...');
      final feesResponse = await CloudFrontBypassService.bypassGet(
        Uri.parse('https://api.extended.exchange/api/v1/user/fees?market=BTC-USD'),
        headers: headers,
      );
      
      print('Response Status: ${feesResponse.statusCode}');
      print('Response Body: ${feesResponse.body}');
      
      if (feesResponse.statusCode == 200) {
        final feesData = json.decode(feesResponse.body);
        
        if (feesData['status'] == 'OK' && feesData['data'] != null) {
          final fees = feesData['data'][0]; // First market
          
          print('\n💰 CURRENT FEES for BTC-USD:');
          print('============================');
          print('Market: ${fees['market']}');
          print('Maker Fee Rate: ${fees['makerFeeRate']} (${(double.parse(fees['makerFeeRate']) * 100).toStringAsFixed(3)}%)');
          print('Taker Fee Rate: ${fees['takerFeeRate']} (${(double.parse(fees['takerFeeRate']) * 100).toStringAsFixed(3)}%)');
          
          print('\n📋 Fee Usage Guide:');
          print('For Post-only orders: use "${fees['makerFeeRate']}"');
          print('For all other orders: use "${fees['takerFeeRate']}"');
          
          // Try all markets
          print('\n📊 Getting fees for all markets...');
          final allFeesResponse = await CloudFrontBypassService.bypassGet(
            Uri.parse('https://api.extended.exchange/api/v1/user/fees'),
            headers: headers,
          );
          
          if (allFeesResponse.statusCode == 200) {
            final allFeesData = json.decode(allFeesResponse.body);
            if (allFeesData['status'] == 'OK') {
              print('\n💰 ALL MARKET FEES:');
              print('==================');
              
              final allFees = allFeesData['data'] as List;
              for (int i = 0; i < allFees.length && i < 5; i++) {
                final marketFee = allFees[i];
                print('${i + 1}. ${marketFee['market']}: Maker ${marketFee['makerFeeRate']}, Taker ${marketFee['takerFeeRate']}');
              }
              print('... and ${allFees.length - 5} more markets');
            }
          }
          
        } else {
          print('❌ Unexpected fees response format');
        }
      } else {
        print('❌ Failed to get fees: ${feesResponse.statusCode}');
      }
      
    } catch (e) {
      print('❌ Error getting fees: $e');
    }
  });
}