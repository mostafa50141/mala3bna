import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['Football', 'Tennis', 'Swimming', 'Padel'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return HomeViewBody(selectedIndex: selectedIndex, category: category);
  }
}
