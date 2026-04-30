import 'package:flutter/material.dart';
import 'review_item.dart';

class ReviewsList extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const ReviewsList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'No reviews yet',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: List.generate(reviews.length, (index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < reviews.length - 1 ? 12 : 0,
          ),
          child: ReviewItem(review: reviews[index]),
        );
      }),
    );
  }
}
