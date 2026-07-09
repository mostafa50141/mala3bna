import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class LoginAnimatedLogo extends StatelessWidget {
  const LoginAnimatedLogo({
    super.key,
    required this.scaleAnimation,
    required this.opacityAnimation,
    required this.glowAnimation,
  });

  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;
  final Animation<double> glowAnimation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: AnimatedBuilder(
          animation: glowAnimation,
          builder: (context, _) {
            return Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withValues(
                        alpha: 0.3 + (glowAnimation.value * 0.4),
                      ),
                      blurRadius: 20 + (glowAnimation.value * 20),
                      spreadRadius: 2 + (glowAnimation.value * 5),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor:
                      AppColors.primaryColor.withValues(alpha: 0.15),
                  radius: 50,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/app_icon.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
