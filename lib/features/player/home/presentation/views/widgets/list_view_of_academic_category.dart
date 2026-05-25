// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/academics_category.dart';

// ignore: must_be_immutable
class ListViewOfAcademicCategory extends StatelessWidget {
  final int selectedSport;
  final String searchQuery;

  ListViewOfAcademicCategory({
    super.key,
    required this.selectedSport,
    required this.searchQuery,
  });

  List<Map<String, dynamic>> academics = [
    {
      'imageUrl': 'assets/images/Court.png',
      'nameAcademy': 'Pro Football Academy',
      'sport': 'Football',
      'age_1': 8,
      'age_2': 16,
    },
    {
      'imageUrl': 'assets/images/Court.png',
      'nameAcademy': 'Elite Basketball Academy',
      'sport': 'Basketball',
      'age_1': 10,
      'age_2': 18,
    },
    {
      'imageUrl': 'assets/images/Court.png',
      'nameAcademy': 'Aqua Swimming Club',
      'sport': 'Swimming',
      'age_1': 6,
      'age_2': 14,
    },
    {
      'imageUrl': 'assets/images/Court.png',
      'nameAcademy': 'Champions Tennis Academy',
      'sport': 'Tennis',
      'age_1': 7,
      'age_2': 15,
    },
    {
      'imageUrl': 'assets/images/Court.png',
      'nameAcademy': 'Fitness Kids Academy',
      'sport': 'Gym',
      'age_1': 12,
      'age_2': 18,
    },
  ];

  @override
  Widget build(BuildContext context) {
    const sports = ['Football', 'Tennis', 'Swimming', 'Padel'];
    final String selectedSportName =
        (selectedSport >= 0 && selectedSport < sports.length)
        ? sports[selectedSport]
        : '';

    final filteredAcademics = academics.where((academic) {
      final bool matchesSport = academic['sport'] == selectedSportName;
      final bool matchesSearch = academic['nameAcademy']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      return matchesSport && matchesSearch;
    }).toList();

    if (filteredAcademics.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Text(
            "No academies found",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: filteredAcademics.length,
      itemBuilder: (context, index) {
        final academic = filteredAcademics[index];
        return AcademicsCategory(
          imageUrl: academic['imageUrl'],
          nameAcademy: academic['nameAcademy'],
          sport: academic['sport'],
          age_1: academic['age_1'],
          age_2: academic['age_2'],
        );
      },
    );
  }
}
