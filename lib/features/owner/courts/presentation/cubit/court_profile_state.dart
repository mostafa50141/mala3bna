import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';

abstract class CourtProfileState {}

class CourtProfileInitial extends CourtProfileState {}

class CourtProfileLoading extends CourtProfileState {}

class CourtProfileLoaded extends CourtProfileState {
  final CourtEntity courtProfile;

  CourtProfileLoaded(this.courtProfile);
}

class CourtProfileError extends CourtProfileState {
  final String message;

  CourtProfileError(this.message);
}
