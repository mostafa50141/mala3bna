import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/setting/domain/entities/user_entity.dart';
import 'package:mala3bna/features/owner/setting/domain/repositories/setting_repository.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_state.dart';

class OwnerProfileCubit extends Cubit<OwnerProfileState> {
  final SettingRepository _repository;

  OwnerProfileCubit(this._repository) : super(OwnerProfileInitial());

  Future<void> loadProfile() async {
    emit(OwnerProfileLoading());
    final result = await _repository.fetchProfile();
    result.fold(
      (failure) => emit(OwnerProfileError(failure.errmessage ?? 'Failed to load profile.')),
      (user) => emit(OwnerProfileLoaded(user)),
    );
  }

  Future<void> updateProfile(UserEntity updatedUser, {File? imageFile}) async {
    UserEntity? oldUser;
    if (state is OwnerProfileLoaded) {
      oldUser = (state as OwnerProfileLoaded).profile;
    } else if (state is OwnerProfileUpdateSuccess) {
      oldUser = (state as OwnerProfileUpdateSuccess).profile;
    } else if (state is OwnerProfileUpdateError) {
      oldUser = (state as OwnerProfileUpdateError).profile;
    } else if (state is OwnerProfileUpdating) {
      oldUser = (state as OwnerProfileUpdating).profile;
    }

    if (oldUser == null) {
      print('[Setting] Cubit: updateProfile called but oldUser is null — state is ${state.runtimeType}');
      return;
    }

    print('[Setting] Cubit: sending update → name=${updatedUser.name}, phone=${updatedUser.phoneNumber}');
    emit(OwnerProfileUpdating(oldUser));
    final result = await _repository.updateProfile(updatedUser, imageFile: imageFile);
    result.fold(
      (failure) {
        print('[Setting] Cubit: update FAILED — ${failure.errmessage}');
        emit(OwnerProfileUpdateError(
          failure.errmessage ?? 'Failed to save changes.',
          oldUser!,
        ));
      },
      (user) {
        print('[Setting] Cubit: update SUCCESS — name=${user.name}');
        emit(OwnerProfileUpdateSuccess(user));
      },
    );
  }
}
