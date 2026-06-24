import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/shared/section_card.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/stars_widget.dart';

class RatingsSection extends StatelessWidget {
  final CourtEntity vm;

  const RatingsSection({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    // Mock distribution for UI since it's not in the domain model
    final mockDistribution = {5: 0.6, 4: 0.2, 3: 0.1, 2: 0.05, 1: 0.05};
    final bars = mockDistribution.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Reviews & Ratings',
            trailing: Text(
              '${vm.reviewCount} reviews',
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
                    vm.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  StarsWidget(rating: vm.rating),
                  const SizedBox(height: 6),
                  Text(
                    'out of 5',
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
