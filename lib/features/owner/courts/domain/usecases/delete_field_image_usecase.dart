import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';

class DeleteFieldImageUseCase {
  final CourtRepository _repo;
  const DeleteFieldImageUseCase(this._repo);

  Future<Either<Failure, void>> call(String imageId) =>
      _repo.deleteFieldImage(imageId);
}
