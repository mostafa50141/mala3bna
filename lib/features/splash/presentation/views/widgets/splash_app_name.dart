import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_constants.dart';

/// Renders the app name with a slide-up entrance paired with a fade-in.
///
/// The text is rendered with a gradient [ShaderMask] to give it a
/// premium teal-to-white-to-teal glow effect consistent with the app palette.
class SplashAppName extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> opacityAnimation;

  const SplashAppName({
    super.key,
    required this.slideAnimation,
    required this.opacityAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([slideAnimation, opacityAnimation]),
      builder: (context, _) {
        return Opacity(
          opacity: opacityAnimation.value.clamp(0.0, 1.0),
          child: SlideTransition(
            position: slideAnimation,
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryColor,
                  Colors.white,
                  AppColors.primaryColor,
                ],
                stops: const [0.0, 0.5, 1.0],
              ).createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: Text(
                'Mala3bna',
                style: TextStyle(
                  fontSize: SplashConstants.appNameFontSize,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.6,
                  height: 1.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
