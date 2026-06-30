import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/terms_state.dart';

class TermsCubit extends Cubit<TermsState> {
  TermsCubit() : super(const TermsState());

  /// Called when the scroll position reaches the bottom of the document.
  void onScrolledToBottom() {
    if (!state.hasReadToBottom) {
      emit(state.copyWith(hasReadToBottom: true));
    }
  }

  /// Called when the user taps "Accept & Continue".
  Future<void> accept() async {
    if (!state.canAccept) return;
    emit(state.copyWith(status: TermsStatus.accepting));
    // Simulate a brief confirmation delay (replace with real API call if needed)
    await Future.delayed(const Duration(milliseconds: 800));
    emit(state.copyWith(status: TermsStatus.accepted));
  }
}
