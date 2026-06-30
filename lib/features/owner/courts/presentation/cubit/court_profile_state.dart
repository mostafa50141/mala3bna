import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';

abstract class CourtProfileState {}

class CourtProfileInitial extends CourtProfileState {}

class CourtProfileLoading extends CourtProfileState {}

class CourtProfileLoaded extends CourtProfileState {
  final CourtEntity courtProfile;

  CourtProfileLoaded(this.courtProfile);
}

class CourtProfileToggling extends CourtProfileState {
  final CourtEntity courtProfile; // keep showing the court while toggling
  CourtProfileToggling(this.courtProfile);
}

class CourtProfileToggleError extends CourtProfileState {
  final CourtEntity courtProfile;
  final String message;
  CourtProfileToggleError(this.courtProfile, this.message);
}

class CourtProfileError extends CourtProfileState {
  final String message;

  CourtProfileError(this.message);
}
