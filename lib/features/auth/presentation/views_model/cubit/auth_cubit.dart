import 'package:bloc/bloc.dart';
import 'package:mala3bna/features/auth/data/Repos/auth_repo_imp.dart';
import 'package:mala3bna/features/auth/data/models/usermodel.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepoImp) : super(AuthInitial());
  final AuthRepoImp authRepoImp;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    var result = await authRepoImp.login(email: email, password: password);
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
    var result = await authRepoImp.signUp(
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
}
