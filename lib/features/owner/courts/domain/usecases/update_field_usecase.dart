import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';

class UpdateFieldUseCase {
  final CourtRepository _repo;
  const UpdateFieldUseCase(this._repo);

  Future<Either<Failure, CourtEntity>> call({
    required String id,
    String? title,
    double? hourlyRate,
    double? offPeakRate,
    double? membershipDiscount,
    String? address,
    List<String>? amenityIds,
    String? sportType,
  }) async {
    return await _repo.updateField(
      id: id,
      title: title,
      hourlyRate: hourlyRate,
      offPeakRate: offPeakRate,
      membershipDiscount: membershipDiscount,
      address: address,
      amenityIds: amenityIds,
      sportType: sportType,
    );
  }
}
