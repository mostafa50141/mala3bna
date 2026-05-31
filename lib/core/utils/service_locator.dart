import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/location_service.dart';
import 'package:mala3bna/core/utils/route_service.dart';
import 'package:mala3bna/features/auth/data/Repos/auth_repo.dart';
import 'package:mala3bna/features/auth/data/Repos/auth_repo_imp.dart';
import 'package:mala3bna/features/auth/data/Repos/reset_password_repo.dart';
import 'package:mala3bna/features/auth/data/Repos/reset_password_repo_impl.dart';
import 'package:mala3bna/features/player/home/data/repos/courts_repo.dart';
import 'package:mala3bna/features/player/home/data/repos/courts_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  //api service
  getIt.registerSingleton<ApiService>(ApiService(dio: Dio()));
  // route service
  getIt.registerSingleton<RouteService>(
    RouteService(apiService: getIt.get<ApiService>()),
  );
  // auth repo
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(apiService: getIt.get<ApiService>()),
  );
  // reset password repo
  getIt.registerSingleton<ResetPasswordRepo>(
    ResetPasswordRepoImpl(apiService: getIt.get<ApiService>()),
  );
  // courts repo
  getIt.registerSingleton<CourtsRepo>(
    CourtsRepoImpl(apiService: getIt.get<ApiService>()),
  );
  // location service
  getIt.registerSingleton<LocationService>(LocationService());
  // local storage helper
  getIt.registerSingleton<LocalStorageHelper>(LocalStorageHelper());
}
