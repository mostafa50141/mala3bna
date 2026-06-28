import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_constants.dart';

/// Renders the app tagline ("Play • Train • Win") with a pure fade-in.
///
/// The tagline appears last in the animation sequence, after the logo
/// and app name have settled, giving the screen a cinematic staggered feel.
/// A pair of short decorative lines flank the text for polish.
class SplashTagline extends StatelessWidget {
  final Animation<double> opacityAnimation;

  const SplashTagline({super.key, required this.opacityAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacityAnimation,
      builder: (context, _) {
        return Opacity(
          opacity: opacityAnimation.value.clamp(0.0, 1.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDivider(),
              const SizedBox(width: 12),
              Text(
                'Play  •  Train  •  Win',
                style: TextStyle(
                  fontSize: SplashConstants.taglineFontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.75),
                  letterSpacing: 1.8,
                ),
              ),
              const SizedBox(width: 12),
              _buildDivider(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return Container(
      width: SplashConstants.taglineDividerWidth,
      height: SplashConstants.taglineDividerThickness,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.primaryColor.withValues(alpha: 0.7),
          ],
        ),
      ),
    );
  }
}
