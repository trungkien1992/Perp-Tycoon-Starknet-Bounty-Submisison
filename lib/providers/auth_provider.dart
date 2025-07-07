import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> mockLogin(String username) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));
    
    state = state.copyWith(
      isAuthenticated: true,
      username: username,
    );
  }

  void logout() {
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});