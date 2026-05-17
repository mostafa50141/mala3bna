import 'package:flutter/material.dart';

/// Animated shimmer skeleton displayed while court data loads.
class EditCourtShimmer extends StatefulWidget {
  const EditCourtShimmer({super.key});

  @override
  State<EditCourtShimmer> createState() => _EditCourtShimmerState();
}

class _EditCourtShimmerState extends State<EditCourtShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final v = _animation.value;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _box(80, double.infinity, v),
              const SizedBox(height: 20),
              _box(130, double.infinity, v),
              const SizedBox(height: 20),
              _box(70, double.infinity, v),
              const SizedBox(height: 20),
              _box(170, double.infinity, v),
            ],
          ),
        );
      },
    );
  }

  Widget _box(double height, double width, double value) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: value * 0.06),
            Colors.white.withValues(alpha: value * 0.12),
            Colors.white.withValues(alpha: value * 0.06),
          ],
        ),
      ),
    );
  }
}
