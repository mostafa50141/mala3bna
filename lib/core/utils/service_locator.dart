import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mala3bna/core/network/dio_interceptor.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/location_service.dart';
import 'package:mala3bna/core/utils/route_service.dart';
import 'package:mala3bna/core/network/dio_client.dart';

// ── Auth ─────────────────────────────────────────────────────────────────────
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

// ── Courts / Fields (Owner) ───────────────────────────────────────────────────
import 'package:mala3bna/features/owner/courts/data/datasources/court_remote_data_source.dart';
import 'package:mala3bna/features/owner/courts/data/repositories/court_repository_impl.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';

// ── Booking (Owner) ───────────────────────────────────────────────────────────
import 'package:mala3bna/features/owner/booking/data/datasources/booking_remote_data_source.dart';
import 'package:mala3bna/features/owner/booking/data/repositories/booking_repository_impl.dart';
import 'package:mala3bna/features/owner/booking/domain/repositories/booking_repository.dart';

// ── Dashboard (Owner) ─────────────────────────────────────────────────────────
import 'package:mala3bna/features/owner/ownerDashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:mala3bna/features/owner/ownerDashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:mala3bna/features/owner/ownerDashboard/domain/repositories/dashboard_repository.dart';

// ── Setting (Owner) ───────────────────────────────────────────────────────────
import 'package:mala3bna/features/owner/setting/data/datasources/setting_remote_data_source.dart';
import 'package:mala3bna/features/owner/setting/data/repositories/setting_repository_impl.dart';
import 'package:mala3bna/features/owner/setting/domain/repositories/setting_repository.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // ── Core ────────────────────────────────────────────────────────────────────
  getIt.registerSingleton<LocalStorageHelper>(LocalStorageHelper());
  getIt.registerSingleton<DioClient>(DioClient(getIt<LocalStorageHelper>()));

  // dio with interceptor (From Master)
  final dio = Dio();
  dio.interceptors.add(AuthInterceptor());
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
      error: true,
    ),
  );

  // api service
  getIt.registerSingleton<ApiService>(ApiService(dio: dio));

  // ── Services ────────────────────────────────────────────────────────────────
  getIt.registerSingleton<RouteService>(
    RouteService(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<LocationService>(LocationService());

  // ── Auth ────────────────────────────────────────────────────────────────────
  // تم استخدام التعديل الأخير الخاص ببرانش مصطفى لـ AuthRepo
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(
      client: getIt<DioClient>(),
      storage: getIt<LocalStorageHelper>(),
      apiService: getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<ResetPasswordRepo>(
    ResetPasswordRepoImpl(apiService: getIt.get<ApiService>()),
  );

  // ── Player Repos ────────────────────────────────────────────────────────────
  getIt.registerSingleton<CourtsRepo>(
    CourtsRepoImpl(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<BookingRepo>(
    BookingRepoImpl(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<UserProfileRepo>(UserProfileRepoImpl());
  getIt.registerSingleton<ReviewRepo>(
    ReviewRepoImpl(apiService: getIt.get<ApiService>()),
  );

  // ── Owner: Courts / Fields ──────────────────────────────────────────────────
  getIt.registerLazySingleton<CourtRemoteDataSource>(
    () => CourtRemoteDataSourceImpl(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<CourtRepository>(
    () => CourtRepositoryImpl(remoteDataSource: getIt<CourtRemoteDataSource>()),
  );

  // ── Owner: Booking ──────────────────────────────────────────────────────────
  getIt.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(
      remoteDataSource: getIt<BookingRemoteDataSource>(),
    ),
  );

  // ── Owner: Dashboard ────────────────────────────────────────────────────────
  getIt.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      remoteDataSource: getIt<DashboardRemoteDataSource>(),
    ),
  );

  // ── Owner: Setting ──────────────────────────────────────────────────────────
  getIt.registerLazySingleton<SettingRemoteDataSource>(
    () => SettingRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<SettingRepository>(
    () => SettingRepositoryImpl(
      remoteDataSource: getIt<SettingRemoteDataSource>(),
    ),
  );
}
