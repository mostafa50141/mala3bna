import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';

class AddFieldUseCase {
  final CourtRepository _repo;
  const AddFieldUseCase(this._repo);

  Future<Either<Failure, CourtEntity>> call({
    required String title,
    required double hourlyRate,
    required String address,
    required String sportType,
    required List<String> amenityIds,
  }) =>
      _repo.addField(
        title: title,
        hourlyRate: hourlyRate,
        address: address,
        sportType: sportType,
        amenityIds: amenityIds,
      );
}
