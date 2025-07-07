import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/starknet_service.dart';
import '../app_mode.dart';

/// Provider for Starknet service
final starknetServiceProvider = Provider<StarknetService>((ref) {
  final service = StarknetService(useMainnet: !isMockMode());
  
  // Auto-create test account in mock mode
  if (isMockMode()) {
    service.createTestAccount();
  }
  
  return service;
});

/// Provider for Starknet connection state
final starknetConnectionProvider = StateNotifierProvider<StarknetConnectionNotifier, StarknetConnectionState>((ref) {
  final service = ref.read(starknetServiceProvider);
  return StarknetConnectionNotifier(service);
});

/// Starknet connection state
class StarknetConnectionState {
  final bool isConnected;
  final String? accountAddress;
  final String? publicKey;
  final String? error;
  final bool isLoading;
  
  const StarknetConnectionState({
    this.isConnected = false,
    this.accountAddress,
    this.publicKey,
    this.error,
    this.isLoading = false,
  });
  
  StarknetConnectionState copyWith({
    bool? isConnected,
    String? accountAddress,
    String? publicKey,
    String? error,
    bool? isLoading,
  }) {
    return StarknetConnectionState(
      isConnected: isConnected ?? this.isConnected,
      accountAddress: accountAddress ?? this.accountAddress,
      publicKey: publicKey ?? this.publicKey,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Starknet connection state notifier
class StarknetConnectionNotifier extends StateNotifier<StarknetConnectionState> {
  final StarknetService _starknetService;
  
  StarknetConnectionNotifier(this._starknetService) : super(const StarknetConnectionState()) {
    _initializeConnection();
  }
  
  /// Initialize connection (auto-connect in mock mode)
  Future<void> _initializeConnection() async {
    if (isMockMode()) {
      await createTestAccount();
    }
  }
  
  /// Create test account for development
  Future<void> createTestAccount() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _starknetService.createTestAccount();
      state = state.copyWith(
        isConnected: true,
        accountAddress: _starknetService.accountAddress,
        publicKey: _starknetService.publicKey,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isConnected: false,
        error: e.toString(),
        isLoading: false,
      );
    }
  }
  
  /// Connect with existing account
  Future<void> connectAccount(String privateKey, String accountAddress) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _starknetService.connectAccount(privateKey, accountAddress);
      state = state.copyWith(
        isConnected: true,
        accountAddress: _starknetService.accountAddress,
        publicKey: _starknetService.publicKey,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isConnected: false,
        error: e.toString(),
        isLoading: false,
      );
    }
  }
  
  /// Disconnect account
  void disconnect() {
    _starknetService.disconnect();
    state = const StarknetConnectionState();
  }
  
  /// Get Starknet service for signing operations
  StarknetService get service => _starknetService;
}