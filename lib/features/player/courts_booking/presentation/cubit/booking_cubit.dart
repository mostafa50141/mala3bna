import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/player/courts_booking/data/repos/booking_repo.dart';
import 'package:mala3bna/features/player/courts_booking/presentation/cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepo bookingRepo;
  BookingCubit(this.bookingRepo) : super(BookingInitial());

  Future<void> createBooking({
    required int fieldId,
    required DateTime bookingDate,
    required String startTime,
  }) async {
    emit(BookingLoading());
    
    // Parse start time and add 1 hour for end time
    final timeParts = startTime.split(':');
    final startHour = int.tryParse(timeParts[0]) ?? 0;
    final startMinute = int.tryParse(timeParts.length > 1 ? timeParts[1] : '0') ?? 0;
    final endHour = (startHour + 1) % 24;
    
    final dateStr = DateFormat('yyyy-MM-dd').format(bookingDate);
    final startStr = '${startHour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}:00';
    final endStr = '${endHour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}:00';

    var result = await bookingRepo.createBooking(
      fieldId: fieldId,
      bookingDate: dateStr,
      startTime: startStr,
      endTime: endStr,
    );
    result.fold(
      (failure) => emit(BookingFailure(failure.errmessage ?? 'Booking failed')),
      (booking) => emit(BookingSuccess(booking: booking)),
    );
  }

  Future<void> getBookings() async {
    emit(BookingLoading());
    var result = await bookingRepo.getBookings();
    result.fold(
      (failure) => emit(BookingFailure(failure.errmessage ?? 'Failed to load bookings')),
      (bookings) => emit(BookingsLoaded(bookings: bookings)),
    );
  }

  Future<void> cancelBooking({required int bookingId}) async {
    var result = await bookingRepo.cancelBooking(bookingId: bookingId);
    result.fold(
      (failure) => emit(BookingFailure(failure.errmessage ?? 'Cancel failed')),
      (_) {
        emit(BookingCancelled());
        getBookings(); // reload list after cancel
      },
    );
  }
}
