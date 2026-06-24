import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/setting/domain/repositories/setting_repository.dart';
import 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final SettingRepository _repository;

  DeleteAccountCubit(this._repository) : super(const DeleteAccountState());

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, errorMessage: null));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> deleteAccount() async {
    if (state.password.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter your password'));
      return;
    }

    emit(state.copyWith(status: DeleteAccountStatus.loading, errorMessage: null));

    final result = await _repository.deleteAccount(password: state.password);
    result.fold(
      (failure) => emit(state.copyWith(
        status: DeleteAccountStatus.failure,
        errorMessage: failure.errmessage ?? 'Failed to delete account.',
      )),
      (_) => emit(state.copyWith(status: DeleteAccountStatus.success)),
    );
  }
}
