import 'package:flutter/material.dart';

class CourtViewModel extends ChangeNotifier {
  String name = "Neon Padel Arena";
  String location = "Padel Court - Cairo, Egypt";
  String image = "https://images.unsplash.com/photo-1546519638-68e109498ffc";

  double rating = 4.8;
  int totalReviews = 125;

  Map<int, double> ratingDistribution = {
    5: 0.85,
    4: 0.10,
    3: 0.03,
    2: 0.02,
    1: 0.00,
  };

  List<Map<String, dynamic>> amenities = [
    {"title": "Floodlights", "icon": Icons.light},
    {"title": "Parking", "icon": Icons.local_parking},
    {"title": "Restrooms", "icon": Icons.wc},
    {"title": "Water Cooler", "icon": Icons.water_drop},
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "name": "Ahmed Hassan",
      "rating": 5.0,
      "comment":
          "Amazing court with a great atmosphere. The lighting is perfect for evening games!",
      "time": "2 days ago",
    },
    {
      "name": "Fatima El-Sayed",
      "rating": 4.0,
      "comment":
          "Good court, but can get a bit crowded. Booking in advance is a must.",
      "time": "1 week ago",
    },
  ];
}
