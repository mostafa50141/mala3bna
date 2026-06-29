import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/player/profile/data/repos/user_profile_repo.dart';
import 'package:mala3bna/features/player/profile/presentation/cubit/user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepo repo;
  UserProfileCubit(this.repo) : super(UserProfileInitial());

  Future<void> getProfile() async {
    emit(UserProfileLoading());
    var result = await repo.getProfile();
    result.fold(
      (failure) => emit(UserProfileFailure(failure.errmessage ?? 'Failed to load profile')),
      (profile) {
        // Save to local storage
        getIt.get<LocalStorageHelper>().saveUserData(
          name: profile.fullName,
          email: profile.email,
          phone: profile.phoneNumber ?? '',
          userType: 'player',
        );
        emit(UserProfileLoaded(profile: profile));
      },
    );
  }

  Future<void> updateProfile({
    required String fullName,
    required String username,
    String? phoneNumber,
    String? bio,
    File? profileImage,
  }) async {
    emit(UserProfileLoading());
    var result = await repo.updateProfile(
      fullName: fullName,
      username: username,
      phoneNumber: phoneNumber,
      bio: bio,
      profileImage: profileImage,
    );
    result.fold(
      (failure) => emit(UserProfileFailure(failure.errmessage ?? 'Update failed')),
      (profile) {
        getIt.get<LocalStorageHelper>().saveUserData(
          name: profile.fullName,
          email: profile.email,
          phone: profile.phoneNumber ?? '',
          userType: 'player',
        );
        emit(UserProfileUpdated(profile: profile));
      },
    );
  }

  Future<void> deleteAccount({required String password}) async {
    emit(UserProfileDeleting());
    var result = await repo.deleteAccount(password: password);
    result.fold(
      (failure) => emit(
        UserProfileDeleteFailure(failure.errmessage ?? 'Failed to delete account'),
      ),
      (_) async {
        await getIt.get<LocalStorageHelper>().deletetoken();
        await getIt.get<LocalStorageHelper>().deleteUserData();
        emit(UserProfileDeleted());
      },
    );
  }
}
