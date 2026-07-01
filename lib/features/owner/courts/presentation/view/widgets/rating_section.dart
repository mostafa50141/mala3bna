import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/shared/section_card.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/stars_widget.dart';
import 'package:mala3bna/features/player/courts_booking/presentation/cubit/review_cubit.dart';

class RatingsSection extends StatelessWidget {
  final CourtEntity vm;

  const RatingsSection({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, reviewState) {
        double rating = vm.rating;
        int reviewCount = vm.reviewCount;
        Map<int, double> distribution = {5: 0.0, 4: 0.0, 3: 0.0, 2: 0.0, 1: 0.0};

        if (reviewState is ReviewLoaded && reviewState.reviews.isNotEmpty) {
          final reviews = reviewState.reviews;
          reviewCount = reviews.length;
          rating = reviews.map((e) => e.rating).reduce((a, b) => a + b) / reviewCount;

          for (var r in reviews) {
            final star = r.rating.clamp(1, 5);
            distribution[star] = (distribution[star] ?? 0) + 1;
          }
          for (var k in distribution.keys.toList()) {
            distribution[k] = distribution[k]! / reviewCount;
          }
        } else if (reviewState is ReviewEmpty || (reviewState is ReviewLoaded && reviewState.reviews.isEmpty)) {
           rating = 0.0;
           reviewCount = 0;
        } else {
          // Fallback mock if loading or error
          distribution = {5: 0.6, 4: 0.2, 3: 0.1, 2: 0.05, 1: 0.05};
        }

        final bars = distribution.entries.toList()
          ..sort((a, b) => b.key.compareTo(a.key));

        return SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Reviews & Ratings'.tr,
                trailing: Text(
                  '$reviewCount ${'reviews'.tr}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      StarsWidget(rating: rating),
                      const SizedBox(height: 6),
                      Text(
                        'out of 5'.tr,
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: bars
                          .map((e) => _RatingBar(star: e.key, value: e.value))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RatingBar extends StatelessWidget {
  final int star;
  final double value;

  const _RatingBar({required this.star, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 10,
            child: Text(
              '$star',
              style: const TextStyle(color: Colors.grey, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.star_rounded, color: AppColors.primaryColor, size: 12),
          const SizedBox(width: 6),
          Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: value),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOut,
              builder: (_, v, __) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: v,
                  minHeight: 6,
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                  valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 32,
            child: Text(
              '${(value * 100).toInt()}%',
              style: const TextStyle(color: Colors.grey, fontSize: 11),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
