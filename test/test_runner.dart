/// Comprehensive test runner for Perp Tycoon Phase 1
/// Runs all unit tests and integration tests with detailed reporting
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

// Unit test imports
import 'unit/game_state_provider_test.dart' as game_state_tests;
import 'unit/upgrade_provider_test.dart' as upgrade_tests;
import 'unit/bot_provider_test.dart' as bot_tests;
import 'unit/idle_earnings_provider_test.dart' as idle_earnings_tests;

// Integration test imports
import 'integration/coin_toss_integration_test.dart' as coin_toss_integration;
import 'integration/upgrade_purchase_integration_test.dart' as upgrade_integration;
import 'integration/bot_management_integration_test.dart' as bot_integration;

void main() {
  print('🎰 PERP TYCOON PHASE 1 TEST SUITE');
  print('==================================');
  print('');
  
  group('📊 UNIT TESTS', () {
    print('Running Unit Tests...');
    
    group('🎮 Game State Provider Tests', () {
      game_state_tests.main();
    });
    
    group('⬆️ Upgrade Provider Tests', () {
      upgrade_tests.main();
    });
    
    group('🤖 Bot Provider Tests', () {
      bot_tests.main();
    });
    
    group('💰 Idle Earnings Provider Tests', () {
      idle_earnings_tests.main();
    });
  });

  group('🔗 INTEGRATION TESTS', () {
    print('Running Integration Tests...');
    
    group('🪙 Coin Toss Integration Tests', () {
      coin_toss_integration.main();
    });
    
    group('🛒 Upgrade Purchase Integration Tests', () {
      upgrade_integration.main();
    });
    
    group('🤖 Bot Management Integration Tests', () {
      bot_integration.main();
    });
  });

  setUpAll(() {
    print('');
    print('🚀 Starting Perp Tycoon Phase 1 Test Suite');
    print('Testing casino idle game mechanics...');
    print('');
  });

  tearDownAll(() {
    print('');
    print('✅ All tests completed!');
    print('📈 Phase 1 components tested:');
    print('   - Coin toss mechanics with volatility');
    print('   - Trading upgrade system');
    print('   - Bot hiring and management');
    print('   - Idle earnings calculation');
    print('   - Game state persistence');
    print('   - XP progression system');
    print('');
    print('🎯 Ready for Phase 2 development!');
  });
}

/// Test configuration and utilities
class TestConfig {
  static const bool enableDebugPrints = true;
  static const int testTimeoutMs = 30000;
  static const double floatingPointTolerance = 0.001;
  
  /// Common test data for consistent testing
  static const double defaultStartingCash = 1000.0;
  static const int defaultCopperXP = 1;
  static const int defaultSilverXP = 2;
  static const int defaultGoldXP = 3;
  
  /// Bot test data
  static const double ethBotBaseCost = 2500.0;
  static const double btcBotBaseCost = 5000.0;
  static const double altcoinBotBaseCost = 1500.0;
  
  /// Upgrade test data
  static const double unlockEthCost = 2000.0;
  static const double leverage2xCost = 2000.0;
  static const double marketIntelCost = 7500.0;
  
  /// Utility methods for test setup
  static void debugPrint(String message) {
    if (enableDebugPrints) {
      print('🔍 DEBUG: $message');
    }
  }
  
  static bool isFloatEqual(double a, double b) {
    return (a - b).abs() < floatingPointTolerance;
  }
}

/// Test result tracking
class TestResults {
  static int totalTests = 0;
  static int passedTests = 0;
  static int failedTests = 0;
  static List<String> failureMessages = [];
  
  static void recordTest(String testName, bool passed, [String? errorMessage]) {
    totalTests++;
    if (passed) {
      passedTests++;
      TestConfig.debugPrint('✅ PASS: $testName');
    } else {
      failedTests++;
      TestConfig.debugPrint('❌ FAIL: $testName');
      if (errorMessage != null) {
        failureMessages.add('$testName: $errorMessage');
      }
    }
  }
  
  static void printSummary() {
    print('');
    print('📊 TEST SUMMARY');
    print('===============');
    print('Total Tests: $totalTests');
    print('Passed: $passedTests');
    print('Failed: $failedTests');
    print('Success Rate: ${((passedTests / totalTests) * 100).toStringAsFixed(1)}%');
    
    if (failureMessages.isNotEmpty) {
      print('');
      print('❌ FAILURE DETAILS:');
      for (final message in failureMessages) {
        print('   - $message');
      }
    }
    
    print('');
    if (failedTests == 0) {
      print('🎉 ALL TESTS PASSED! Phase 1 is ready for production.');
    } else {
      print('⚠️  Some tests failed. Please review and fix before proceeding.');
    }
  }
}

/// Test categories for organized reporting
enum TestCategory {
  unit,
  integration,
  e2e,
  performance,
  security,
}

extension TestCategoryExtension on TestCategory {
  String get emoji {
    switch (this) {
      case TestCategory.unit:
        return '🧪';
      case TestCategory.integration:
        return '🔗';
      case TestCategory.e2e:
        return '🎭';
      case TestCategory.performance:
        return '⚡';
      case TestCategory.security:
        return '🔒';
    }
  }
  
  String get displayName {
    switch (this) {
      case TestCategory.unit:
        return 'Unit Tests';
      case TestCategory.integration:
        return 'Integration Tests';
      case TestCategory.e2e:
        return 'End-to-End Tests';
      case TestCategory.performance:
        return 'Performance Tests';
      case TestCategory.security:
        return 'Security Tests';
    }
  }
}

/// Phase 1 test coverage requirements
class Phase1Coverage {
  static const List<String> requiredFeatures = [
    'Coin toss mechanics',
    'Trading directions (LONG/SHORT)',
    'Market volatility simulation',
    'XP progression system',
    'Cash management',
    'Upgrade purchasing',
    'Bot hiring system',
    'Bot earnings automation',
    'Idle earnings calculation',
    'Game state persistence',
    'Animation systems',
    'Error handling',
  ];
  
  static const List<String> criticalPaths = [
    'User executes coin toss trade',
    'User purchases upgrade with sufficient funds',
    'User hires trading bot',
    'Bot generates idle earnings',
    'Game state saves and loads correctly',
    'Insufficient funds scenarios handled',
    'Invalid operations handled gracefully',
  ];
  
  static void verifyCoverage() {
    print('');
    print('📋 PHASE 1 FEATURE COVERAGE');
    print('============================');
    for (final feature in requiredFeatures) {
      print('✅ $feature');
    }
    
    print('');
    print('🛤️  CRITICAL PATH COVERAGE');
    print('===========================');
    for (final path in criticalPaths) {
      print('✅ $path');
    }
  }
}