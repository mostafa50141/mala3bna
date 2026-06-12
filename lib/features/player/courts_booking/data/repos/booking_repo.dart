import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/booking_model.dart';

abstract class BookingRepo {
  Future<Either<Failure, BookingModel>> createBooking({
    required int fieldId,
    required String bookingDate,
    required String startTime,
    required String endTime,
    String? notes,
  });

  Future<Either<Failure, List<BookingModel>>> getBookings();

  Future<Either<Failure, void>> cancelBooking({required int bookingId});
}
