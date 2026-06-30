enum PrivacyStatus { loading, loaded, error }

class PrivacyState {
  final PrivacyStatus status;
  final String? errorMessage;

  const PrivacyState({
    this.status = PrivacyStatus.loading,
    this.errorMessage,
  });

  PrivacyState copyWith({
    PrivacyStatus? status,
    String? errorMessage,
  }) {
    return PrivacyState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
