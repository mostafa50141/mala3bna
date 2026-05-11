import 'package:flutter/material.dart';

class CourtReview {
  final String name;
  final double rating;
  final String comment;
  final String time;

  CourtReview({
    required this.name,
    required this.rating,
    required this.comment,
    required this.time,
  });
}

class CourtAmenity {
  final String title;
  final IconData icon;

  CourtAmenity({required this.title, required this.icon});
}

class CourtProfileModel {
  final String name;
  final String location;
  final String image;
  final double rating;
  final int totalReviews;
  final Map<int, double> ratingDistribution;
  final List<CourtAmenity> amenities;
  final List<CourtReview> reviews;

  CourtProfileModel({
    required this.name,
    required this.location,
    required this.image,
    required this.rating,
    required this.totalReviews,
    required this.ratingDistribution,
    required this.amenities,
    required this.reviews,
  });
}
