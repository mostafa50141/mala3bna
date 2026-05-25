import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/courts_category.dart';

// ignore: must_be_immutable
class ListViewOfCourtsCategory extends StatelessWidget {
  ListViewOfCourtsCategory({super.key});

  List<Map<String, dynamic>> courts = [
    {'name': 'Smash Padel Club', 'rating': 4.9, 'price': 350, 'distance': '2.5 km'},
    {'name': 'Ace Tennis Arena', 'rating': 4.5, 'price': 300, 'distance': '3.1 km'},
    {'name': 'Blue Wave Swimming', 'rating': 4.7, 'price': 250, 'distance': '1.2 km'},
    {'name': 'Grand Padel Court', 'rating': 4.8, 'price': 400, 'distance': '4.0 km'},
    {'name': 'Elite Tennis Club', 'rating': 4.6, 'price': 320, 'distance': '5.5 km'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        itemCount: courts.length,
        itemBuilder: (context, index) {
          final court = courts[index];
          return CourtsCategory(
            courtName: court['name'],
            rating: court['rating'],
            price: court['price'],
            distance: court['distance'],
          );
        },
      ),
    );
  }
}
