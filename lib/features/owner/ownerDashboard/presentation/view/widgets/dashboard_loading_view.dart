import 'package:flutter/material.dart';

/// Animated shimmer skeleton displayed while the dashboard data is loading.
class DashboardLoadingView extends StatefulWidget {
  const DashboardLoadingView({super.key});

  @override
  State<DashboardLoadingView> createState() => _DashboardLoadingViewState();
}

class _DashboardLoadingViewState extends State<DashboardLoadingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 8),
          // App bar placeholder
          _shimmerBox(height: 52, radius: 26),
          const SizedBox(height: 20),
          // Section label
          _shimmerBox(height: 14, radius: 4, width: 90),
          const SizedBox(height: 14),
          // Stats grid
          Row(
            children: [
              Expanded(child: _shimmerBox(height: 130, radius: 18)),
              const SizedBox(width: 12),
              Expanded(child: _shimmerBox(height: 130, radius: 18)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _shimmerBox(height: 130, radius: 18)),
              const SizedBox(width: 12),
              Expanded(child: _shimmerBox(height: 130, radius: 18)),
            ],
          ),
          const SizedBox(height: 24),
          // Chart placeholder
          _shimmerBox(height: 260, radius: 20),
          const SizedBox(height: 20),
          // Button placeholder
          _shimmerBox(height: 56, radius: 16),
        ],
      ),
    );
  }

  Widget _shimmerBox({
    required double height,
    required double radius,
    double? width,
  }) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Color.lerp(
            Theme.of(context).cardColor,
            Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withValues(alpha: 0.06) ??
                Colors.white.withValues(alpha: 0.06),
            _ctrl.value,
          ),
        ),
      ),
    );
  }
}
