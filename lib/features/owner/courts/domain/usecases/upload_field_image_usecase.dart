import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';

class UploadFieldImageUseCase {
  final CourtRepository _repo;
  const UploadFieldImageUseCase(this._repo);

  Future<Either<Failure, CourtImageEntity>> call({
    required String fieldId,
    required String filePath,
  }) =>
      _repo.uploadFieldImage(fieldId: fieldId, filePath: filePath);
}
