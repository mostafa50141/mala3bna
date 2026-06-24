import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/setting/data/datasources/setting_remote_data_source.dart';
import 'package:mala3bna/features/owner/setting/data/models/owner_profile_model.dart';
import 'package:mala3bna/features/owner/setting/domain/entities/user_entity.dart';
import 'package:mala3bna/features/owner/setting/domain/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingRemoteDataSource remoteDataSource;

  SettingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> fetchProfile() async {
    try {
      final model = await remoteDataSource.fetchProfile();
      return Right(model.toEntity());
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile(UserEntity user, {File? imageFile}) async {
    try {
      final model = OwnerProfileModel.fromEntity(user);
      print('[Setting] Repository calling datasource with: ${model.toJson()}');
      final updated = await remoteDataSource.updateProfile(model, imageFile: imageFile);
      print('[Setting] Repository got back entity: name=${updated.toEntity().name}, email=${updated.toEntity().email}');
      return Right(updated.toEntity());
    } on Failure catch (f) {
      print('[Setting] Repository Failure: ${f.errmessage}');
      return Left(f);
    } catch (e) {
      print('[Setting] Repository error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount({required String password}) async {
    try {
      await remoteDataSource.deleteAccount(password: password);
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
