import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/player/profile/data/models/user_profile_model.dart';
import 'package:mala3bna/features/player/profile/data/repos/user_profile_repo.dart';

class UserProfileRepoImpl implements UserProfileRepo {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://graduation8project.pythonanywhere.com/api/v1/';

  @override
  Future<Either<Failure, UserProfileModel>> getProfile() async {
    try {
      final token = await getIt.get<LocalStorageHelper>().gettoken();
      final response = await _dio.get(
        '${_baseUrl}users/me/',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return right(
        UserProfileModel.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      if (e is DioException) return left(ServerFailure.fromDioError(e));
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> updateProfile({
    required String fullName,
    required String username,
    String? phoneNumber,
    String? bio,
    File? profileImage,
  }) async {
    try {
      final token = await getIt.get<LocalStorageHelper>().gettoken();

      final formData = FormData.fromMap({
        'full_name': fullName,
        'username': username,
        if (phoneNumber != null && phoneNumber.isNotEmpty)
          'phone_number': phoneNumber,
        if (bio != null && bio.isNotEmpty) 'bio': bio,
        if (profileImage != null)
          'profile_image': await MultipartFile.fromFile(
            profileImage.path,
            filename: 'profile.jpg',
            contentType: DioMediaType('image', 'jpeg'),
          ),
      });

      final response = await _dio.put(
        '${_baseUrl}users/me/',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          contentType: 'multipart/form-data',
        ),
      );
      return right(
        UserProfileModel.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      if (e is DioException) return left(ServerFailure.fromDioError(e));
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount({
    required String password,
  }) async {
    try {
      final token = await getIt.get<LocalStorageHelper>().gettoken();
      await _dio.delete(
        '${_baseUrl}users/me/delete-account/',
        data: {'password': password},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          contentType: 'application/json',
        ),
      );
      return right(null);
    } catch (e) {
      if (e is DioException) return left(ServerFailure.fromDioError(e));
      return left(ServerFailure(e.toString()));
    }
  }
}
