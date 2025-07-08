# 🎛️ StreetCred Minimal - Control Panel Development Quality Assurance Standard

## 📋 Project-Specific QA Standards for Claude Code

> **MANDATORY**: Read this file at the beginning of each task to understand development standards and validation procedures.

---

## 🎯 Project Context

**StreetCred Minimal** is a production-ready Flutter trading application with real Starknet blockchain integration for ETH-USD perpetual futures trading. This QA standard ensures all development maintains production quality while preserving the dual-mode architecture (mock/real).

---

## 🏗️ Core Development Principles

### 1. Dual-Mode Integrity
- **Mock Mode Safety**: Always preserve mock mode functionality for safe development
- **Real Mode Validation**: Ensure real blockchain integration works with actual funds
- **Mode Separation**: Clear boundaries between mock and real implementations
- **Backward Compatibility**: Never break existing dual-mode functionality

### 2. Production Security Standards
- **No Secrets in Code**: Use SecureConfigService for all credentials
- **Encrypted Keystores**: Real Starknet accounts with starkli encryption
- **Input Validation**: Sanitize all external inputs (API, user, blockchain)
- **Error Containment**: Failures must not expose credentials or crash app

### 3. Blockchain Integration Quality
- **Real Transactions**: All blockchain calls use actual Starknet RPC
- **Gas Efficiency**: Optimize contract interactions for minimal fees
- **Transaction Verification**: Validate all transactions on blockchain explorer
- **Signature Security**: Cryptographic signatures for all trades

---

## 🛠️ Service Architecture & Health Monitoring

### Core Services
```yaml
Flutter Application:
  - Frontend: localhost:8080 (flutter run -d web)
  - State: Riverpod providers with real/mock modes
  - Testing: flutter test with real integration tests

Starknet Integration:
  - RPC: Starknet testnet/mainnet endpoints
  - Accounts: Encrypted starkli keystores
  - Contracts: Cairo smart contracts for XP/NFT/Paymaster
  - Deployment: Automated scripts with verification

External APIs:
  - Extended Exchange: Real ETH-USD trading API
  - WebSocket: Real-time market data streams
  - Blockchain Explorer: Transaction verification

Development Tools:
  - Cairo Compiler: scarb build for smart contracts
  - Starknet CLI: starkli for deployment and interaction
  - Flutter Tools: Hot reload and debugging
```

### Health Check Procedures
```bash
# Application Health
flutter doctor -v                    # Verify Flutter environment
flutter pub deps                     # Check dependency health
flutter test                        # Run test suite

# Blockchain Health  
starkli account list                 # Verify account access
starkli call <contract> <function>   # Test contract connectivity
scarb build --workspace              # Verify contract compilation

# API Health
curl -X GET "Extended_API_endpoint/health"  # Extended Exchange status
telnet <websocket_host> <port>             # WebSocket connectivity
```

---

## 🔧 Code Quality Standards

### Flutter Development
```dart
// State Management Pattern
class TradeProvider extends StateNotifier<TradeState> {
  // Always use Riverpod for consistency
  // Implement both mock and real modes
  // Include comprehensive error handling
  
  Future<void> executeTrade(TradeRequest request) async {
    try {
      if (AppMode.isReal) {
        return await _executeRealTrade(request);
      } else {
        return await _executeMockTrade(request);
      }
    } catch (e) {
      // Log error without exposing sensitive data
      logger.error('Trade execution failed', masked(e));
      rethrow;
    }
  }
}
```

### Cairo Smart Contracts
```cairo
// Production-Ready Contract Pattern
#[starknet::contract]
mod StreetCredXP {
    // Use explicit error handling
    // Implement access controls
    // Optimize for gas efficiency
    
    #[external(v0)]
    fn add_xp(ref self: ContractState, user: ContractAddress, amount: u256) {
        // Validate inputs
        assert(amount > 0, 'Invalid XP amount');
        
        // Update state efficiently
        let current_xp = self.user_xp.read(user);
        self.user_xp.write(user, current_xp + amount);
        
        // Emit event for transparency
        self.emit(XPGained { user, amount });
    }
}
```

### Service Integration
```dart
// Real vs Mock Service Pattern
abstract class ContractService {
  Future<String> addXP(String userAddress, int xpAmount);
}

class RealContractService implements ContractService {
  @override
  Future<String> addXP(String userAddress, int xpAmount) async {
    // Use actual starkli CLI for real blockchain interaction
    final result = await Process.run('starkli', [
      'invoke',
      contractAddress,
      'add_xp',
      userAddress,
      xpAmount.toString()
    ]);
    
    if (result.exitCode != 0) {
      throw ContractException('XP addition failed: ${result.stderr}');
    }
    
    return _extractTransactionHash(result.stdout);
  }
}
```

