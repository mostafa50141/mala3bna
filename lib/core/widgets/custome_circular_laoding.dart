import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

// CustomeCircularLaoding
class CustomeCircularLaoding extends StatefulWidget {
  const CustomeCircularLaoding({super.key});
  @override
  State<CustomeCircularLaoding> createState() => _CustomeCircularLaodingState();
}

class _CustomeCircularLaodingState extends State<CustomeCircularLaoding>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => SizedBox(
        width: 64,
        height: 64,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer ring
            Transform.rotate(
              angle: _controller.value * 2 * 3.14159,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryColor, width: 2.5),
                ),
              ),
            ),
            Transform.rotate(
              angle: -_controller.value * 2 * 3.14159,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.5),
                    width: 2,
                  ),
                ),
              ),
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
