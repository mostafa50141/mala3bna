import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/owner/booking/domain/entities/booking_entity.dart';
import 'package:mala3bna/features/owner/booking/domain/repositories/booking_repository.dart';

class DeclineBookingUseCase {
  final BookingRepository repository;

  DeclineBookingUseCase(this.repository);

  Future<Either<Failure, BookingEntity>> call(String id) {
    return repository.declineBooking(id);
  }
}
