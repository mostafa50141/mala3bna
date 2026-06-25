import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';

class ToggleFieldStatusUseCase {
  final CourtRepository _repo;
  const ToggleFieldStatusUseCase(this._repo);

  Future<Either<Failure, bool>> call(String id) =>
      _repo.toggleFieldStatus(id);
}
