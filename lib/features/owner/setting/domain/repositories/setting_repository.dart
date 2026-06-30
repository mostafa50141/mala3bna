import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/setting/domain/entities/user_entity.dart';

/// Domain contract for all settings/profile API calls.
abstract class SettingRepository {
  /// GET /api/v1/users/me/
  Future<Either<Failure, UserEntity>> fetchProfile();

  /// PATCH /api/v1/users/me/
  Future<Either<Failure, UserEntity>> updateProfile(UserEntity user, {File? imageFile});

  /// POST /api/v1/auth/change-password/
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// DELETE /api/v1/users/me/delete-account/
  Future<Either<Failure, void>> deleteAccount({required String password});
}
