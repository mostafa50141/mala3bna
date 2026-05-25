import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';

abstract class ResetPasswordRepo {
  Future<Either<Failure, void>> sendEmail({required String email});
  Future<Either<Failure, void>> verifyOtp({required String email, required String otp});
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
}
