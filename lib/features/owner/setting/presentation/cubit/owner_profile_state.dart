import 'package:mala3bna/features/owner/setting/presentation/model/owner_profile_model.dart';

abstract class OwnerProfileState {}

class OwnerProfileInitial extends OwnerProfileState {}

class OwnerProfileLoading extends OwnerProfileState {}

class OwnerProfileLoaded extends OwnerProfileState {
  final OwnerProfileModel profile;

  OwnerProfileLoaded(this.profile);
}

class OwnerProfileError extends OwnerProfileState {
  final String message;

  OwnerProfileError(this.message);
}

class OwnerProfileUpdating extends OwnerProfileState {
  final OwnerProfileModel profile;

  OwnerProfileUpdating(this.profile);
}

class OwnerProfileUpdateSuccess extends OwnerProfileState {
  final OwnerProfileModel profile;

  OwnerProfileUpdateSuccess(this.profile);
}

class OwnerProfileUpdateError extends OwnerProfileState {
  final String message;
  final OwnerProfileModel profile;

  OwnerProfileUpdateError(this.message, this.profile);
}
