import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/courts/data/datasources/court_remote_data_source.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';

class CourtRepositoryImpl implements CourtRepository {
  final CourtRemoteDataSource remoteDataSource;

  CourtRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CourtEntity>>> getOwnerFields() async {
    try {
      final models = await remoteDataSource.getOwnerFields();
      return Right(models.map((model) => model.toEntity()).toList());
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourtEntity>> getFieldDetails(String id) async {
    try {
      final model = await remoteDataSource.getFieldDetails(id);
      return Right(model.toEntity());
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourtEntity>> addField({
    required String title,
    required double hourlyRate,
    required String address,
    required List<String> amenityIds,
  }) async {
    try {
      final model = await remoteDataSource.addField(
        title: title,
        hourlyRate: hourlyRate,
        address: address,
        amenityIds: amenityIds,
      );
      return Right(model.toEntity());
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourtEntity>> updateField({
    required String id,
    String? title,
    double? hourlyRate,
    String? address,
    List<String>? amenityIds,
  }) async {
    try {
      final model = await remoteDataSource.updateField(
        id: id,
        title: title,
        hourlyRate: hourlyRate,
        address: address,
        amenityIds: amenityIds,
      );
      return Right(model.toEntity());
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFieldStatus(String id) async {
    try {
      final newStatus = await remoteDataSource.toggleFieldStatus(id);
      return Right(newStatus);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourtImageEntity>> uploadFieldImage({
    required String fieldId,
    required String filePath,
  }) async {
    try {
      final model = await remoteDataSource.uploadFieldImage(fieldId, filePath);
      return Right(model.toEntity());
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFieldImage(String imageId) async {
    try {
      await remoteDataSource.deleteFieldImage(imageId);
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
