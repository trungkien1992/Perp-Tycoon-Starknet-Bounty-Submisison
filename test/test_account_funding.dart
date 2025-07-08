import 'dart:async';
import 'lib/services/starknet_service.dart';
import 'lib/data/datasources/extended_api_client.dart';

/// Test script to check Extended API account funding status
void main() async {
  print('💰 Testing Extended API Account Funding');
  print('=======================================');
  
  try {
    // Test 1: Connect to Extended API with real credentials
    print('\n1. Connecting to Extended API...');
    final apiClient = ExtendedApiClient.withRealCredentials();
    print('✅ Extended API client created');
    print('🔑 API Key: f1894fcb909e3619449c01a1f16ddde3');
    print('🏦 Vault ID: 101420');
    
    // Test 2: Check account balance
    print('\n2. Checking Account Balance...');
    try {
      final balance = await apiClient.getAccountBalance();
      print('✅ Account balance retrieved successfully');
      print('💰 Total Balance: ${balance.totalBalance} ${balance.currency}');
      print('💳 Available Balance: ${balance.availableBalance} ${balance.currency}');
      print('🔒 Margin Used: ${balance.marginUsed} ${balance.currency}');
      print('📊 Unrealized P&L: ${balance.unrealizedPnl} ${balance.currency}');
      print('🎯 Trading Eligible: ${balance.isEligibleForTrading}');
      print('💸 Can Trade: ${balance.canTrade}');
      print('🆓 Free Margin: ${balance.freeMargin} ${balance.currency}');
      
      if (balance.canTrade) {
        print('\n🎉 Account is FUNDED and ready for trading!');
      } else {
        print('\n⚠️  Account needs funding or verification:');
        if (!balance.hasSufficientFunds) {
          print('   • Insufficient funds (Available: ${balance.availableBalance})');
        }
        if (!balance.isEligibleForTrading) {
          print('   • Account not eligible for trading (verification needed?)');
        }
      }
      
    } catch (e) {
      print('❌ Failed to get account balance: $e');
      if (e.toString().contains('401') || e.toString().contains('403')) {
        print('🔐 Authentication issue - API key may be invalid or expired');
      } else if (e.toString().contains('404')) {
        print('🔍 Endpoint not found - API may not be accessible or vault doesn\'t exist');
      } else if (e.toString().contains('429')) {
        print('⏱️  Rate limited - too many requests');
      } else {
        print('🌐 Network or server error');
      }
    }
    
    // Test 3: Check trading eligibility
    print('\n3. Checking Trading Eligibility...');
    try {
      final canTrade = await apiClient.checkTradingEligibility();
      if (canTrade) {
        print('✅ Account is eligible for trading');
      } else {
        print('❌ Account is not eligible for trading');
      }
    } catch (e) {
      print('⚠️  Could not check trading eligibility: $e');
    }
    
    // Test 4: Check current positions
    print('\n4. Checking Current Positions...');
    try {
      final positions = await apiClient.getPositions();
      if (positions.isEmpty) {
        print('📭 No open positions');
      } else {
        print('📊 Found ${positions.length} open position(s):');
        for (final position in positions) {
          print('   • ${position.market} ${position.side} ${position.size} @ ${position.entryPrice}');
          print('     P&L: ${position.unrealizedPnl} (${position.pnlPercent.toStringAsFixed(2)}%)');
        }
      }
    } catch (e) {
      print('⚠️  Could not fetch positions: $e');
    }
    
    // Test 5: Summary and recommendations
    print('\n📋 FUNDING STATUS SUMMARY');
    print('========================');
    print('🔑 API Key: f1894fcb909e3619449c01a1f16ddde3');
    print('🏦 Vault: 101420');
    print('🔗 Starknet Account: 0xc3e8053d6030c85f62c73ba1b8391563a4beadaa');
    
    try {
      final balance = await apiClient.getAccountBalance();
      if (balance.canTrade) {
        print('✅ READY FOR REAL TRADING');
        print('💰 Available funds: ${balance.availableBalance} ${balance.currency}');
      } else {
        print('❌ ACCOUNT NEEDS FUNDING');
        print('📝 Required actions:');
        if (!balance.hasSufficientFunds) {
          print('   1. Deposit funds to vault 101420');
        }
        if (!balance.isEligibleForTrading) {
          print('   2. Complete account verification');
        }
        print('   3. Ensure API key has trading permissions');
      }
    } catch (e) {
      print('❓ UNKNOWN - Could not determine funding status');
      print('🔍 Check API connectivity and credentials');
    }
    
  } catch (e) {
    print('❌ Test failed: $e');
  }
}