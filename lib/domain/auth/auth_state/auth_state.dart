class AuthState {
  final bool isLoginLoading;
  final bool isLoginSuccess;
  final String? loginError;

  final bool isRegisterLoading;
  final bool isRegisterSuccess;
  final String? registerError;

  const AuthState({
    this.isLoginLoading = false,
    this.isLoginSuccess = false,
    this.loginError,
    this.isRegisterLoading = false,
    this.isRegisterSuccess = false,
    this.registerError,
  });

  AuthState copyWith({
    bool? isLoginLoading,
    bool? isLoginSuccess,
    String? loginError,
    bool? isRegisterLoading,
    bool? isRegisterSuccess,
    String? registerError,
  }) {
    return AuthState(
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      loginError: loginError,
      isRegisterLoading: isRegisterLoading ?? this.isRegisterLoading,
      isRegisterSuccess: isRegisterSuccess ?? this.isRegisterSuccess,
      registerError: registerError,
    );
  }
}
