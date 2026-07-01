import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Hide bloc's Transition to avoid ambiguity with GetX's Transition enum.
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:mala3bna/core/role/app_root.dart';
import 'package:mala3bna/core/utils/assets_data.dart';
import 'package:mala3bna/features/onboarding/presentation/views/onboarding_screen.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_constants.dart';
import 'package:mala3bna/features/splash/presentation/views_model/cubit/splash_cubit.dart';
import 'package:mala3bna/features/welcome_screen/presentation/views/welcome_screen.dart';

/// Clean white splash screen body.
///
/// Animation sequence (single controller, 2 400 ms):
///
///  ┌────────────────────────────────────────────────────────────────────────┐
///  │  0 ms  ──  700 ms   Logo:   scale 0.6→1.0 (easeOutBack) + fade in    │
///  │  700 ms── 1 400 ms  Logo:   subtle bounce pulse (easeInOut)           │
///  │  1 400 ms─ 2 000 ms Dots:   sequential fade-in loading indicator      │
///  │  2 400 ms           Controller complete → Cubit emits nav state        │
///  └────────────────────────────────────────────────────────────────────────┘
class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with TickerProviderStateMixin {
  // ─── Controllers ────────────────────────────────────────────────────────────
  late final AnimationController _mainController;
  late final AnimationController _pulseController;

  // ─── Animations ─────────────────────────────────────────────────────────────
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _dot1Opacity;
  late final Animation<double> _dot2Opacity;
  late final Animation<double> _dot3Opacity;
  late final Animation<double> _pulseScale;

  @override
  void initState() {
    super.initState();
    // Fully transparent status bar — white background reads as light icons
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    _initAnimations();
    _mainController.forward();
  }

  void _initAnimations() {
    // ── Main controller (runs once, 2 400 ms) ───────────────────────────────
    _mainController = AnimationController(
      vsync: this,
      duration: SplashConstants.totalDuration,
    )..addStatusListener(_onMainAnimationStatus);

    // ── Pulse controller (loops, 1.2 s) — subtle scale breath on logo ───────
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseScale = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // ── Logo scale (0 → 700 ms = 0.0 → 0.29) ───────────────────────────────
    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.29, curve: Curves.easeOutBack),
      ),
    );

    // ── Logo opacity (0 → 500 ms = 0.0 → 0.21) ─────────────────────────────
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.21, curve: Curves.easeIn),
      ),
    );

    // ── Dots sequential fade (1 400 ms → 2 200 ms = 0.58 → 0.92) ───────────
    _dot1Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.58, 0.70, curve: Curves.easeIn),
      ),
    );
    _dot2Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.67, 0.79, curve: Curves.easeIn),
      ),
    );
    _dot3Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.76, 0.92, curve: Curves.easeIn),
      ),
    );
  }

  void _onMainAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      context.read<SplashCubit>().checkNavigationTarget();
    }
  }

  @override
  void dispose() {
    _mainController.removeStatusListener(_onMainAnimationStatus);
    _mainController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: _onSplashState,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Logo with scale + fade + subtle pulse ──────────────────
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _logoScale,
                    _logoOpacity,
                    _pulseScale,
                  ]),
                  builder: (context, _) {
                    return Opacity(
                      opacity: _logoOpacity.value.clamp(0.0, 1.0),
                      child: Transform.scale(
                        scale: _logoScale.value * _pulseScale.value,
                        child: SizedBox(
                          width: SplashConstants.logoSize + 60,
                          height: SplashConstants.logoSize + 60,
                          child: Image.asset(
                            AssetsData.splashscreenLogo,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  AssetsData.logo,
                                  fit: BoxFit.contain,
                                ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 48),

                // ── Three-dot loading indicator (sequential fade) ──────────
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _dot1Opacity,
                    _dot2Opacity,
                    _dot3Opacity,
                  ]),
                  builder: (context, _) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildDot(_dot1Opacity.value),
                        const SizedBox(width: 10),
                        _buildDot(_dot2Opacity.value),
                        const SizedBox(width: 10),
                        _buildDot(_dot3Opacity.value),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDot(double opacity) {
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFF1B6B5A), // brand teal
          shape: BoxShape.circle,
        ),
      ),
    );
  }

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
