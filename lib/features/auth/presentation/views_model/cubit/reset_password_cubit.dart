import 'package:bloc/bloc.dart';
import 'package:mala3bna/features/auth/data/Repos/reset_password_repo.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepo repo;

  ResetPasswordCubit(this.repo) : super(ResetPasswordInitial());

  String email = '';
  String otp = '';

  Future<void> sendEmail({required String email}) async {
    emit(ResetPasswordLoading());
    this.email = email;
    var result = await repo.sendEmail(email: email);
    result.fold(
      (failure) => emit(ResetPasswordFailure(failure.errmessage ?? "Something went wrong")),
      (_) => emit(SendEmailSuccess()),
    );
  }

  Future<void> verifyOtp({required String otp}) async {
    emit(ResetPasswordLoading());
    this.otp = otp;
    var result = await repo.verifyOtp(otp: otp);
    result.fold(
      (failure) => emit(ResetPasswordFailure(failure.errmessage ?? "Something went wrong")),
      (_) => emit(VerifyOtpSuccess()),
    );
  }

  Future<void> resetPassword({required String newPassword}) async {
    emit(ResetPasswordLoading());
    var result = await repo.resetPassword(newPassword: newPassword);
    result.fold(
      (failure) => emit(ResetPasswordFailure(failure.errmessage ?? "Something went wrong")),
      (_) => emit(ResetPasswordSuccess()),
    );
  }
}
