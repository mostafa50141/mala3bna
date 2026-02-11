// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:mala3bna/features/home/presentation/views/widgets/Academics_category.dart';

// ignore: must_be_immutable
class ListViewOfAcademicCategory extends StatelessWidget {
  ListViewOfAcademicCategory({super.key});

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
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (context, index) {
        final academic = academics[index];
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
