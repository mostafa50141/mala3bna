import 'package:meta/meta.dart';
import 'package:mala3bna/features/player/profile/data/models/user_profile_model.dart';

@immutable
sealed class UserProfileState {}
final class UserProfileInitial extends UserProfileState {}
final class UserProfileLoading extends UserProfileState {}
final class UserProfileLoaded extends UserProfileState {
  final UserProfileModel profile;
  UserProfileLoaded({required this.profile});
}
final class UserProfileUpdated extends UserProfileState {
  final UserProfileModel profile;
  UserProfileUpdated({required this.profile});
}
final class UserProfileFailure extends UserProfileState {
  final String errorMessage;
  UserProfileFailure(this.errorMessage);
}

final class UserProfileDeleting extends UserProfileState {}
final class UserProfileDeleted extends UserProfileState {}
final class UserProfileDeleteFailure extends UserProfileState {
  final String errorMessage;
  UserProfileDeleteFailure(this.errorMessage);
}
