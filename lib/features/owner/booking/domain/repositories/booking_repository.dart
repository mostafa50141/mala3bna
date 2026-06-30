import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/booking/domain/entities/booking_entity.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<BookingEntity>>> fetchBookings();
  Future<Either<Failure, BookingEntity>> acceptBooking(String id);
  Future<Either<Failure, BookingEntity>> declineBooking(String id);
}
