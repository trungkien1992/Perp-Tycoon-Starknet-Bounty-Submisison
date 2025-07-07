class AuthState {
  final bool isAuthenticated;
  final String? username;

  const AuthState({
    this.isAuthenticated = false,
    this.username,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? username,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      username: username ?? this.username,
    );
  }
}