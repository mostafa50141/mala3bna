import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_state.dart';

class CourtProfileCubit extends Cubit<CourtProfileState> {
  final CourtRepository _repository;
  String? _lastFieldId;

  CourtProfileCubit(this._repository) : super(CourtProfileInitial());

  Future<void> loadCourtProfile([String? fieldId]) async {
    if (fieldId != null) {
      _lastFieldId = fieldId;
    }

    emit(CourtProfileLoading());
    print('[Courts] State: CourtProfileLoading');

    if (_lastFieldId == null) {
      print('[Courts] No fieldId — fetching owner\'s courts list...');
      final fieldsResult = await _repository.getOwnerFields();
      bool hasError = false;
      fieldsResult.fold(
        (failure) {
          print('[Courts] getOwnerFields FAILED: ${failure.errmessage}');
          emit(CourtProfileError(failure.errmessage ?? 'Failed to load courts.'));
          hasError = true;
        },
        (fields) {
          print('[Courts] Court count: ${fields.length}');
          if (fields.isNotEmpty) {
            print('[Courts] First court: id=${fields.first.id}, title=${fields.first.title}');
          }
          if (fields.isEmpty) {
            emit(CourtProfileError('No courts found. Please add a court first.'));
            hasError = true;
          } else {
            _lastFieldId = fields.first.id;
          }
        },
      );

      if (hasError || _lastFieldId == null) return;
    }

    print('[Courts] Loading details for fieldId: $_lastFieldId');
    final result = await _repository.getFieldDetails(_lastFieldId!);

    result.fold(
      (failure) {
        print('[Courts] getFieldDetails FAILED: ${failure.errmessage}');
        emit(CourtProfileError(failure.errmessage ?? 'Failed to load court profile.'));
      },
      (court) {
        print('[Courts] State: CourtProfileLoaded — title=${court.title}, amenities=${court.amenities.length}, images=${court.images.length}');
        emit(CourtProfileLoaded(court));
      },
    );
  }

  /// Toggle the court's active/inactive status via the backend.
  Future<void> toggleStatus({
    String? maintenanceType,
    String? maintenanceDescription,
  }) async {
    final currentState = state;
    // Extract the current court regardless of state variant
    final court = currentState is CourtProfileLoaded
        ? currentState.courtProfile
        : currentState is CourtProfileToggling
            ? currentState.courtProfile
            : currentState is CourtProfileToggleError
                ? currentState.courtProfile
                : null;

    if (court == null) return;

    if (court.id.isEmpty) {
      emit(CourtProfileToggleError(
        court,
        'Error: Court ID is missing. Please restart the app completely.',
      ));
      Future.delayed(
        const Duration(seconds: 3),
        () {
          if (!isClosed) emit(CourtProfileLoaded(court));
        },
      );
      return;
    }

    emit(CourtProfileToggling(court));

    final result = await _repository.toggleFieldStatus(
      court.id,
      maintenanceType: maintenanceType,
      maintenanceDescription: maintenanceDescription,
    );

    result.fold(
      (failure) {
        emit(CourtProfileToggleError(
          court,
          failure.errmessage ?? 'Failed to update court status.',
        ));
        // Revert to loaded after showing the error briefly
        Future.delayed(
          const Duration(seconds: 2),
          () {
            if (!isClosed) emit(CourtProfileLoaded(court));
          },
        );
      },
      (newIsActive) {
        // Create a new court instance with the updated isActive status
        final updatedCourt = court.copyWith(isActive: newIsActive);
        emit(CourtProfileLoaded(updatedCourt));
      },
    );
  }
}
