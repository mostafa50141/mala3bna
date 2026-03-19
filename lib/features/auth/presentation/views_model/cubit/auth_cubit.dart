import 'package:bloc/bloc.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/auth/data/Repos/auth_repo.dart';
import 'package:mala3bna/features/auth/data/models/usermodel.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    var result = await authRepo.login(email: email, password: password);
    result.fold(
      (failure) =>
          emit(AuthFailure(failure.errmessage ?? "Something went wrong")),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  }) async {
    emit(AuthLoading());
    var result = await authRepo.signUp(
      email: email,
      password: password,
      name: name,
      phone: phone,
      role: role,
    );
    result.fold(
      (failure) =>
          emit(AuthFailure(failure.errmessage ?? "Something went wrong")),
      (user) => emit(AuthSuccess(user: user)),
    );
  }
  // log out fun i should call it at the putton of logout at the profile screen to delete
  //the token from local storage and emit the initial state to go back to the login screen
  // i should call the emit authinit in the end of it so it does not throw error because the state should be
  //emitted after the token is deleted from local storage

  Future<void> logout() async {
    await getIt.get<LocalStorageHelper>().deletetoken();
    emit(AuthInitial());
  }
}
