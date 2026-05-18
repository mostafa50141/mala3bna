import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/assets_data.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_constants.dart';

/// Animates the full-screen background.
///
/// The [breathAnimation] (from a looping controller) drives a subtle
/// gradient overlay that rhythmically shifts opacity, giving the
/// background a living, breathing feel without distracting from the logo.
class SplashBackground extends StatelessWidget {
  final Animation<double> breathAnimation;
  final Widget child;

  const SplashBackground({
    super.key,
    required this.breathAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: breathAnimation,
      builder: (context, _) {
        final overlayOpacity = SplashConstants.bgOverlayMin +
            breathAnimation.value *
                (SplashConstants.bgOverlayMax - SplashConstants.bgOverlayMin);

        return DecoratedBox(
          // Base: the splash background image
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsData.splashscreenBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: DecoratedBox(
            // Animated dark-teal gradient overlay for depth + breathing effect
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.backgroundColor.withValues(alpha: overlayOpacity),
                  AppColors.leftGradient.withValues(alpha: overlayOpacity - 0.05),
                  AppColors.backgroundColor.withValues(alpha: overlayOpacity + 0.05),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
