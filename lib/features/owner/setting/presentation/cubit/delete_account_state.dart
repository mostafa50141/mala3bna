enum DeleteAccountStatus { initial, loading, success, failure }

class DeleteAccountState {
  final String password;
  final bool isPasswordVisible;
  final DeleteAccountStatus status;
  final String? errorMessage;

  const DeleteAccountState({
    this.password = '',
    this.isPasswordVisible = false,
    this.status = DeleteAccountStatus.initial,
    this.errorMessage,
  });

  bool get canSubmit =>
      password.isNotEmpty && status != DeleteAccountStatus.loading;

  DeleteAccountState copyWith({
    String? password,
    bool? isPasswordVisible,
    DeleteAccountStatus? status,
    String? errorMessage,
  }) {
    return DeleteAccountState(
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
