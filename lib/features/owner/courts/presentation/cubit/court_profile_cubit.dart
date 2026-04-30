import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/courts/data/repo/court_profile_repository.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_state.dart';

class CourtProfileCubit extends Cubit<CourtProfileState> {
  final CourtProfileRepository _repository;

  CourtProfileCubit(this._repository) : super(CourtProfileInitial());

  Future<void> loadCourtProfile() async {
    emit(CourtProfileLoading());
    try {
      final data = await _repository.fetchCourtProfile();
      emit(CourtProfileLoaded(data));
    } catch (e) {
      emit(CourtProfileError("Failed to load court profile. Please try again."));
    }
  }
}
