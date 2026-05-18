import 'package:bloc/bloc.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

/// Cubit responsible solely for the navigation decision made after
/// the splash animation completes.
///
/// It reads the persisted auth token from [LocalStorageHelper] and emits
/// the appropriate navigation state. The UI layer ([SplashScreenBody])
/// listens via [BlocListener] and executes the actual [Get.offAll] call.
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  final LocalStorageHelper _storage = getIt.get<LocalStorageHelper>();

  /// Called exactly once, after the main animation controller completes.
  Future<void> checkNavigationTarget() async {
    if (isClosed) return;
    emit(SplashNavigating());

    try {
      final token = await _storage.gettoken();
      if (isClosed) return;

      // A non-empty token means the user has already authenticated.
      if (token != null && token.isNotEmpty) {
        emit(SplashNavigateToHome());
      } else {
        final onboardingSeen = await _storage.isOnboardingSeen();
        if (isClosed) return;
        if (onboardingSeen) {
          emit(SplashNavigateToWelcome());
        } else {
          emit(SplashNavigateToOnboarding());
        }
      }
    } catch (_) {
      // On any unexpected storage error, fall back to the welcome flow.
      if (!isClosed) emit(SplashNavigateToWelcome());
    }
  }
}
