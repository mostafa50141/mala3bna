import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/booking/domain/entities/booking_entity.dart';
import 'package:mala3bna/features/owner/booking/domain/repositories/booking_repository.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository _repo;

  BookingCubit(this._repo) : super(BookingInitial());

  // ── Load ────────────────────────────────────────────────────────────────────
  Future<void> loadBookings() async {
    emit(BookingLoading());
    final result = await _repo.fetchBookings();
    result.fold(
      (failure) =>
          emit(BookingError('Failed to load bookings. Please try again.')),
      (bookings) => emit(BookingLoaded(allBookings: bookings)),
    );
  }

  // ── Filter ──────────────────────────────────────────────────────────────────
  void setFilter(BookingFilter filter) {
    final current = state;
    if (current is BookingLoaded) {
      emit(current.copyWith(activeFilter: filter));
    }
  }

  // ── Accept ──────────────────────────────────────────────────────────────────
  Future<void> acceptBooking(String id) async {
    final current = state;
    if (current is! BookingLoaded) return;

    // Optimistic: show spinner on card
    emit(current.copyWith(processingIds: {...current.processingIds, id}));

    final result = await _repo.acceptBooking(id);

    result.fold(
      (failure) {
        print('[BookingCubit] acceptBooking failed: ${failure.errmessage}');
        // Remove spinner & show error message to user
        final rolledBack = current.copyWith(
          processingIds: Set<String>.from(current.processingIds)..remove(id),
        );
        emit(BookingActionError(
          message: failure.errmessage ?? 'Failed to accept booking',
          previousState: rolledBack,
        ));
        // Re-emit loaded state so UI can rebuild normally
        emit(rolledBack);
      },
      (_) {
        // Ignore the incomplete API response
        final updated = current.allBookings.map((b) {
          return b.id == id ? b.copyWith(status: BookingStatus.approved) : b;
        }).toList();

        final newProcessing = Set<String>.from(current.processingIds)
          ..remove(id);
        // Auto-switch to Approved tab so the user sees the booking moved
        emit(
          current.copyWith(
            allBookings: updated,
            processingIds: newProcessing,
            activeFilter: BookingFilter.approved,
          ),
        );
      },
    );
  }

  // ── Decline ─────────────────────────────────────────────────────────────────
  Future<void> declineBooking(String id) async {
    final current = state;
    if (current is! BookingLoaded) return;

    emit(current.copyWith(processingIds: {...current.processingIds, id}));

    final result = await _repo.declineBooking(id);

    result.fold(
      (failure) {
        // Remove spinner & show error message to user
        final rolledBack = current.copyWith(
          processingIds: Set<String>.from(current.processingIds)..remove(id),
        );
        emit(BookingActionError(
          message: failure.errmessage ?? 'Failed to decline booking',
          previousState: rolledBack,
        ));
        emit(rolledBack);
      },
      (_) {
        // Ignore the incomplete API response
        final updated = current.allBookings.map((b) {
          return b.id == id ? b.copyWith(status: BookingStatus.declined) : b;
        }).toList();

        final newProcessing = Set<String>.from(current.processingIds)
          ..remove(id);
        // Auto-switch to Declined tab so the user sees the booking moved
        emit(
          current.copyWith(
            allBookings: updated,
            processingIds: newProcessing,
            activeFilter: BookingFilter.declined,
          ),
        );
      },
    );
  }
}
