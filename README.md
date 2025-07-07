# StreetCred Clash - Minimal

A production-ready Flutter trading app with **real Extended API integration** and Starknet blockchain authentication.

## 🚀 Features

- **Mock Login**: Simple username-based authentication
- **Real Trading**: ETH-USD perpetual futures via Extended Exchange API
- **Starknet Integration**: Blockchain-powered trade authentication with cryptographic signatures
- **🔥 GASLESS TRANSACTIONS**: Zero gas fees via Starknet paymaster for mass adoption
- **Live Market Data**: Real-time WebSocket price feeds
- **XP System**: Gain experience points from completed trades
- **Cyberpunk UI**: Hong Kong street art aesthetic with neon glow effects
- **Dual Mode**: Mock mode for development, real mode for production trading

## 📁 Project Structure

```
lib/
├── main.dart                     # App entry point with routing
├── app_mode.dart                 # Mock/Real mode configuration
├── data/
│   ├── datasources/
│   │   └── extended_api_client.dart   # Extended Exchange API client
│   └── providers/
│       └── extended_provider.dart     # Trading service providers
├── models/
│   └── auth_state.dart          # Authentication state model
├── providers/
│   ├── auth_provider.dart       # Authentication provider
│   ├── starknet_provider.dart   # Starknet wallet management
│   ├── paymaster_provider.dart  # Paymaster state management
│   └── xp_provider.dart         # XP management provider
├── screens/
│   ├── login_screen.dart        # Mock login interface
│   ├── trading_screen.dart      # Real ETH-USD trading interface
│   └── result_screen.dart       # Trade result and order details
└── services/
    ├── starknet_service.dart    # Blockchain account & signing
    └── paymaster_service.dart   # Gasless transaction service
```

## 🚀 Getting Started

### Prerequisites
- Flutter 3.10+ with web support
- Dart 3.0+
- Extended Exchange API key (optional for real mode)

### Installation

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Run in Mock Mode (Default)**
   ```bash
   flutter run -d web
   ```
   *Safe development mode with simulated trading*

3. **Run in Real Mode**
   ```bash
   flutter run -d web --dart-define=APP_MODE=real --dart-define=EXTENDED_API_KEY=your_api_key
   ```
   *Production mode with real Extended API calls*

4. **Build for Production**
   ```bash
   flutter build web --dart-define=APP_MODE=real --dart-define=EXTENDED_API_KEY=your_api_key
   ```

## 🎮 Usage

### Trading Flow
1. **Login**: Enter any username to access the trading interface
2. **Wallet Status**: Check Starknet wallet connection (auto-connected in mock mode)
3. **Market Data**: View real-time ETH-USD price with 24h stats
4. **Execute Trade**: Choose LONG (up) or SHORT (down) for ETH-USD
5. **View Results**: See order details, P&L, and XP gained

### App Modes

#### 🟡 Mock Mode (Development)
- **Purpose**: Safe testing and development
- **Trading**: Simulated with mock signatures
- **Data**: Live market data with mock order execution
- **Wallet**: Auto-generated test account
- **Risk**: Zero - no real trades executed

#### 🔴 Real Mode (Production)
- **Purpose**: Actual trading on Extended Exchange
- **Trading**: Real API calls with Starknet signatures
- **Data**: Live market data and real order execution
- **Wallet**: Requires valid Starknet account
- **Risk**: Real money - actual trades executed

## 🔧 Key Dependencies

### Core Framework
- `flutter`: Cross-platform UI framework
- `flutter_riverpod`: Reactive state management
- `go_router`: Declarative routing and navigation

### Blockchain & Trading
- `starknet`: Starknet blockchain integration
- `starknet_provider`: Starknet wallet provider
- `pointycastle`: Cryptographic operations
- `crypto`: Hash functions and signatures
- `http`: REST API client for Extended Exchange
- `web_socket_channel`: Real-time market data streaming
- `dio`: HTTP client for paymaster API calls

### Utilities
- `convert`: Data conversion utilities

## 🏗️ Architecture

### State Management
- **Riverpod**: Reactive state management with providers
- **StarknetProvider**: Blockchain wallet connection state
- **ExtendedProvider**: Trading service and market data
- **PaymasterProvider**: Gasless transaction state management
- **AuthProvider**: User authentication state

### Data Flow
```
UI Layer (Screens) 
    ↓
Providers (Riverpod)
    ↓
Services (Starknet + Extended API + Paymaster)
    ↓
External APIs (Extended Exchange + WebSocket + Starknet RPC)
```

### Trading Pipeline
1. **Market Data**: WebSocket → ExtendedProvider → Trading Screen
2. **Gasless Trade**: UI → PaymasterService (sponsorship) → StarknetService (sign) → Extended API
3. **Order Response**: Extended API → Result Screen → XP Update

### Security
- **Starknet Signatures**: Cryptographic proof of trade authorization
- **Private Key Management**: Secure key generation and storage
- **API Authentication**: Extended Exchange signature verification
- **Error Handling**: Comprehensive failure recovery

## 🔐 Security Features

- **No Private Key Exposure**: Keys generated and stored locally
- **Signature-Based Auth**: Cryptographic trade authorization  
- **Input Validation**: All API inputs sanitized and validated
- **Error Isolation**: Failures don't compromise wallet security
- **Mode Separation**: Mock mode prevents accidental real trades

## 🚨 Important Notes

⚠️ **Real Mode Warning**: When `APP_MODE=real`, this app executes actual trades with real money on the Extended Exchange. Only use with funds you can afford to lose.

🔒 **Private Key Security**: This implementation generates test private keys for demonstration. In production, integrate with secure wallet providers (ArgentX, Braavos, etc.).

📊 **Trade Size**: Default trade size is 0.01 ETH (~$28 at current prices) for testing. Adjust quantity in `trading_screen.dart` for production use.

## 💰 Paymaster Deployment

The project includes a paymaster contract for gasless transactions:

### Deploy Paymaster Contract
```bash
# Deploy to testnet
python scripts/deploy_paymaster.py --network testnet

# Deploy to mainnet with custom owner
python scripts/deploy_paymaster.py --network mainnet --owner 0x123... --fund 10.0
```

### Contract Structure
```
contracts/paymaster/
├── src/
│   ├── paymaster.cairo      # Main paymaster contract
│   └── lib.cairo           # Library functions
├── Scarb.toml              # Cairo project configuration
└── deployment_*.json       # Deployment configurations
```

## 🎯 Production Readiness

This implementation demonstrates a **complete trading pipeline** with:
- ✅ Real Extended API integration with authentication
- ✅ Starknet blockchain signature verification  
- ✅ **Gasless transactions via paymaster for mass adoption**
- ✅ Live market data streaming
- ✅ Comprehensive error handling
- ✅ Production-ready architecture
- ✅ Security best practices

Perfect for extending into a full-featured trading application or integrating into larger DeFi platforms.