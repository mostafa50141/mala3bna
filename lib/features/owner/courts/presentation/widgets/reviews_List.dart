import 'package:flutter/material.dart';
import 'review_item.dart';

class ReviewsList extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const ReviewsList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Center(
        child: Text("No reviews yet", style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.separated(
      itemCount: reviews.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) =>
          const Divider(color: Colors.white10, height: 20),
      itemBuilder: (context, index) {
        return ReviewItem(review: reviews[index]);
      },
    );
  }
}
