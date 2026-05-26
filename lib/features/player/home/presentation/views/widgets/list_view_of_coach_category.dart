import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/coach_category.dart';

// ignore: must_be_immutable
class ListViewOfCoachCategory extends StatelessWidget {
  final int selectedSport;
  final String searchQuery;

  ListViewOfCoachCategory({
    super.key,
    required this.selectedSport,
    required this.searchQuery,
  });

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
    const sports = ['All', 'Football', 'Tennis', 'Swimming', 'Padel'];
    final String selectedSportName =
        (selectedSport >= 0 && selectedSport < sports.length)
        ? sports[selectedSport]
        : 'All';

    final filteredCoaches = coaches.where((coach) {
      final bool matchesSport = selectedSportName == 'All' || coach['sport'] == selectedSportName;
      final bool matchesSearch = coach['coachName']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      return matchesSport && matchesSearch;
    }).toList();

    if (filteredCoaches.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            "No coaches found",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: filteredCoaches.length,
        itemBuilder: (context, index) {
          final coach = filteredCoaches[index];
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
