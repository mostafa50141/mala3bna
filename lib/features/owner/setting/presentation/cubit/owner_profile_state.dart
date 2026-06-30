import 'package:mala3bna/features/owner/setting/domain/entities/user_entity.dart';

abstract class OwnerProfileState {}

class OwnerProfileInitial extends OwnerProfileState {}

class OwnerProfileLoading extends OwnerProfileState {}

class OwnerProfileLoaded extends OwnerProfileState {
  final UserEntity profile;

  OwnerProfileLoaded(this.profile);
}

class OwnerProfileError extends OwnerProfileState {
  final String message;

  OwnerProfileError(this.message);
}

class OwnerProfileUpdating extends OwnerProfileState {
  final UserEntity profile;

  OwnerProfileUpdating(this.profile);
}

class OwnerProfileUpdateSuccess extends OwnerProfileState {
  final UserEntity profile;

  OwnerProfileUpdateSuccess(this.profile);
}

class OwnerProfileUpdateError extends OwnerProfileState {
  final String message;
  final UserEntity profile;

  OwnerProfileUpdateError(this.message, this.profile);
}
