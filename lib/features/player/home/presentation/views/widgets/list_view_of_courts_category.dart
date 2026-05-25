import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/courts_category.dart';

class ListViewOfCourtsCategory extends StatelessWidget {
  final int selectedSport;
  final String searchQuery;

  const ListViewOfCourtsCategory({
    super.key,
    required this.selectedSport,
    required this.searchQuery,
  });

  static const List<Map<String, dynamic>> courts = [
    {'name': 'Smash Padel Club', 'rating': 4.9, 'price': 350, 'distance': '2.5 km', 'sport': 'Padel'},
    {'name': 'Ace Tennis Arena', 'rating': 4.5, 'price': 300, 'distance': '3.1 km', 'sport': 'Tennis'},
    {'name': 'Blue Wave Swimming', 'rating': 4.7, 'price': 250, 'distance': '1.2 km', 'sport': 'Swimming'},
    {'name': 'Grand Padel Court', 'rating': 4.8, 'price': 400, 'distance': '4.0 km', 'sport': 'Padel'},
    {'name': 'Elite Tennis Club', 'rating': 4.6, 'price': 320, 'distance': '2.8 km', 'sport': 'Tennis'},
    {'name': 'Al Ahly Football', 'rating': 4.9, 'price': 200, 'distance': '1.5 km', 'sport': 'Football'},
    {'name': 'Zamalek Football', 'rating': 4.7, 'price': 180, 'distance': '3.5 km', 'sport': 'Football'},
  ];

  @override
  Widget build(BuildContext context) {
    const sports = ['Football', 'Tennis', 'Swimming', 'Padel'];
    final String selectedSportName = (selectedSport >= 0 && selectedSport < sports.length)
        ? sports[selectedSport]
        : '';

    final filteredCourts = courts.where((court) {
      final bool matchesSport = court['sport'] == selectedSportName;
      final bool matchesSearch = court['name'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesSport && matchesSearch;
    }).toList();

    if (filteredCourts.isEmpty) {
      return SizedBox(
        height: 220,
        child: Center(
          child: Text(
            "No courts found",
            style: Style.textStyle16.copyWith(color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        itemCount: filteredCourts.length,
        itemBuilder: (context, index) {
          final court = filteredCourts[index];
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
