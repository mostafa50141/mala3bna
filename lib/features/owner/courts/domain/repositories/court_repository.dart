import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';

/// Domain contract for court/field operations.
/// All methods return [Either<Failure, T>] — no raw exceptions leak upward.
abstract class CourtRepository {
  /// GET /api/v1/fields/
  Future<Either<Failure, List<CourtEntity>>> getOwnerFields();

  /// GET /api/v1/fields/{id}/
  Future<Either<Failure, CourtEntity>> getFieldDetails(String id);

  /// POST /api/v1/fields/
  Future<Either<Failure, CourtEntity>> addField({
    required String title,
    required double hourlyRate,
    required String address,
    required String sportType,
    required List<String> amenityIds,
  });

  /// PATCH /api/v1/fields/{id}/
  Future<Either<Failure, CourtEntity>> updateField({
    required String id,
    String? title,
    double? hourlyRate,
    double? offPeakRate,
    double? membershipDiscount,
    String? address,
    List<String>? amenityIds,
    String? sportType,
  });

  /// POST /api/v1/fields/{id}/toggle-status/
  Future<Either<Failure, bool>> toggleFieldStatus(
    String id, {
    String? maintenanceType,
    String? maintenanceDescription,
  });

  /// POST /api/v1/field_images/  (multipart)
  Future<Either<Failure, CourtImageEntity>> uploadFieldImage({
    required String fieldId,
    required String filePath,
  });

  /// DELETE /api/v1/field_images/{imageId}/
  Future<Either<Failure, void>> deleteFieldImage(String imageId);
}
