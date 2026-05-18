import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_constants.dart';


part 'onboarding_state.dart';

/// Owns all onboarding business logic:
/// - tracks the current page index
/// - drives the [PageController] that is handed to the view
/// - persists completion via [LocalStorageHelper]
/// - emits typed states for the UI to react to
///
/// Navigation is intentionally kept in the UI layer (BlocListener +
/// Get.offAll) so this cubit stays framework-agnostic.
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit()
      : _pageController = PageController(initialPage: 0),
        super(OnboardingInitial());

  final PageController _pageController;
  final LocalStorageHelper _storage = getIt.get<LocalStorageHelper>();

  int _currentPage = 0;

  // ─── Public accessors ──────────────────────────────────────────────────────

  /// The [PageController] to attach to the [PageView] in the UI.
  PageController get pageController => _pageController;

  /// Zero-based index of the currently visible page.
  int get currentPage => _currentPage;

  bool get isLastPage => _currentPage == OnboardingConstants.pageCount - 1;

  // ─── Event handlers ────────────────────────────────────────────────────────

  /// Called by [PageView.onPageChanged] — syncs internal state with the
  /// physical scroll position (handles swipe gestures from the user).
  void onPageChanged(int index) {
    if (isClosed) return;
    _currentPage = index;
    emit(OnboardingPageChanged(
      currentPage: index,
      isLastPage: index == OnboardingConstants.pageCount - 1,
    ));
  }

  /// Advances to the next page, or completes onboarding if already on last.
  void nextPage() {
    if (isLastPage) {
      _complete();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Skips directly to [WelcomeScreen] without finishing all pages.
  void skipAll() => _complete();

  // ─── Internal ──────────────────────────────────────────────────────────────

  /// Persists the seen flag and emits [OnboardingCompleted].
  Future<void> _complete() async {
    if (isClosed) return;
    await _storage.saveOnboardingSeen();
    if (!isClosed) emit(OnboardingCompleted());
  }

  @override
  Future<void> close() {
    _pageController.dispose();
    return super.close();
  }
}
