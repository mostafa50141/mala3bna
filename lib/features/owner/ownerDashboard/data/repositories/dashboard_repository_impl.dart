import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/ownerDashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:mala3bna/features/owner/ownerDashboard/domain/entities/dashboard_entity.dart';
import 'package:mala3bna/features/owner/ownerDashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DashboardEntity>> fetchDashboard() async {
    try {
      final model = await remoteDataSource.fetchDashboard();
      return Right(model.toEntity());
    } on Failure catch (f) {
      // DioClient translates DioException → ServerFailure before throwing,
      // so we catch Failure here, not DioException.
      print('Dashboard failure: ${f.errmessage}');
      return Left(f);
    } catch (e) {
      print('Dashboard unexpected error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
