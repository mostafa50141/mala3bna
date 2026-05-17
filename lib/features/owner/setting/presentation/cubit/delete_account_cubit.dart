import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/setting/data/repo/owner_profile_repository.dart';
import 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final OwnerProfileRepository _repository;

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

    try {
      // Simulate network call — replace with real API in production
      await _repository.deleteAccount(password: state.password);
      emit(state.copyWith(status: DeleteAccountStatus.success));
    } on TimeoutException {
      emit(state.copyWith(
        status: DeleteAccountStatus.failure,
        errorMessage: 'Request timed out. Check your connection and retry.',
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: DeleteAccountStatus.failure,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}
