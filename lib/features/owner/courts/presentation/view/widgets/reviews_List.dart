import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
// import 'review_item.dart';

class ReviewsList extends StatelessWidget {
  final List<dynamic> reviews;

  const ReviewsList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) return const _EmptyReviews();

    return Column(
      children: [
        for (int i = 0; i < reviews.length; i++) ...[
          // ReviewItem(review: reviews[i]),
          if (i < reviews.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _EmptyReviews extends StatelessWidget {
  const _EmptyReviews();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.2),
                ),
              ),
              child: Icon(
                Icons.rate_review_outlined,
                size: 30,
                color: AppColors.primaryColor.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No reviews yet',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Be the first to share your experience!',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
