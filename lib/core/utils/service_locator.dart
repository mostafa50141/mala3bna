import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/features/auth/data/Repos/auth_repo_imp.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  //api service
  getIt.registerSingleton<ApiService>(ApiService(dio: Dio()));
  // auth repo
  getIt.registerSingleton<AuthRepoImp>(
    AuthRepoImp(apiService: getIt.get<ApiService>()),
  );
  // local storage helper
  getIt.registerSingleton<LocalStorageHelper>(LocalStorageHelper());
}
