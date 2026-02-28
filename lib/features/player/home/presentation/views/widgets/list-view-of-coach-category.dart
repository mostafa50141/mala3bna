import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/coach_category.dart';

// ignore: must_be_immutable
class ListViewOfCoachCategory extends StatelessWidget {
  ListViewOfCoachCategory({super.key});

  List<Map<String, dynamic>> coaches = [
    {
      'imageUrl': 'assets/images/MyPhoto.jpg',
      'coachName': 'Karim Adel',
      'rating': 4.8,
      'sport': 'Padel',
      'price': 200,
    },
    {
      'imageUrl': 'assets/images/MyPhoto2.jpg',
      'coachName': 'Sara Ali',
      'rating': 4.7,
      'sport': 'Tennis',
      'price': 180,
    },
    {
      'imageUrl': 'assets/images/MyPhoto.jpg',
      'coachName': 'Mohamed Hassan',
      'rating': 4.9,
      'sport': 'Football',
      'price': 220,
    },
    {
      'imageUrl': 'assets/images/MyPhoto2.jpg',
      'coachName': 'Laila Samir',
      'rating': 4.6,
      'sport': 'Swimming',
      'price': 170,
    },
    {
      'imageUrl': 'assets/images/MyPhoto.jpg',
      'coachName': 'Omar Khaled',
      'rating': 4.8,
      'sport': 'Padel',
      'price': 200,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: coaches.length,
        itemBuilder: (context, index) {
          final coach = coaches[index];
          return CoachCategory(
            imageUrl: coach['imageUrl'],
            coachName: coach['coachName'],
            rating: coach['rating'],
            sport: coach['sport'],
            price: coach['price'],
          );
        },
      ),
    );
  }
}
