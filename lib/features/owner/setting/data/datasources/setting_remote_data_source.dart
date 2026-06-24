import 'dart:io';
import 'package:dio/dio.dart' as dio_lib;
import 'package:mala3bna/core/network/api_endpoints.dart';
import 'package:mala3bna/core/network/dio_client.dart';
import 'package:mala3bna/features/owner/setting/data/models/owner_profile_model.dart';

abstract class SettingRemoteDataSource {
  Future<OwnerProfileModel> fetchProfile();
  Future<OwnerProfileModel> updateProfile(OwnerProfileModel model, {File? imageFile});
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<void> deleteAccount({required String password});
}

class SettingRemoteDataSourceImpl implements SettingRemoteDataSource {
  final DioClient dioClient;

  SettingRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<OwnerProfileModel> fetchProfile() async {
    final data = await dioClient.get(ApiEndpoints.me);
    print('[Setting] fetchProfile raw JSON: $data');
    return OwnerProfileModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<OwnerProfileModel> updateProfile(OwnerProfileModel model, {File? imageFile}) async {
    final payload = model.toJson();
    print('[Setting] Updating profile with: $payload');
    dynamic data;
    
    if (imageFile != null) {
      print('[Setting] Uploading with image: ${imageFile.path}');
      final formFields = payload.map((k, v) => MapEntry(k, v.toString()));
      final formData = dio_lib.FormData.fromMap({
        ...formFields,
        'profile_image': await dio_lib.MultipartFile.fromFile(imageFile.path),
      });
      data = await dioClient.patchMultipart(ApiEndpoints.me, formData: formData);
    } else {
      data = await dioClient.patchForm(ApiEndpoints.me, data: payload);
    }
    
    print('[Setting] Update response: $data');
    return OwnerProfileModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await dioClient.post(
      ApiEndpoints.changePassword,
      data: {
        'old_password': currentPassword,
        'new_password': newPassword,
      },
    );
  }

  @override
  Future<void> deleteAccount({required String password}) async {
    await dioClient.delete(
      ApiEndpoints.deleteAccount,
      data: {'password': password},
    );
  }
}
