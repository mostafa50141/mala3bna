import 'package:mala3bna/features/owner/booking/domain/entities/booking_entity.dart';

enum BookingFilter { all, pending, approved, declined }

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookingEntity> allBookings;
  final BookingFilter activeFilter;

  /// IDs currently processing (accept/decline in progress)
  final Set<String> processingIds;

  BookingLoaded({
    required this.allBookings,
    this.activeFilter = BookingFilter.pending,
    this.processingIds = const {},
  });

  List<BookingEntity> get filtered {
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
    List<BookingEntity>? allBookings,
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

/// Emitted transiently when accept/decline fails — lets UI show a SnackBar
/// then the Cubit re-emits the previous BookingLoaded state.
class BookingActionError extends BookingState {
  final String message;
  final BookingLoaded previousState;
  BookingActionError({required this.message, required this.previousState});
}
