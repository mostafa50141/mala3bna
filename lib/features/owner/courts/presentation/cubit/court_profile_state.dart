import 'package:mala3bna/features/owner/courts/presentation/model/court_profile_model.dart';

abstract class CourtProfileState {}

class CourtProfileInitial extends CourtProfileState {}

class CourtProfileLoading extends CourtProfileState {}

class CourtProfileLoaded extends CourtProfileState {
  final CourtProfileModel courtProfile;

  CourtProfileLoaded(this.courtProfile);
}

class CourtProfileError extends CourtProfileState {
  final String message;

  CourtProfileError(this.message);
}
