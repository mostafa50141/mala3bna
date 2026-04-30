import 'package:mala3bna/features/owner/booking/presentation/model/booking_request_model.dart';

enum BookingFilter { all, pending, approved, declined }

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookingRequest> allBookings;
  final BookingFilter activeFilter;

  /// IDs currently processing (accept/decline in progress)
  final Set<String> processingIds;

  BookingLoaded({
    required this.allBookings,
    this.activeFilter = BookingFilter.pending,
    this.processingIds = const {},
  });

  List<BookingRequest> get filtered {
    switch (activeFilter) {
      case BookingFilter.all:
        return allBookings;
      case BookingFilter.pending:
        return allBookings
            .where((b) => b.status == BookingStatus.pending)
            .toList();
      case BookingFilter.approved:
        return allBookings
            .where((b) => b.status == BookingStatus.approved)
            .toList();
      case BookingFilter.declined:
        return allBookings
            .where((b) => b.status == BookingStatus.declined)
            .toList();
    }
  }

  int get pendingCount =>
      allBookings.where((b) => b.status == BookingStatus.pending).length;

  BookingLoaded copyWith({
    List<BookingRequest>? allBookings,
    BookingFilter? activeFilter,
    Set<String>? processingIds,
  }) {
    return BookingLoaded(
      allBookings: allBookings ?? this.allBookings,
      activeFilter: activeFilter ?? this.activeFilter,
      processingIds: processingIds ?? this.processingIds,
    );
  }
}

class BookingError extends BookingState {
  final String message;
  BookingError(this.message);
}
