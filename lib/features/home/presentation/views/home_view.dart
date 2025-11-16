import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/features/home/presentation/views/widgets/games_category.dart';
import 'package:mala3bna/features/home/presentation/views/widgets/list-view-of-coach-category.dart';
import 'package:mala3bna/features/home/presentation/views/widgets/list_view-of-courts-category.dart';
import 'package:mala3bna/features/home/presentation/views/widgets/list_view_of_academic_category.dart';
import 'package:mala3bna/features/home/presentation/views/widgets/user_info_search_field_container.dart';
import 'package:mala3bna/shared/custom_text.dart';

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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(15),

                  UserInfoAndSearchFieldContainer(),

                  Gap(15),

                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: GamesCategory(
                      selectedIndex: selectedIndex,
                      category: category,
                    ),
                  ),

                  Gap(25),

                  customText(
                    text: 'Nearby Courts',
                    size: 25,
                    weight: FontWeight.bold,
                  ),

                  Gap(10),

                  ListViewOfCourtsCategory(),

                  Gap(25),

                  customText(
                    text: 'Featured Coaches',
                    size: 25,
                    weight: FontWeight.bold,
                  ),

                  Gap(10),

                  ListViewOfCoachCategory(),

                  Gap(25),

                  customText(
                    text: 'Training Academies',
                    size: 25,
                    weight: FontWeight.bold,
                  ),

                  Gap(10),

                  ListViewOfAcademicCategory(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
