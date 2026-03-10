import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> reg({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(email: email, password: password);
      emit(AuthLoading());
      emit(AuthSuccess());
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'weak-password') {
      //     emit(AuthFailure("weak password "));
      //   } else if (e.code == 'email-already-in-use') {
      //     emit(AuthFailure("the account is already exist! try to login"));
      //   }
      // }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
