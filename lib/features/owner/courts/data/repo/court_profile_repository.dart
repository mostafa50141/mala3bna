import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/courts/presentation/view_model/court_profile_model.dart';

class CourtProfileRepository {
  Future<CourtProfileModel> fetchCourtProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return CourtProfileModel(
      name: "Neon Padel Arena",
      location: "Padel Court - Cairo, Egypt",
      image: "https://images.unsplash.com/photo-1546519638-68e109498ffc",
      rating: 4.8,
      totalReviews: 125,
      ratingDistribution: {5: 0.85, 4: 0.10, 3: 0.03, 2: 0.02, 1: 0.00},
      amenities: [
        CourtAmenity(title: "Floodlights", icon: Icons.light),
        CourtAmenity(title: "Parking", icon: Icons.local_parking),
        CourtAmenity(title: "Restrooms", icon: Icons.wc),
        CourtAmenity(title: "Water Cooler", icon: Icons.water_drop),
      ],
      reviews: [
        CourtReview(
          name: "Ahmed Hassan",
          rating: 5.0,
          comment:
              "Amazing court with a great atmosphere. The lighting is perfect for evening games!",
          time: "2 days ago",
        ),
        CourtReview(
          name: "Fatima El-Sayed",
          rating: 4.0,
          comment:
              "Good court, but can get a bit crowded. Booking in advance is a must.",
          time: "1 week ago",
        ),
      ],
    );
  }
}
