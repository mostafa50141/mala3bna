import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/setting/data/repo/owner_profile_repository.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_state.dart';
import 'package:mala3bna/features/owner/setting/presentation/model/owner_profile_model.dart';

class OwnerProfileCubit extends Cubit<OwnerProfileState> {
  final OwnerProfileRepository _repository;

  OwnerProfileCubit(this._repository) : super(OwnerProfileInitial());

  Future<void> loadProfile() async {
    emit(OwnerProfileLoading());
    try {
      final profile = await _repository.fetchProfile();
      emit(OwnerProfileLoaded(profile));
    } catch (e) {
      emit(OwnerProfileError("Failed to load profile data."));
    }
  }

  Future<void> updateProfile(OwnerProfileModel updatedProfile) async {
    // Keep a reference to the old profile in case of failure
    OwnerProfileModel? oldProfile;
    if (state is OwnerProfileLoaded) {
      oldProfile = (state as OwnerProfileLoaded).profile;
    } else if (state is OwnerProfileUpdateSuccess) {
      oldProfile = (state as OwnerProfileUpdateSuccess).profile;
    }

    if (oldProfile == null) return;

    emit(OwnerProfileUpdating(oldProfile));
    try {
      await _repository.updateProfile(updatedProfile);
      emit(OwnerProfileUpdateSuccess(updatedProfile));
    } catch (e) {
      emit(OwnerProfileUpdateError("Failed to save changes. Please try again.", oldProfile));
    }
  }
}