---

## 📊 Testing & Validation Standards

### Test Categories
1. **Unit Tests**: Individual function validation
2. **Widget Tests**: UI component behavior
3. **Integration Tests**: Real API and blockchain calls
4. **Security Tests**: Credential handling and signatures
5. **Performance Tests**: Response times and resource usage

### Test Implementation
```dart
// Real Integration Test Pattern
group('Real Starknet Integration', () {
  test('should execute real contract call', () async {
    // Skip in mock mode
    if (!AppMode.isReal) return;
    
    final service = RealStarknetService();
    final txHash = await service.addXP('0x123...', 100);
    
    // Verify transaction on blockchain
    expect(txHash, isNotEmpty);
    expect(txHash.startsWith('0x'), isTrue);
    
    // Wait for confirmation (optional)
    await service.waitForTransaction(txHash);
  });
});
```

### Validation Checklist
- [ ] Mock mode functionality preserved
- [ ] Real mode blockchain integration working
- [ ] All tests passing (unit, widget, integration)
- [ ] No secrets exposed in logs or code
- [ ] Error handling comprehensive
- [ ] Performance within targets (60fps UI, <2s API calls)
- [ ] Documentation updated

---

## 🚀 Deployment & Production Standards

### Pre-Deployment Validation
```bash
# 1. Environment Check
flutter doctor -v
flutter pub deps

# 2. Smart Contract Compilation
cd contracts
scarb build --workspace

# 3. Account and Keystore Validation
./scripts/setup_real_starknet.sh --validate

# 4. Contract Deployment Test
./scripts/real_deploy_contracts.sh --testnet

# 5. Integration Testing
flutter test test/test_real_trading.dart
flutter test test/test_cairo_integration.dart

# 6. Application Build
flutter build web --dart-define=APP_MODE=real
```

### Deployment Verification
```bash
# 1. Contract Verification
./scripts/verify_real_deployment.sh

# 2. Application Smoke Test
flutter run -d web --dart-define=APP_MODE=real --dart-define=EXTENDED_API_KEY=$API_KEY

# 3. Transaction Verification
# Execute test trade and verify on Starkscan/Voyager
```

### Production Monitoring
- **Transaction Success Rate**: >95% successful blockchain calls
- **API Response Time**: <2 seconds for Extended Exchange calls
- **Error Rate**: <1% application errors
- **Security Incidents**: Zero credential exposures

---

## 🔐 Security Requirements

### Credential Management
```dart
// Secure Configuration Pattern
class SecureConfigService {
  static String getApiKey() {
    // Never hardcode or log API keys
    const apiKey = String.fromEnvironment('EXTENDED_API_KEY');
    if (apiKey.isEmpty) {
      throw ConfigException('EXTENDED_API_KEY not configured');
    }
    return apiKey;
  }
  
  static void logSafeMessage(String message, dynamic data) {
    // Mask sensitive data in logs
    final maskedData = _maskSensitiveFields(data);
    print('$message: $maskedData');
  }
}
```

### Blockchain Security
- **Private Key Protection**: Use encrypted starkli keystores only
- **Transaction Signing**: Cryptographic signatures for all trades
- **Input Validation**: Sanitize all blockchain interaction parameters
- **Error Handling**: No sensitive data in error messages

---

## 📱 Mobile & Web Performance Standards

### Performance Targets
- **Frame Rate**: 60fps UI animations
- **Cold Start**: <3 seconds app initialization  
- **API Calls**: <2 seconds response time
- **Memory Usage**: <100MB during normal operation
- **Bundle Size**: <5MB optimized build

### Optimization Techniques
```dart
// Performance-Optimized Widget Pattern
class OptimizedTradingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // Use efficient state management
      body: ref.watch(tradingProvider).when(
        data: (data) => _buildTradingInterface(data),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => ErrorWidget(error),
      ),
    );
  }
  
  // Efficient rebuilds with specific listeners
  Widget _buildTradingInterface(TradingData data) {
    return Column(
      children: [
        // Only rebuild price when price changes
        Consumer(builder: (context, ref, child) {
          final price = ref.watch(priceProvider);
          return PriceDisplay(price: price);
        }),
        // Static widgets don't rebuild
        const TradingControls(),
      ],
    );
  }
}
```

---

## 🧪 Development Workflow

### Task Initialization Protocol
1. **Read Context Prime**: Always read `docs/CONTEXT_PRIME.md` first
2. **Verify Environment**: Check Flutter, Starknet, and API connectivity
3. **Run Tests**: Ensure current functionality works before changes
4. **Plan Changes**: Consider impact on both mock and real modes

