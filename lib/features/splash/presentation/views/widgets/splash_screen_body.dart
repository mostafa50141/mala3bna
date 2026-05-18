import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Hide bloc's Transition to avoid ambiguity with GetX's Transition enum.
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:mala3bna/core/role/app_root.dart';
import 'package:mala3bna/features/onboarding/presentation/views/onboarding_screen.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_app_name.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_background.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_constants.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_logo.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_tagline.dart';
import 'package:mala3bna/features/splash/presentation/views_model/cubit/splash_cubit.dart';
import 'package:mala3bna/features/welcome_screen/presentation/views/welcome_screen.dart';

/// The main body of the splash screen.
///
/// Animation architecture — single controller, interval-based sequencing:
///
///  ┌──────────────────────────────────────────────────────────────────────┐
///  │  0 ms ──── 600 ms    Logo:     scale 0.4→1.0 (easeOutBack) + fade   │
///  │  700 ms ── 1 200 ms  AppName:  slideUp + fade (easeOut)              │
///  │  1 300 ms─ 1 700 ms  Tagline:  fade in (easeIn)                      │
///  │  1 800 ms─ 2 400 ms  Shimmer:  diagonal light sweep on logo          │
///  │  2 400 ms            Controller complete → Cubit emits nav state      │
///  └──────────────────────────────────────────────────────────────────────┘
///
/// A second looping [_bgController] drives the background breathing effect
/// independently, so it doesn't interfere with the main sequence timing.
class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with TickerProviderStateMixin {
  // ─── Controllers ──────────────────────────────────────────────────────────
  late final AnimationController _mainController;
  late final AnimationController _bgController;

  // ─── Main animations ──────────────────────────────────────────────────────
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _nameSlide;
  late final Animation<double> _nameOpacity;
  late final Animation<double> _tagOpacity;
  late final Animation<double> _shimmer;

  // ─── Background breath ────────────────────────────────────────────────────
  late final Animation<double> _bgBreath;

  @override
  void initState() {
    super.initState();
    // Make status bar transparent so the splash fills edge-to-edge.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _initAnimations();
    _mainController.forward();
  }

  void _initAnimations() {
    // ── Main controller (runs once, 2 400 ms) ─────────────────────────────
    _mainController = AnimationController(
      vsync: this,
      duration: SplashConstants.totalDuration,
    )..addStatusListener(_onMainAnimationStatus);

    // ── Background controller (loops, 4 s) ────────────────────────────────
    _bgController = AnimationController(
      vsync: this,
      duration: SplashConstants.bgBreathDuration,
    )..repeat(reverse: true);

    _bgBreath = CurvedAnimation(
      parent: _bgController,
      curve: Curves.easeInOut,
    );

    // ── Logo scale ────────────────────────────────────────────────────────
    _logoScale = Tween<double>(
      begin: SplashConstants.logoScaleBegin,
      end: SplashConstants.logoScaleEnd,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(
          SplashConstants.logoScaleIntervalStart,
          SplashConstants.logoScaleIntervalEnd,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    // ── Logo opacity ──────────────────────────────────────────────────────
    _logoOpacity = Tween<double>(
      begin: SplashConstants.logoOpacityBegin,
      end: SplashConstants.logoOpacityEnd,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(
          SplashConstants.logoOpacityIntervalStart,
          SplashConstants.logoOpacityIntervalEnd,
          curve: Curves.easeIn,
        ),
      ),
    );

    // ── App name slide ────────────────────────────────────────────────────
    _nameSlide = Tween<Offset>(
      begin: Offset(0.0, SplashConstants.nameSlideBeginDy),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(
          SplashConstants.nameSlideIntervalStart,
          SplashConstants.nameSlideIntervalEnd,
          curve: Curves.easeOut,
        ),
      ),
    );

    // ── App name opacity ──────────────────────────────────────────────────
    _nameOpacity = Tween<double>(
      begin: SplashConstants.nameOpacityBegin,
      end: SplashConstants.nameOpacityEnd,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(
          SplashConstants.nameOpacityIntervalStart,
          SplashConstants.nameOpacityIntervalEnd,
          curve: Curves.easeIn,
        ),
      ),
    );

    // ── Tagline opacity ───────────────────────────────────────────────────
    _tagOpacity = Tween<double>(
      begin: SplashConstants.tagOpacityBegin,
      end: SplashConstants.tagOpacityEnd,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(
          SplashConstants.tagOpacityIntervalStart,
          SplashConstants.tagOpacityIntervalEnd,
          curve: Curves.easeIn,
        ),
      ),
    );

    // ── Shimmer sweep ─────────────────────────────────────────────────────
    _shimmer = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(
          SplashConstants.shimmerIntervalStart,
          SplashConstants.shimmerIntervalEnd,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  /// Fired when [_mainController] reaches `completed`.
  /// Delegates the navigation decision to [SplashCubit].
  void _onMainAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      context.read<SplashCubit>().checkNavigationTarget();
    }
  }

  @override
  void dispose() {
    _mainController.removeStatusListener(_onMainAnimationStatus);
    _mainController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: _onSplashState,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SplashBackground(
          breathAnimation: _bgBreath,
          child: SafeArea(
            // Extend gradient behind status bar / home indicator
            top: false,
            bottom: false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Logo ──────────────────────────────────────────────
                  SplashLogo(
                    scaleAnimation: _logoScale,
                    opacityAnimation: _logoOpacity,
                    shimmerAnimation: _shimmer,
                  ),

                  const SizedBox(height: SplashConstants.verticalSpacingLogo),

                  // ── App name ──────────────────────────────────────────
                  SplashAppName(
                    slideAnimation: _nameSlide,
                    opacityAnimation: _nameOpacity,
                  ),

                  const SizedBox(
                    height: SplashConstants.verticalSpacingTagline,
                  ),

                  // ── Tagline ───────────────────────────────────────────
                  SplashTagline(opacityAnimation: _tagOpacity),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Reacts to navigation states emitted by [SplashCubit].
  /// GetX [Get.offAll] with [Transition.fadeIn] prevents any white flash
  /// or hard cut between the splash and the next screen.
  void _onSplashState(BuildContext context, SplashState state) {
    if (state is SplashNavigateToHome) {
      Get.offAll(
        () => const AppRoot(),
        transition: Transition.fadeIn,
        duration: SplashConstants.navigationFadeDuration,
      );
    } else if (state is SplashNavigateToOnboarding) {
      Get.offAll(
        () => const OnboardingScreen(),
        transition: Transition.fadeIn,
        duration: SplashConstants.navigationFadeDuration,
      );
    } else if (state is SplashNavigateToWelcome) {
      Get.offAll(
        () => const WelcomeScreen(),
        transition: Transition.fadeIn,
        duration: SplashConstants.navigationFadeDuration,
      );
    }
  }
}
