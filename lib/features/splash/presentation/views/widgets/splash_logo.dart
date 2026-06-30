import 'package:flutter/material.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_constants.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_shimmer_overlay.dart';
import 'package:mala3bna/core/utils/assets_data.dart';

/// Renders the app logo with a sequential scale → fade entrance followed
/// by a shimmer sweep once the full animation sequence reaches its tail.
///
/// Receives pre-built [Animation] objects from [SplashScreenBody] which
/// owns the single [AnimationController].
class SplashLogo extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;
  final Animation<double> shimmerAnimation;

  const SplashLogo({
    super.key,
    required this.scaleAnimation,
    required this.opacityAnimation,
    required this.shimmerAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      // A single AnimatedBuilder listening to all three since they share the
      // same parent controller — no redundant rebuild registrations.
      animation: Listenable.merge([
        scaleAnimation,
        opacityAnimation,
        shimmerAnimation,
      ]),
      builder: (context, _) {
        return Opacity(
          opacity: opacityAnimation.value.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: SplashShimmerOverlay(
              progress: shimmerAnimation.value,
              child: SizedBox(
                width: SplashConstants.logoSize,
                height: SplashConstants.logoSize,
                child: Image.asset(
                  AssetsData.splashscreenLogo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
