import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';

class SlidingText extends StatelessWidget {
  final Animation<Offset> slidingAnimation;

  const SlidingText({Key? key, required this.slidingAnimation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, child) {
        return SlideTransition(
          position: slidingAnimation,
          child: Text('Play • Train • Win', style: Style.textStyle16Bold),
        );
      },
    );
  }
}
