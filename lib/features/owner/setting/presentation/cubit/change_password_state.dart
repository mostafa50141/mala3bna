enum ChangePasswordStatus { initial, submitting, success, failure }

class ChangePasswordState {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final bool isCurrentPasswordVisible;
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;
  final ChangePasswordStatus status;
  final String? errorMessage;

  const ChangePasswordState({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isCurrentPasswordVisible = false,
    this.isNewPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.status = ChangePasswordStatus.initial,
    this.errorMessage,
  });

  // ─── Password Strength ────────────────────────────────────────────

  bool get hasMinLength => newPassword.length >= 8;
  bool get hasUppercase => newPassword.contains(RegExp(r'[A-Z]'));
  bool get hasSpecialChar =>
      newPassword.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool get passwordsMatch =>
      newPassword.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      newPassword == confirmPassword;

  int get strengthScore {
    int score = 0;
    if (hasMinLength) score++;
    if (hasUppercase) score++;
    if (hasSpecialChar) score++;
    if (newPassword.contains(RegExp(r'[0-9]'))) score++;
    return score;
  }

  String get strengthLabel {
    if (newPassword.isEmpty) return '';
    switch (strengthScore) {
      case 0:
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Medium';
      default:
        return 'Strong';
    }
  }

  double get strengthProgress {
    if (newPassword.isEmpty) return 0;
    return strengthScore / 4;
  }

  bool get isFormValid =>
      currentPassword.isNotEmpty &&
      hasMinLength &&
      hasUppercase &&
      hasSpecialChar &&
      passwordsMatch;

  ChangePasswordState copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isCurrentPasswordVisible,
    bool? isNewPasswordVisible,
    bool? isConfirmPasswordVisible,
    ChangePasswordStatus? status,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isCurrentPasswordVisible:
          isCurrentPasswordVisible ?? this.isCurrentPasswordVisible,
      isNewPasswordVisible:
          isNewPasswordVisible ?? this.isNewPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
