import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/player/courts_booking/presentation/cubit/review_cubit.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/review_card.dart';

class ReviewsList extends StatefulWidget {
  final int fieldId;

  const ReviewsList({super.key, required this.fieldId});

  @override
  State<ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReviewCubit>().getReviews(fieldId: widget.fieldId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ReviewFailure) {
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(child: Text(state.errorMessage)),
          );
        } else if (state is ReviewEmpty) {
          return const _EmptyReviews();
        } else if (state is ReviewLoaded) {
          final reviews = state.reviews;
          if (reviews.isEmpty) return const _EmptyReviews();

          return Column(
            children: [
              for (int i = 0; i < reviews.length; i++) ...[
                ReviewCard(review: reviews[i]),
                if (i < reviews.length - 1) const SizedBox(height: 12),
              ],
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _EmptyReviews extends StatelessWidget {
  const _EmptyReviews();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
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
            Text(
              'No reviews yet'.tr,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Be the first to share your experience!'.tr,
              style: TextStyle(color: isDark ? Colors.grey : Colors.black54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
