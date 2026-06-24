import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/booking/data/datasources/booking_remote_data_source.dart';
import 'package:mala3bna/features/owner/booking/domain/entities/booking_entity.dart';
import 'package:mala3bna/features/owner/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BookingEntity>>> fetchBookings() async {
    try {
      final models = await remoteDataSource.fetchBookings();
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookingEntity>> acceptBooking(String id) async {
    try {
      final model = await remoteDataSource.acceptBooking(id);
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookingEntity>> declineBooking(String id) async {
    try {
      final model = await remoteDataSource.declineBooking(id);
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
