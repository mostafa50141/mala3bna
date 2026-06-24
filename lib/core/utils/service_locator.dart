import 'package:get_it/get_it.dart';
import 'package:mala3bna/core/network/dio_client.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';

// ── Auth ─────────────────────────────────────────────────────────────────────
import 'package:mala3bna/features/auth/data/Repos/auth_repo.dart';
import 'package:mala3bna/features/auth/data/Repos/auth_repo_imp.dart';

// ── Courts / Fields ───────────────────────────────────────────────────────────
import 'package:mala3bna/features/owner/courts/data/datasources/court_remote_data_source.dart';
import 'package:mala3bna/features/owner/courts/data/repositories/court_repository_impl.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';

// ── Booking ───────────────────────────────────────────────────────────────────
import 'package:mala3bna/features/owner/booking/data/datasources/booking_remote_data_source.dart';
import 'package:mala3bna/features/owner/booking/data/repositories/booking_repository_impl.dart';
import 'package:mala3bna/features/owner/booking/domain/repositories/booking_repository.dart';

// ── Dashboard ─────────────────────────────────────────────────────────────────
import 'package:mala3bna/features/owner/ownerDashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:mala3bna/features/owner/ownerDashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:mala3bna/features/owner/ownerDashboard/domain/repositories/dashboard_repository.dart';

// ── Setting ───────────────────────────────────────────────────────────────────
import 'package:mala3bna/features/owner/setting/data/datasources/setting_remote_data_source.dart';
import 'package:mala3bna/features/owner/setting/data/repositories/setting_repository_impl.dart';
import 'package:mala3bna/features/owner/setting/domain/repositories/setting_repository.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // ── Core ────────────────────────────────────────────────────────────────────
  getIt.registerSingleton<LocalStorageHelper>(LocalStorageHelper());
  getIt.registerSingleton<DioClient>(DioClient(getIt<LocalStorageHelper>()));

  // ── Auth ────────────────────────────────────────────────────────────────────
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(
      client: getIt<DioClient>(),
      storage: getIt<LocalStorageHelper>(),
    ),
  );

  // ── Courts / Fields ─────────────────────────────────────────────────────────
  getIt.registerLazySingleton<CourtRemoteDataSource>(
    () => CourtRemoteDataSourceImpl(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<CourtRepository>(
    () => CourtRepositoryImpl(remoteDataSource: getIt<CourtRemoteDataSource>()),
  );

  // ── Booking ─────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(
      remoteDataSource: getIt<BookingRemoteDataSource>(),
    ),
  );

  // ── Dashboard ───────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      remoteDataSource: getIt<DashboardRemoteDataSource>(),
    ),
  );

  // ── Setting ──────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<SettingRemoteDataSource>(
    () => SettingRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<SettingRepository>(
    () => SettingRepositoryImpl(
      remoteDataSource: getIt<SettingRemoteDataSource>(),
    ),
  );
}
