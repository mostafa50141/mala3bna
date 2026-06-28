import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mala3bna/core/network/dio_interceptor.dart';
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
import 'package:mala3bna/features/player/courts_booking/data/repos/booking_repo.dart';
import 'package:mala3bna/features/player/courts_booking/data/repos/booking_repo_impl.dart';
import 'package:mala3bna/features/player/profile/data/repos/user_profile_repo.dart';
import 'package:mala3bna/features/player/profile/data/repos/user_profile_repo_impl.dart';
import 'package:mala3bna/features/player/courts_booking/data/repos/review_repo.dart';
import 'package:mala3bna/features/player/courts_booking/data/repos/review_repo_impl.dart';


final getIt = GetIt.instance;

void setupServiceLocator() {
  // local storage helper
  getIt.registerSingleton<LocalStorageHelper>(LocalStorageHelper());

  // dio with interceptor
  final dio = Dio();
  dio.interceptors.add(AuthInterceptor());
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    responseHeader: false,
    error: true,
  ));

  //api service
  getIt.registerSingleton<ApiService>(ApiService(dio: dio));
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
  // booking repo
  getIt.registerSingleton<BookingRepo>(
    BookingRepoImpl(apiService: getIt.get<ApiService>()),
  );
  // location service
  getIt.registerSingleton<LocationService>(LocationService());
  // user profile repo
  getIt.registerSingleton<UserProfileRepo>(UserProfileRepoImpl());
  // review repo
  getIt.registerSingleton<ReviewRepo>(
    ReviewRepoImpl(apiService: getIt.get<ApiService>()),
  );
}
