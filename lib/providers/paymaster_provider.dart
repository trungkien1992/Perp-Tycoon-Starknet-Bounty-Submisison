import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/paymaster_service.dart';
import '../app_mode.dart';

/// Provider for paymaster service
final paymasterServiceProvider = Provider<PaymasterService>((ref) {
  return PaymasterService(useMainnet: !isMockMode());
});

/// Provider for paymaster status
final paymasterStatusProvider = StateNotifierProvider<PaymasterStatusNotifier, PaymasterStatus>((ref) {
  final service = ref.read(paymasterServiceProvider);
  return PaymasterStatusNotifier(service);
});

/// Paymaster status state
class PaymasterStatus {
  final bool isAvailable;
  final bool isSponsoring;
  final BigInt balance;
  final String? error;
  final bool isLoading;
  final int totalTxSponsored;
  final BigInt totalFeesSponsored;
  
  PaymasterStatus({
    this.isAvailable = false,
    this.isSponsoring = false,
    BigInt? balance,
    this.error,
    this.isLoading = false,
    this.totalTxSponsored = 0,
    BigInt? totalFeesSponsored,
  }) : balance = balance ?? BigInt.zero,
       totalFeesSponsored = totalFeesSponsored ?? BigInt.zero;
  
  PaymasterStatus copyWith({
    bool? isAvailable,
    bool? isSponsoring,
    BigInt? balance,
    String? error,
    bool? isLoading,
    int? totalTxSponsored,
    BigInt? totalFeesSponsored,
  }) {
    return PaymasterStatus(
      isAvailable: isAvailable ?? this.isAvailable,
      isSponsoring: isSponsoring ?? this.isSponsoring,
      balance: balance ?? this.balance,
      error: error,
      isLoading: isLoading ?? this.isLoading,
      totalTxSponsored: totalTxSponsored ?? this.totalTxSponsored,
      totalFeesSponsored: totalFeesSponsored ?? this.totalFeesSponsored,
    );
  }
}

/// Paymaster status notifier
class PaymasterStatusNotifier extends StateNotifier<PaymasterStatus> {
  final PaymasterService _paymasterService;
  
  PaymasterStatusNotifier(this._paymasterService) : super(PaymasterStatus()) {
    _initialize();
  }
  
  /// Initialize paymaster status
  Future<void> _initialize() async {
    state = state.copyWith(isLoading: true);
    
    try {
      // Check if paymaster is available
      final isAvailable = _paymasterService.isAvailable;
      
      if (isAvailable) {
        // In mock mode, set mock values
        if (isMockMode()) {
          state = state.copyWith(
            isAvailable: true,
            balance: BigInt.from(5000000000000000000), // 5 ETH worth of fees
            isLoading: false,
            totalTxSponsored: 1247, // Mock total sponsored transactions
            totalFeesSponsored: BigInt.from(850000000000000000), // 0.85 ETH in fees
          );
        } else {
          // In real mode, fetch actual balance
          // final balance = await _paymasterService._getPaymasterBalance();
          state = state.copyWith(
            isAvailable: true,
            balance: BigInt.from(1000000000000000000), // 1 ETH placeholder
            isLoading: false,
          );
        }
      } else {
        state = state.copyWith(
          isAvailable: false,
          error: 'Paymaster service not available',
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isAvailable: false,
        error: e.toString(),
        isLoading: false,
      );
    }
  }
  
  /// Check if a trade can be sponsored
  Future<PaymasterSponsorshipResult> checkTradeSponsorship({
    required String userAddress,
    required String tradeData,
    required BigInt estimatedGas,
  }) async {
    state = state.copyWith(isLoading: true);
    
    try {
      final result = await _paymasterService.canSponsorTrade(
        userAddress: userAddress,
        tradeData: tradeData,
        estimatedGas: estimatedGas,
      );
      
      state = state.copyWith(
        isSponsoring: result.canSponsor,
        isLoading: false,
        error: result.canSponsor ? null : result.reason,
      );
      
      return result;
    } catch (e) {
      state = state.copyWith(
        isSponsoring: false,
        error: e.toString(),
        isLoading: false,
      );
      rethrow;
    }
  }
  
  /// Execute gasless trade
  Future<GaslessTxResult> executeGaslessTrade({
    required String userAddress,
    required String userSignature,
    required String tradeData,
    required PaymasterData paymasterData,
  }) async {
    state = state.copyWith(isLoading: true);
    
    try {
      print('💰 Executing gasless trade via paymaster...');
      
      final result = await _paymasterService.executeGaslessTradeTransaction(
        userAddress: userAddress,
        userSignature: userSignature,
        tradeData: tradeData,
        paymasterData: paymasterData,
      );
      
      if (result.success) {
        // Update statistics
        final newTotalTx = state.totalTxSponsored + 1;
        final newTotalFees = state.totalFeesSponsored + result.gasFeePaid;
        final newBalance = state.balance - result.gasFeePaid;
        
        state = state.copyWith(
          isLoading: false,
          totalTxSponsored: newTotalTx,
          totalFeesSponsored: newTotalFees,
          balance: newBalance > BigInt.zero ? newBalance : state.balance,
          error: null,
        );
        
        print('✅ Gasless trade successful! Gas fees paid by paymaster: ${result.gasFeePaid}');
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result.message,
        );
      }
      
      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }
  
  /// Refresh paymaster status
  Future<void> refresh() async {
    await _initialize();
  }
  
  /// Get formatted balance in ETH
  String get balanceInEth {
    if (state.balance == BigInt.zero) return '0.0';
    final ethBalance = state.balance / BigInt.from(1000000000000000000);
    return ethBalance.toStringAsFixed(4);
  }
  
  /// Get formatted total fees sponsored
  String get totalFeesInEth {
    if (state.totalFeesSponsored == BigInt.zero) return '0.0';
    final ethFees = state.totalFeesSponsored / BigInt.from(1000000000000000000);
    return ethFees.toStringAsFixed(4);
  }
  
  /// Check if paymaster can sponsor given fee
  bool canSponsorFee(BigInt fee) {
    return state.isAvailable && state.balance >= fee;
  }
}