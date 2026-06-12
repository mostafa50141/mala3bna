import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/features/auth/data/Repos/reset_password_repo.dart';

class ResetPasswordRepoImpl implements ResetPasswordRepo {
  final ApiService apiService;
  String? _storedOtp;

  ResetPasswordRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, void>> sendEmail({required String email}) async {
    try {
      await apiService.post(
        endPoint: 'auth/request-otp/',
        body: {'email': email},
      );
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    _storedOtp = otp;
    return right(null);
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await apiService.post(
        endPoint: 'auth/reset-password-otp/',
        body: {
          'email': email,
          'otp': otp.isNotEmpty ? otp : (_storedOtp ?? ''),
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
