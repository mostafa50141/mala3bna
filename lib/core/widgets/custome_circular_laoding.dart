import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomeCircularLaoding extends StatelessWidget {
  const CustomeCircularLaoding({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Lottie.asset(
        'assets/animations/loading_indicator.json',
        fit: BoxFit.contain,
      ),
    );
  }
}
