import 'package:flutter/material.dart';

/// Clean white full-screen background for the splash screen.
///
/// The [breathAnimation] is kept as a parameter for API compatibility
/// but drives a very subtle scale pulse on the child so the screen
/// still feels alive without any colour trickery.
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
    return ColoredBox(
      color: Colors.white,
      child: child,
    );
  }
}
