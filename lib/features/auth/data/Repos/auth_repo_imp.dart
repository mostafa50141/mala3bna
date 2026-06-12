import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/auth/data/Repos/auth_repo.dart';
import 'package:mala3bna/features/auth/data/models/usermodel.dart';

class AuthRepoImp implements AuthRepo {
  final ApiService apiService;

  AuthRepoImp({required this.apiService});
  // the fun that deal with the api to login
  @override
  Future<Either<Failure, Usermodel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiService.post(
        endPoint: 'auth/login/',
        body: {'email': email, 'password': password},
      );
      Usermodel user = Usermodel.fromJson(response);
      if (user.token != null) {
        await getIt.get<LocalStorageHelper>().savetoken(user.token!);
        if (user.refreshToken != null) {
          await getIt.get<LocalStorageHelper>().saveRefreshToken(user.refreshToken!);
        }
        await getIt.get<LocalStorageHelper>().saveUserData(
          name: user.fullName ?? '',
          email: user.email ?? '',
          phone: user.phoneNumber ?? '',
          userType: user.userType ?? 'player',
        );
        return right(user);
      } else {
        return left(ServerFailure("Invalid response from server"));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Usermodel>> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  }) async {
    try {
      var response = await apiService.post(
        endPoint: 'auth/signup/',
        body: {
          'full_name': name,
          'username': email.split('@')[0],
          'email': email,
          'password': password,
          'phone_number': phone,
          'user_type': role,
        },
      );
      Usermodel user = Usermodel.fromJson(response);
      if (user.token != null) {
        await getIt.get<LocalStorageHelper>().savetoken(user.token!);
        if (user.refreshToken != null) {
          await getIt.get<LocalStorageHelper>().saveRefreshToken(user.refreshToken!);
        }
        await getIt.get<LocalStorageHelper>().saveUserData(
          name: user.fullName ?? name,
          email: user.email ?? email,
          phone: user.phoneNumber ?? phone,
          userType: user.userType ?? role,
        );
        return right(user);
      } else {
        return left(ServerFailure("Invalid response from server"));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  // fake api for testing the app without the real api and to test the ui and the flow of the app
  // without waiting for the api to be ready
  // @override
  // Future<Either<Failure, Usermodel>> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   final fakeUser = Usermodel(
  //     id: 1,
  //     fullName: "Mustafa",
  //     email: email,
  //     token: "fake_token_123",
  //     userType: "player",
  //   );
  //   await getIt.get<LocalStorageHelper>().savetoken(fakeUser.token!);

  //   return right(fakeUser);
  // }

  // @override
  // Future<Either<Failure, Usermodel>> signUp({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required String phone,
  //   required String role,
  // }) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   final fakeUser = Usermodel(
  //     id: 1,
  //     fullName: name,
  //     email: email,
  //     token: "fake_token_123",
  //     userType: role,
  //   );
  //   await getIt.get<LocalStorageHelper>().savetoken(fakeUser.token!);
  //   return right(fakeUser);
  // }
}
