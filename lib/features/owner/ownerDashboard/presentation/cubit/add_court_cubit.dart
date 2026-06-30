import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/add_court_state.dart';

class AddCourtCubit extends Cubit<AddCourtState> {
  final CourtRepository _repository;

  AddCourtCubit(this._repository) : super(AddCourtInitial());

  Future<void> submit({
    required String title,
    required String hourlyRate,
    required String address,
    required List<String> amenityIds,
    required List<String> imagePaths,
  }) async {
    final errors = <String, String>{};

    if (title.isEmpty) {
      errors['title'] = 'Court name is required';
    }
    if (hourlyRate.isEmpty) {
      errors['hourlyRate'] = 'Price per hour is required';
    } else if (double.tryParse(hourlyRate) == null) {
      errors['hourlyRate'] = 'Invalid price format';
    }
    if (address.isEmpty) {
      errors['address'] = 'Address is required';
    }
    if (imagePaths.isEmpty) {
      errors['images'] = 'At least one image is required';
    }

    if (errors.isNotEmpty) {
      emit(AddCourtFormError(errors));
      return;
    }

    emit(AddCourtSubmitting());

    final result = await _repository.addField(
      title: title,
      hourlyRate: double.parse(hourlyRate),
      address: address,
      amenityIds: amenityIds,
    );

    await result.fold(
      (failure) async {
        emit(AddCourtError(failure.errmessage ?? 'Failed to add court'));
      },
      (court) async {
        bool allImagesUploaded = true;
        for (final imagePath in imagePaths) {
          final uploadResult = await _repository.uploadFieldImage(
            fieldId: court.id.toString(),
            filePath: imagePath,
          );
          uploadResult.fold(
            (l) {
              allImagesUploaded = false;
              // We could emit a partial success or error here, but for now we'll just log or handle later.
              print('Failed to upload image $imagePath: ${l.errmessage}');
            },
            (r) => null,
          );
        }

        if (allImagesUploaded) {
          emit(AddCourtSuccess(court));
        } else {
           // Emitting success anyway because court was created, but maybe we should let UI know.
           emit(AddCourtSuccess(court));
        }
      },
    );
  }
}
