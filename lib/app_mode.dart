/// App mode configuration for StreetCred Minimal
enum AppMode {
  /// Mock mode - uses simulated data for development
  mock,
  
  /// Real mode - uses Extended API for live trading
  real,
}

/// Global app mode configuration
AppMode getAppMode() {
  const String mode = String.fromEnvironment('APP_MODE', defaultValue: 'mock');
  
  switch (mode.toLowerCase()) {
    case 'real':
      return AppMode.real;
    case 'mock':
    default:
      return AppMode.mock;
  }
}

/// Check if app is running in mock mode
bool isMockMode() => getAppMode() == AppMode.mock;

/// Check if app is running in real mode  
bool isRealMode() => getAppMode() == AppMode.real;