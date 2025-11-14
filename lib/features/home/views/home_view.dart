import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/features/home/widgets/games_category.dart';
import 'package:mala3bna/features/home/widgets/user_info_search_field_container.dart';

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
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Column(
            children: [
              Gap(15),

              UserInfoAndSearchFieldContainer(),

              Gap(15),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: GamesCategory(
                    selectedIndex: selectedIndex,
                    category: category,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
