import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/player/profile/data/models/user_profile_model.dart';

abstract class UserProfileRepo {
  Future<Either<Failure, UserProfileModel>> getProfile();
  Future<Either<Failure, UserProfileModel>> updateProfile({
    required String fullName,
    required String username,
    String? phoneNumber,
    String? bio,
    File? profileImage,
  });
}
