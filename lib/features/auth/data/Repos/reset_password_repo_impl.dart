import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/features/auth/data/Repos/reset_password_repo.dart';

class ResetPasswordRepoImpl implements ResetPasswordRepo {
  final ApiService apiService;
  String? _storedEmail;
  String? _storedOtp;

  ResetPasswordRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, void>> sendEmail({required String email}) async {
    try {
      await apiService.post(
        endPoint: 'auth/request-otp/',
        body: {'email': email},
      );
      _storedEmail = email;
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp({required String otp}) async {
    // No backend endpoint exists to verify OTP alone.
    // Just validate format locally and store it for the final reset call.
    if (otp.trim().length != 6) {
      return left(ServerFailure("Please enter a valid 6-digit code"));
    }
    _storedOtp = otp.trim();
    return right(null);
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String newPassword,
  }) async {
    try {
      await apiService.post(
        endPoint: 'auth/reset-password-otp/',
        body: {
          'email': _storedEmail ?? '',
          'otp': _storedOtp ?? '',
          'new_password': newPassword,
        },
      );
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
