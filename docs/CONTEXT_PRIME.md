# 📋 StreetCred Minimal - Session Context Prime

> **Purpose**: This file maintains the complete project context for Claude Code sessions. Update this file before starting any new tasks.

## 🎯 Project Overview

**StreetCred Minimal** is a production-ready Flutter trading application with **Starknet blockchain integration** for ETH-USD perpetual futures trading using Extended API ( https://api.docs.extended.exchange/)

### **Core Identity**
- **Type**: Flutter web application with Cairo smart contracts
- **Purpose**: Cryptocurrency trading with blockchain authentication
- **Blockchain**: Starknet - Ethereum Rollup (Cairo smart contracts)
- **Trading**: ETH-USD perpetual futures via Extended Exchange API
- **State**: Production-ready with blockchain deployment capability

## 🏗️ Architecture Summary

### **Frontend (Flutter)**
```
lib/
├── main.dart                     # App entry with routing
├── app_mode.dart                 # Mock/Real mode configuration
├── screens/                      # UI screens (login, trading, result)
├── providers/                    # State management (auth, starknet, xp)
├── services/                     # Core business logic
└── models/                       # Data structures
```

### **Blockchain (Cairo Smart Contracts)**
```
contracts/
├── streetcred_xp/               # XP tracking and leaderboard system
├── street_art_nft/             # Achievement-based NFT minting
├── streetcred_paymaster/        # Gasless transaction sponsorship
└── paymaster/                   # Additional paymaster implementation
```

### **Deployment Infrastructure**
```
scripts/
├── setup_real_starknet.sh       # Account setup and keystore creation
├── real_deploy_contracts.sh     # Contract deployment automation
├── real_deploy_contracts.py     # Python deployment script
├── verify_real_deployment.sh    # Blockchain verification
└── calculate_selectors.py       # Function selector utilities
```

## 🔧 Key Technologies

### **Frontend Stack**
- **Flutter 3.10+** with web support
- **Riverpod** for state management
- **GoRouter** for navigation
- **Material Design** with cyberpunk theme

### **Blockchain Stack**  
- **Starknet** L2 blockchain
- **Cairo** smart contract language
- **starkli** CLI for deployment
- **scarb** Cairo compiler

### **Trading Integration**
- **Extended Exchange API** for real ETH-USD trading
- **WebSocket** real-time market data
- **Starknet signatures** for trade authentication

## 🚀 Deployment Status

### **Real Starknet Integration: ✅ IMPLEMENTED**

**Infrastructure Created:**
- ✅ Real starkli keystore and account setup
- ✅ Actual Cairo contract compilation and deployment
- ✅ Real blockchain transaction signing
- ✅ Starknet testnet deployment scripts
- ✅ Blockchain explorer verification

**Key Services:**
- `RealStarknetService` - Uses actual starkli CLI commands
- `ContractService` - Routes to real blockchain in real mode
- `SecureConfigService` - Manages encrypted credentials

**Verification:**
- Contracts deployable to Starknet testnet
- Transactions visible on Starkscan/Voyager
- Real gas fees and blockchain interactions

## 🎮 Application Flow

### **Dual Mode System**
- **Mock Mode** (`APP_MODE=mock`): Safe development with simulated data
- **Real Mode** (`APP_MODE=real`): Production trading with actual funds

### **Trading Pipeline**
```
1. User Login → Authentication
2. Market Data → WebSocket real-time ETH-USD prices  
3. Trade Execution → Starknet signature + Extended API call
4. XP Gain → Real contract write to blockchain
5. Results → Transaction hash + P&L display
6. Achievements → NFT minting for milestones
```

### **Blockchain Integration**
```
Flutter App → XPNotifier.gainXP() → ContractService.addXPToContract() 
→ RealStarknetService → starkli invoke → Starknet RPC 
→ Contract execution → Transaction hash → Explorer verification
```

## 📁 Essential Files

### **Core Application**
- `lib/main.dart` - App entry point with routing
- `lib/app_mode.dart` - Mock/Real mode configuration
- `lib/services/real_starknet_service.dart` - Real blockchain integration
- `lib/services/contract_service.dart` - Contract interaction layer
- `lib/providers/xp_provider.dart` - XP state management with contract writes

### **Smart Contracts** 
- `contracts/streetcred_xp/src/xp_system.cairo` - XP tracking contract
- `contracts/street_art_nft/src/street_art.cairo` - Achievement NFT contract
- `contracts/streetcred_paymaster/src/paymaster.cairo` - Gasless transactions

### **Deployment Scripts**
- `scripts/setup_real_starknet.sh` - Initial account setup
- `scripts/real_deploy_contracts.sh` - Contract deployment
- `scripts/verify_real_deployment.sh` - Deployment verification

### **Documentation**
- `README.md` - Main project documentation
- `REAL_STARKNET_DEPLOYMENT.md` - Complete deployment guide
- `CAIRO_CONTRACTS_README.md` - Smart contract documentation
- `SECURITY.md` - Security guidelines

### **Testing**
- `test_real_trading.dart` - Real trading validation
- `test_cairo_integration.dart` - Blockchain contract testing
- `test_secure_config.dart` - Configuration security testing

## 🔐 Security Implementation

### **Credential Management**
- ✅ **Encrypted keystore** with starkli
- ✅ **Environment-based configuration** (no hardcoded secrets)
- ✅ **Secure config service** with masked logging
- ✅ **Real cryptographic signatures** for all transactions

### **Trading Security**
- ✅ **Starknet authentication** for all trades
- ✅ **Input validation** and sanitization
- ✅ **Error handling** with graceful degradation
- ✅ **Mode separation** (mock vs real)

## 📊 Current Implementation Status

### **✅ Completed Components**
- Real Starknet account setup and deployment
- Cairo smart contract compilation and deployment
- Real blockchain transaction signing and execution
- Complete Flutter application with trading functionality
- WebSocket real-time market data integration
- Extended Exchange API integration for trading
- Comprehensive testing suite
- Production deployment automation
- Security implementation and validation
- Documentation and deployment guides

### **🔄 Ready for Production**
- Testnet deployment verified and working
- Real blockchain transactions confirmed
- Security audit completed
- Performance optimization implemented
- Error handling and monitoring in place

## 🎯 Development Guidelines

### **Code Conventions**
- **Flutter**: Material Design with dark cyberpunk theme
- **Cairo**: Production-ready contract patterns
- **State Management**: Riverpod with providers
- **Error Handling**: Comprehensive try-catch with user feedback
- **Logging**: Detailed console output for debugging

### **Testing Standards**
- **Integration Tests**: Full user flow validation
- **Contract Tests**: Blockchain interaction verification
- **Security Tests**: Credential and signature validation
- **Real Mode Tests**: Actual API and blockchain calls

### **Deployment Process**
1. Run account setup: `./scripts/setup_real_starknet.sh`
2. Fund account with testnet ETH from faucet
3. Deploy contracts: `./scripts/real_deploy_contracts.sh`
4. Verify deployment: `./scripts/verify_real_deployment.sh`
5. Test application: `flutter run -d web --dart-define=APP_MODE=real`

## 🚨 Important Notes

### **Real Money Warning**
- In `APP_MODE=real`, the application executes actual trades with real funds
- Default trade size is 0.01 ETH (~$28) for testing
- Users must fund Extended Exchange account with real USDC
- All transactions consume real gas fees on Starknet

### **Development Safety**
- Always test in mock mode first
- Verify all configurations before real mode
- Monitor blockchain explorer for transaction confirmations
- Keep private keys secure and never commit to repository

### **Technical Standards**
- Follow existing patterns for new features
- Maintain separation between mock and real implementations
- Document all API integrations and contract interactions
- Implement comprehensive error handling for all external calls

---

## 📝 Last Updated

**Date**: 2025-01-08
**Session**: Real Starknet Integration Implementation
**Status**: Production-ready with real blockchain deployment
**Next Focus**: Production deployment and user testing

---

> **⚠️ CRITICAL**: Always update this file when making significant changes to project architecture, adding new features, or changing deployment processes. This ensures continuity between Claude Code sessions.