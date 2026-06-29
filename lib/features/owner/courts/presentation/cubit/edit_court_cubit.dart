import 'package:bloc/bloc.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';
import 'package:mala3bna/features/owner/courts/domain/usecases/update_field_usecase.dart';
import 'edit_court_state.dart';

class EditCourtCubit extends Cubit<EditCourtState> {
  final CourtRepository repository;
  late final UpdateFieldUseCase updateUseCase;

  CourtEntity? _court;

  EditCourtCubit({required this.repository})
      : super(EditCourtInitial()) {
    updateUseCase = UpdateFieldUseCase(repository);
  }

  CourtEntity? get court => _court;

  Future<void> loadCourt(String id) async {
    emit(EditCourtLoading());
    final result = await repository.getFieldDetails(id);
    result.fold(
      (failure) => emit(EditCourtError(failure.errmessage ?? 'Failed to load court')),
      (c) {
        _court = c;
        emit(EditCourtLoaded(court: c));
      },
    );
  }

  Future<void> pickAndUploadImage(String filePath) async {
    if (_court == null) return;
    final currentImages = List<CourtImageEntity>.from(_court!.images);
    emit(EditCourtImageUploading(images: currentImages));

    final result = await repository.uploadFieldImage(
      fieldId: _court!.id,
      filePath: filePath,
    );

    result.fold(
      (failure) => emit(EditCourtError(failure.errmessage ?? 'Image upload failed')),
      (uploaded) {
        currentImages.add(uploaded);
        _court = _court!.copyWith(images: currentImages);
        emit(EditCourtLoaded(court: _court!));
      },
    );
  }

  Future<void> removeImage(String imageId) async {
    if (_court == null) return;
    final currentImages = List<CourtImageEntity>.from(_court!.images);
    final result = await repository.deleteFieldImage(imageId);

    result.fold(
      (failure) => emit(EditCourtError(failure.errmessage ?? 'Failed to remove image')),
      (_) {
        currentImages.removeWhere((i) => i.id == imageId);
        _court = _court!.copyWith(images: currentImages);
        emit(EditCourtImageRemoved(images: currentImages));
        emit(EditCourtLoaded(court: _court!));
      },
    );
  }

  /// Validate form fields locally
  EditCourtState validate({
    required String peakRate,
    required List<CourtImageEntity> images,
    required String address,
  }) {
    final errors = <String, String>{};
    final parsed = double.tryParse(peakRate);
    if (peakRate.isEmpty || parsed == null || parsed <= 0) {
      errors['peakRate'] = 'Peak rate is required and must be positive';
    }
    if (images.isEmpty) errors['images'] = 'Add at least one image';
    if (address.trim().isEmpty) errors['address'] = 'Address is required';

    if (errors.isNotEmpty) {
      final state = EditCourtFormValidation(errors);
      emit(state);
      return state;
    }
    return EditCourtLoaded(court: _court!);
  }

  Future<void> saveChanges({
    required String peakRate,
    required String offPeakRate,
    required String membershipDiscount,
    required List<String> amenityIds,
    required String address,
  }) async {
    if (_court == null) return;
    final parsedPeak = double.tryParse(peakRate) ?? 0.0;
    final parsedOffPeak = double.tryParse(offPeakRate) ?? 0.0;
    final parsedDiscount = double.tryParse(membershipDiscount) ?? 0.0;

    final validationState = validate(
      peakRate: peakRate,
      images: _court!.images,
      address: address,
    );
    if (validationState is EditCourtFormValidation) return;

    emit(EditCourtSaving());

    final result = await updateUseCase(
      id: _court!.id,
      hourlyRate: parsedPeak, // peak is the main price sent to API
      offPeakRate: parsedOffPeak,
      membershipDiscount: parsedDiscount,
      address: address,
      amenityIds: amenityIds,
    );

    result.fold(
      (failure) => emit(EditCourtError(failure.errmessage ?? 'Failed to save changes')),
      (updatedCourt) {
        _court = updatedCourt.copyWith(
          offPeakRate: parsedOffPeak,
          peakRate: parsedPeak,
          membershipDiscount: parsedDiscount,
        );
        emit(EditCourtSuccess());
        emit(EditCourtLoaded(court: _court!));
      },
    );
  }
}
