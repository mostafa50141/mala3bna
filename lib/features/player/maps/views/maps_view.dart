import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/custom_text.dart';

class MapsView extends StatelessWidget {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(child: customText(text: 'Maps', size: 30)),
    );
  }
}
