import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/privacy_state.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  PrivacyCubit() : super(const PrivacyState());

  /// Simulates fetching privacy policy content from an API.
  /// Replace the Future.delayed with a real repository call in production.
  Future<void> loadPolicy() async {
    emit(state.copyWith(status: PrivacyStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      emit(state.copyWith(status: PrivacyStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
        status: PrivacyStatus.error,
        errorMessage: 'Failed to load Privacy Policy. Please try again.',
      ));
    }
  }
}
