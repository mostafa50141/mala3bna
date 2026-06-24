import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';

class GetFieldDetailsUseCase {
  final CourtRepository _repo;
  const GetFieldDetailsUseCase(this._repo);

  Future<Either<Failure, CourtEntity>> call(String id) =>
      _repo.getFieldDetails(id);
}
