import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/ownerDashboard/domain/entities/dashboard_entity.dart';
import 'package:mala3bna/features/owner/ownerDashboard/domain/repositories/dashboard_repository.dart';

class FetchDashboardUseCase {
  final DashboardRepository repository;

  FetchDashboardUseCase(this.repository);

  Future<Either<Failure, DashboardEntity>> call() {
    return repository.fetchDashboard();
  }
}
