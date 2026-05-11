import 'package:bloc/bloc.dart';

import '../../data/models/court_model.dart';
import '../../data/models/court_image_model.dart';
import '../../data/models/update_court_request.dart';
import '../../domain/repositories/court_repository.dart';
import '../../domain/usecases/update_court_usecase.dart';
import 'edit_court_state.dart';

class EditCourtCubit extends Cubit<EditCourtState> {
  final CourtRepository repository;
  final UpdateCourtUseCase updateUseCase;

  CourtModel? _court;

  EditCourtCubit({required this.repository})
    : updateUseCase = UpdateCourtUseCase(repository),
      super(EditCourtInitial());

  CourtModel? get court => _court;

  Future<void> loadCourt(String id) async {
    emit(EditCourtLoading());
    try {
      final c = await repository.getCourtDetails(id);
      _court = c;
      emit(EditCourtLoaded(court: c));
    } catch (e) {
      emit(EditCourtError('Failed to load court: ${e.toString()}'));
    }
  }

  Future<void> pickAndUploadImage(String filePath) async {
    if (_court == null) return;
    final currentImages = List<CourtImageModel>.from(_court!.images);
    emit(EditCourtImageUploading(images: currentImages));
    try {
      final uploaded = await repository.uploadCourtImage(_court!.id, filePath);
      currentImages.add(uploaded);
      _court = _court!.copyWith(images: currentImages);
      emit(EditCourtLoaded(court: _court!));
    } catch (e) {
      emit(EditCourtError('Image upload failed: ${e.toString()}'));
    }
  }

  Future<void> removeImage(String imageId) async {
    if (_court == null) return;
    final currentImages = List<CourtImageModel>.from(_court!.images);
    try {
      await repository.removeCourtImage(_court!.id, imageId);
      currentImages.removeWhere((i) => i.id == imageId);
      _court = _court!.copyWith(images: currentImages);
      emit(EditCourtImageRemoved(images: currentImages));
      emit(EditCourtLoaded(court: _court!));
    } catch (e) {
      emit(EditCourtError('Failed to remove image: ${e.toString()}'));
    }
  }

  /// Validate form fields locally
  EditCourtState validate({
    required String hourlyRate,
    required List<CourtImageModel> images,
    required double? lat,
    required double? lng,
  }) {
    final errors = <String, String>{};
    final parsed = double.tryParse(hourlyRate);
    if (hourlyRate.isEmpty || parsed == null || parsed <= 0) {
      errors['hourlyRate'] =
          'Hourly rate is required and must be a positive number';
    }
    if (images.isEmpty) errors['images'] = 'Add at least one image';
    if (lat == null || lng == null) errors['location'] = 'Location required';

    if (errors.isNotEmpty) {
      final state = EditCourtFormValidation(errors);
      emit(state);
      return state;
    }
    return EditCourtLoaded(court: _court!);
  }

  Future<void> saveChanges({
    required String hourlyRate,
    required List<String> amenityIds,
    required double lat,
    required double lng,
  }) async {
    if (_court == null) return;
    final parsed = double.tryParse(hourlyRate) ?? 0.0;
    final validationState = validate(
      hourlyRate: hourlyRate,
      images: _court!.images,
      lat: lat,
      lng: lng,
    );
    if (validationState is EditCourtFormValidation) return;

    emit(EditCourtSaving());
    try {
      final request = UpdateCourtRequest(
        id: _court!.id,
        hourlyRate: parsed,
        images: _court!.images,
        amenityIds: amenityIds,
        lat: lat,
        lng: lng,
      );

      await updateUseCase(request);
      emit(EditCourtSuccess());
      // Refresh loaded state with updated values
      _court = _court!.copyWith(
        hourlyRate: parsed,
        amenities: _court!.amenities
            .where((a) => amenityIds.contains(a.id))
            .toList(),
        lat: lat,
        lng: lng,
      );
      emit(EditCourtLoaded(court: _court!));
    } catch (e) {
      emit(EditCourtError('Failed to save changes: ${e.toString()}'));
    }
  }
}
