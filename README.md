# StreetCred Clash - Minimal

A bare-bones Flutter trading app with essential functionality only.

## Features

- **Mock Login**: Simple username-based authentication
- **Single Asset Trading**: ETH-USDC long/short trading interface  
- **XP System**: Gain experience points from completed trades
- **Clean UI**: Cyberpunk-themed minimal interface

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── auth_state.dart      # Authentication state model
├── providers/
│   ├── auth_provider.dart   # Authentication provider
│   └── xp_provider.dart     # XP management provider
└── screens/
    ├── login_screen.dart    # Mock login interface
    ├── trading_screen.dart  # ETH-USDC trading interface
    └── result_screen.dart   # Trade result and XP display
```

## Getting Started

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the App**
   ```bash
   flutter run -d web
   ```

3. **Build for Web**
   ```bash
   flutter build web
   ```

## Usage

1. **Login**: Enter any username to access the trading interface
2. **Trade**: Choose LONG (up) or SHORT (down) for ETH-USDC
3. **Results**: View P&L and XP gained from the trade
4. **Repeat**: Continue trading to accumulate XP

## Key Dependencies

- `flutter_riverpod`: State management
- `go_router`: Navigation and routing
- `flutter`: Core framework

## Architecture

- **State Management**: Riverpod for reactive state
- **Navigation**: GoRouter for declarative routing  
- **Authentication**: Simple mock system
- **Trading Logic**: Simulated with random P&L generation
- **XP System**: Persistent XP accumulation

This minimal implementation focuses on core functionality without complex features, making it ideal for rapid prototyping and testing.