import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';

abstract class AddCourtState {}

class AddCourtInitial extends AddCourtState {}

class AddCourtSubmitting extends AddCourtState {}

class AddCourtSuccess extends AddCourtState {
  final CourtEntity court;

  AddCourtSuccess(this.court);
}

class AddCourtError extends AddCourtState {
  final String message;

  AddCourtError(this.message);
}

class AddCourtFormError extends AddCourtState {
  final Map<String, String> errors;

  AddCourtFormError(this.errors);
}
