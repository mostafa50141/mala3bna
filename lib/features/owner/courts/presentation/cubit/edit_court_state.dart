import 'package:equatable/equatable.dart';
import '../../data/models/court_model.dart';
import '../../data/models/court_image_model.dart';

abstract class EditCourtState extends Equatable {
  const EditCourtState();

  @override
  List<Object?> get props => [];
}

class EditCourtInitial extends EditCourtState {}

class EditCourtLoading extends EditCourtState {}

class EditCourtLoaded extends EditCourtState {
  final CourtModel court;

  const EditCourtLoaded({required this.court});

  @override
  List<Object?> get props => [court];
}

class EditCourtImageUploading extends EditCourtState {
  final List<CourtImageModel> images;
  const EditCourtImageUploading({required this.images});

  @override
  List<Object?> get props => [images];
}

class EditCourtImageRemoved extends EditCourtState {
  final List<CourtImageModel> images;
  const EditCourtImageRemoved({required this.images});

  @override
  List<Object?> get props => [images];
}

class EditCourtSaving extends EditCourtState {}

class EditCourtSuccess extends EditCourtState {}

class EditCourtError extends EditCourtState {
  final String message;
  const EditCourtError(this.message);

  @override
  List<Object?> get props => [message];
}

class EditCourtFormValidation extends EditCourtState {
  final Map<String, String> errors;
  const EditCourtFormValidation(this.errors);

  @override
  List<Object?> get props => [errors];
}
