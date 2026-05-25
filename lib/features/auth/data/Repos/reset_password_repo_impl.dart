import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/features/auth/data/Repos/reset_password_repo.dart';

class ResetPasswordRepoImpl implements ResetPasswordRepo {
  final ApiService apiService;

  ResetPasswordRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, void>> sendEmail({required String email}) async {
    try {
      await apiService.post(
        endPoint: 'auth/forgot-password',
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
    try {
      await apiService.post(
        endPoint: 'auth/verify-otp',
        body: {'email': email, 'otp': otp},
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
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await apiService.post(
        endPoint: 'auth/reset-password',
        body: {
          'email': email,
          'otp': otp,
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
