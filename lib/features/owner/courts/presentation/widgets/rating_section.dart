import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:provider/provider.dart';
import '../view_model/court_view_model.dart';

class RatingsSection extends StatelessWidget {
  const RatingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CourtViewModel>();

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Ratings", style: Style.textStyle20Bold),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LEFT SIDE (Rating)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vm.rating.toString(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  buildStars(vm.rating),
                  const SizedBox(height: 6),
                  Text(
                    "${vm.totalReviews} reviews",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(width: 20),

              /// RIGHT SIDE (Bars)
              Expanded(
                child: Column(
                  children: vm.ratingDistribution.entries.map((entry) {
                    return ratingBar(star: entry.key, value: entry.value);
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ⭐ Stars
  Widget buildStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: AppColors.primaryColor, size: 18);
        } else if (index < rating && rating % 1 != 0) {
          return Icon(Icons.star_half, color: AppColors.primaryColor, size: 18);
        } else {
          return Icon(
            Icons.star_border,
            color: AppColors.primaryColor,
            size: 18,
          );
        }
      }),
    );
  }

  /// 📊 Rating Bar
  Widget ratingBar({required int star, required double value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$star", style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 8),

          Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: value),
              duration: const Duration(milliseconds: 800),
              builder: (context, animatedValue, _) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: animatedValue,
                    minHeight: 6,
                    backgroundColor: Colors.grey.withOpacity(.2),
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 8),

          Text(
            "${(value * 100).toInt()}%",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
