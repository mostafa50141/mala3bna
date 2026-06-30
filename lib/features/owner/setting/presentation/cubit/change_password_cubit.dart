import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/setting/domain/repositories/setting_repository.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final SettingRepository _repository;

  ChangePasswordCubit(this._repository) : super(const ChangePasswordState());

  void currentPasswordChanged(String value) {
    emit(state.copyWith(currentPassword: value, errorMessage: null));
  }

  void newPasswordChanged(String value) {
    emit(state.copyWith(newPassword: value, errorMessage: null));
  }

  void confirmPasswordChanged(String value) {
    emit(state.copyWith(confirmPassword: value, errorMessage: null));
  }

  void toggleCurrentPasswordVisibility() {
    emit(state.copyWith(
        isCurrentPasswordVisible: !state.isCurrentPasswordVisible));
  }

  void toggleNewPasswordVisibility() {
    emit(state.copyWith(
        isNewPasswordVisible: !state.isNewPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  Future<void> submit() async {
    if (state.currentPassword.isEmpty) {
      emit(state.copyWith(errorMessage: 'Current password is required'));
      return;
    }
    if (state.newPassword.length < 8) {
      emit(state.copyWith(
          errorMessage: 'Password must be at least 8 characters'));
      return;
    }
    if (!state.hasUppercase) {
      emit(state.copyWith(
          errorMessage: 'Password must contain an uppercase letter'));
      return;
    }
    if (!state.hasSpecialChar) {
      emit(state.copyWith(
          errorMessage: 'Password must contain a special character'));
      return;
    }
    if (state.newPassword != state.confirmPassword) {
      emit(state.copyWith(errorMessage: 'Passwords do not match'));
      return;
    }
    if (state.currentPassword == state.newPassword) {
      emit(state.copyWith(
          errorMessage: 'New password must differ from current'));
      return;
    }

    emit(state.copyWith(status: ChangePasswordStatus.submitting));
    final result = await _repository.changePassword(
      currentPassword: state.currentPassword,
      newPassword: state.newPassword,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: ChangePasswordStatus.failure,
        errorMessage: failure.errmessage ?? 'Failed to update password.',
      )),
      (_) => emit(state.copyWith(status: ChangePasswordStatus.success)),
    );
  }
}
