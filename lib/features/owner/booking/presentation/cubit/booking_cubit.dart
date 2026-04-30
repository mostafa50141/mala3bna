import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/booking/data/booking_repository.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_state.dart';
import 'package:mala3bna/features/owner/booking/presentation/model/booking_request_model.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository _repo;

  BookingCubit(this._repo) : super(BookingInitial());

  // ── Load ────────────────────────────────────────────────────────────────────
  Future<void> loadBookings() async {
    emit(BookingLoading());
    try {
      final bookings = await _repo.fetchBookings();
      emit(BookingLoaded(allBookings: bookings));
    } catch (e) {
      emit(BookingError('Failed to load bookings. Please try again.'));
    }
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
    emit(current.copyWith(
        processingIds: {...current.processingIds, id}));

    try {
      await _repo.acceptBooking(id);

      final updated = current.allBookings.map((b) {
        return b.id == id ? b.copyWith(status: BookingStatus.approved) : b;
      }).toList();

      final newProcessing = Set<String>.from(current.processingIds)..remove(id);
      emit(current.copyWith(
          allBookings: updated, processingIds: newProcessing));
    } catch (_) {
      // Rollback
      final newProcessing = Set<String>.from(current.processingIds)..remove(id);
      emit(current.copyWith(processingIds: newProcessing));
    }
  }

  // ── Decline ─────────────────────────────────────────────────────────────────
  Future<void> declineBooking(String id) async {
    final current = state;
    if (current is! BookingLoaded) return;

    emit(current.copyWith(
        processingIds: {...current.processingIds, id}));

    try {
      await _repo.declineBooking(id);

      final updated = current.allBookings.map((b) {
        return b.id == id ? b.copyWith(status: BookingStatus.declined) : b;
      }).toList();

      final newProcessing = Set<String>.from(current.processingIds)..remove(id);
      emit(current.copyWith(
          allBookings: updated, processingIds: newProcessing));
    } catch (_) {
      final newProcessing = Set<String>.from(current.processingIds)..remove(id);
      emit(current.copyWith(processingIds: newProcessing));
    }
  }
}
