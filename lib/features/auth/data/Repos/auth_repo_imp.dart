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
  // @override
  // Future<Either<Failure, Usermodel>> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     var response = await apiService.post(
  //       endPoint: 'auth/login',
  //       body: {'email': email, 'password': password},
  //     );
  //     // here the model that i created to convert the json response
  //     //to object and use it in the app the response that came from the api recived here and convert it to usermodel object
  //     // and return it to the app
  //     Usermodel user = Usermodel.fromJson(response);
  //     if (user.token != null) {
  //       // save the token in local storage using the helper class that i created
  //       await getIt.get<LocalStorageHelper>().savetoken(user.token!);
  //       return right(user);
  //     } else {
  //       return left(ServerFailure("Invalid token"));
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     return left(ServerFailure(e.toString()));
  //   }
  // }
  // // same as sign up  but with different end point and body

  // @override
  // Future<Either<Failure, Usermodel>> signUp({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required String phone,
  //   required String role,
  // }) async {
  //   try {
  //     var response = await apiService.post(
  //       endPoint: 'auth/signup/',
  //       body: {
  //         'email': email,
  //         'password': password,
  //         'name': name,
  //         'phone': phone,
  //         'role': role,
  //       },
  //     );
  //     Usermodel user = Usermodel.fromJson(response);
  //     if (user.token != null) {
  //       // save the token in local storage using the helper class that i created
  //       await getIt.get<LocalStorageHelper>().savetoken(user.token!);
  //       return right(user);
  //     } else {
  //       return left(ServerFailure("Invalid token"));
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     return left(ServerFailure(e.toString()));
  //   }
  // }
  //   import 'package:dartz/dartz.dart';
  // import 'package:mala3bna/core/errors/failure.dart';
  // import 'package:mala3bna/core/utils/local_storage_helper.dart';
  // import 'package:mala3bna/core/utils/service_locator.dart';
  // import 'package:mala3bna/features/auth/data/models/usermodel.dart';

  @override
  Future<Either<Failure, Usermodel>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    final fakeUser = Usermodel(
      id: 1,
      fullName: "Mustafa",
      email: email,
      token: "fake_token_123",
      userType: "player",
    );
    await getIt.get<LocalStorageHelper>().savetoken(fakeUser.token!);

    return right(fakeUser);
  }

  @override
  Future<Either<Failure, Usermodel>> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    final fakeUser = Usermodel(
      id: 1,
      fullName: name,
      email: email,
      token: "fake_token_123",
      userType: role,
    );
    await getIt.get<LocalStorageHelper>().savetoken(fakeUser.token!);
    return right(fakeUser);
  }
}
