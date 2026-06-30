import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';

class GetOwnerFieldsUseCase {
  final CourtRepository _repo;
  const GetOwnerFieldsUseCase(this._repo);

  Future<Either<Failure, List<CourtEntity>>> call() => _repo.getOwnerFields();
}
