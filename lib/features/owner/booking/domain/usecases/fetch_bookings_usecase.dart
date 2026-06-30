import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/booking/domain/entities/booking_entity.dart';
import 'package:mala3bna/features/owner/booking/domain/repositories/booking_repository.dart';

class FetchBookingsUseCase {
  final BookingRepository repository;

  FetchBookingsUseCase(this.repository);

  Future<Either<Failure, List<BookingEntity>>> call() {
    return repository.fetchBookings();
  }
}
