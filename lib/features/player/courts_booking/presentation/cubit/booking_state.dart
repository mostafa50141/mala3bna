import 'package:meta/meta.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/booking_model.dart';

@immutable
sealed class BookingState {}
final class BookingInitial extends BookingState {}
final class BookingLoading extends BookingState {}
final class BookingSuccess extends BookingState {
  final BookingModel booking;
  BookingSuccess({required this.booking});
}
final class BookingsLoaded extends BookingState {
  final List<BookingModel> bookings;
  BookingsLoaded({required this.bookings});
}
final class BookingFailure extends BookingState {
  final String errorMessage;
  BookingFailure(this.errorMessage);
}
final class BookingCancelled extends BookingState {}
