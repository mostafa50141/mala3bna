import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/features/auth/data/Repos/auth_repo_imp.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ApiService>(ApiService(dio: Dio()));
  getIt.registerSingleton<AuthRepoImp>(
    AuthRepoImp(apiService: getIt.get<ApiService>()),
  );
}
