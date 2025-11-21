import 'package:flutter/material.dart';
import 'package:mala3bna/shared/widgets/custom_text.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(child: customText(text: 'Profile Screen', size: 30)),
    );
  }
}
