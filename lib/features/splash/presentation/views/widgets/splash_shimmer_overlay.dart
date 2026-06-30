import 'package:flutter/material.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_constants.dart';

/// Wraps a [child] widget with a diagonal shimmer sweep effect.
///
/// The [progress] value (0.0 → 1.0) controls the horizontal position of a
/// bright highlight gradient band that sweeps left-to-right across the child.
/// When [progress] is 0, the highlight is off-screen left; at 1.0 it has
/// passed completely to the right — creating a convincing shine pass.
///
/// Uses [ShaderMask] with [BlendMode.srcATop] so the shimmer only brightens
/// existing opaque pixels (the logo shape) without bleeding into transparency.
class SplashShimmerOverlay extends StatelessWidget {
  final double progress;
  final Widget child;

  const SplashShimmerOverlay({
    super.key,
    required this.progress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Sweep range: highlight starts -1.5 → 1.5 in normalised coords.
    final sweepPos = -1.5 + progress * 3.0;

    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment(sweepPos - 0.6, -0.5),
          end: Alignment(sweepPos + 0.6, 0.5),
          colors: [
            Colors.white.withValues(alpha: 0.0),
            Colors.white.withValues(alpha: SplashConstants.shimmerHighlightOpacity),
            Colors.white.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: child,
    );
  }
}
