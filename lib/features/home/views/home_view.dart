import 'package:flutter/material.dart';
import 'package:mala3bna/shared/custom_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(child: customText(text: 'Home Screen', size: 30)),
    );
  }
}
