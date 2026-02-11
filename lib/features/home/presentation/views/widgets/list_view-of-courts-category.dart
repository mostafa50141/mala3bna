import 'package:flutter/material.dart';
import 'package:mala3bna/features/home/presentation/views/widgets/courts_category.dart';

// ignore: must_be_immutable
class ListViewOfCourtsCategory extends StatelessWidget {
  ListViewOfCourtsCategory({super.key});

  List<Map<String, dynamic>> courts = [
    {'name': 'Smash Padel Club', 'rating': 4.9, 'price': 350},
    {'name': 'Ace Tennis Arena', 'rating': 4.5, 'price': 300},
    {'name': 'Blue Wave Swimming', 'rating': 4.7, 'price': 250},
    {'name': 'Grand Padel Court', 'rating': 4.8, 'price': 400},
    {'name': 'Elite Tennis Club', 'rating': 4.6, 'price': 320},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: courts.length,
        itemBuilder: (context, index) {
          final court = courts[index];
          return CourtsCategory(
            courtName: court['name'],
            rating: court['rating'],
            price: court['price'],
          );
        },
      ),
    );
  }
}