### Development Process
```bash
# 1. Start Development Session
cd /path/to/streetcred-minimal
flutter doctor -v
flutter pub get

# 2. Check Current State
flutter test
starkli account list

# 3. Implement Changes
# Follow existing patterns
# Maintain dual-mode architecture
# Add comprehensive error handling

# 4. Validate Changes
flutter test
flutter run -d web  # Test mock mode
flutter run -d web --dart-define=APP_MODE=real  # Test real mode

# 5. Update Documentation
# Update docs/CONTEXT_PRIME.md if significant changes
```

### Code Review Standards
- [ ] **Context Awareness**: Changes align with project goals
- [ ] **Dual Mode**: Both mock and real modes functional
- [ ] **Security**: No credentials exposed, proper error handling
- [ ] **Performance**: Maintains 60fps and response time targets
- [ ] **Testing**: Comprehensive test coverage
- [ ] **Documentation**: Clear comments and updated docs

---

## 📈 Quality Metrics & Monitoring

### Development Metrics
- **Test Coverage**: >80% for core functionality
- **Build Time**: <30 seconds for Flutter web build
- **Contract Compilation**: <10 seconds for Cairo contracts
- **Deployment Time**: <5 minutes for full contract deployment

### Production Metrics
- **Uptime**: >99% application availability
- **Transaction Success**: >95% blockchain transaction success rate
- **User Experience**: <2 second trade execution time
- **Security**: Zero credential exposure incidents

### Error Monitoring
```dart
// Comprehensive Error Tracking
class ErrorMonitor {
  static void logError(String context, dynamic error, StackTrace? stack) {
    final errorData = {
      'context': context,
      'error': error.toString(),
      'timestamp': DateTime.now().toIso8601String(),
      'mode': AppMode.current,
      'stack': stack?.toString(),
    };
    
    // Log to console (development)
    print('ERROR: ${jsonEncode(errorData)}');
    
    // In production, send to monitoring service
    if (AppMode.isReal) {
      _sendToMonitoringService(errorData);
    }
  }
}
```

---

## 🎯 Success Criteria

### Feature Implementation
- **Functionality**: Feature works in both mock and real modes
- **Security**: No security vulnerabilities introduced
- **Performance**: Meets performance targets
- **Testing**: Comprehensive test coverage
- **Documentation**: Clear documentation and examples

### Production Readiness
- **Deployment**: Automated deployment scripts work
- **Monitoring**: Error tracking and performance monitoring
- **Security**: Security audit passed
- **User Experience**: Intuitive and responsive interface
- **Reliability**: Stable operation under normal load

---

## 📝 Quick Reference Commands

### Essential Development Commands
```bash
# Health Checks
flutter doctor -v
flutter test
starkli account list

# Development
flutter run -d web                                    # Mock mode
flutter run -d web --dart-define=APP_MODE=real       # Real mode
flutter build web --dart-define=APP_MODE=real        # Production build

# Smart Contracts
cd contracts && scarb build --workspace               # Compile contracts
./scripts/real_deploy_contracts.sh                   # Deploy contracts
./scripts/verify_real_deployment.sh                  # Verify deployment

# Testing
flutter test test/test_real_trading.dart             # Real integration tests
flutter test test/test_cairo_integration.dart        # Blockchain tests
```

### Critical Files to Monitor
- `lib/app_mode.dart` - Mode configuration
- `lib/services/real_starknet_service.dart` - Blockchain integration
- `lib/services/secure_config_service.dart` - Security configuration
- `contracts/*/src/*.cairo` - Smart contracts
- `docs/CONTEXT_PRIME.md` - Project context

---

## ⚠️ Critical Reminders

### Security Warnings
- **Never commit private keys** to version control
- **Always use SecureConfigService** for API keys and credentials
- **Validate all external inputs** before processing
- **Test in mock mode first** before real mode changes

### Production Warnings
- **Real mode executes actual trades** with real money
- **Default trade size is 0.01 ETH** (~$28 at current prices)
- **Monitor blockchain explorer** for transaction confirmations
- **Keep private keys secure** and use encrypted keystores

### Development Standards
- **Maintain dual-mode architecture** for all features
- **Follow existing patterns** and conventions
- **Update context documentation** for significant changes
- **Comprehensive error handling** for all external calls

---

**🎯 This control panel QA standard ensures StreetCred Minimal maintains production quality while preserving its innovative dual-mode architecture for safe development and real trading capabilities.**

---

*Last Updated: 2025-01-08*
*Version: 1.0*
*Status: Production-Ready with Real Blockchain Integration*