import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_animateds_snack_bar.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/custom_circular_loading.dart';
import 'package:mala3bna/features/player/courts_booking/presentation/cubit/review_cubit.dart';

class AddReviewBottomSheet extends StatefulWidget {
  final int fieldId;
  const AddReviewBottomSheet({super.key, required this.fieldId});

  @override
  State<AddReviewBottomSheet> createState() => _AddReviewBottomSheetState();
}

class _AddReviewBottomSheetState extends State<AddReviewBottomSheet> {
  int _selectedRating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is ReviewSubmitted) {
          showAnimatedSnackDialog(
            context,
            message: 'Review submitted successfully!',
            type: AnimatedSnackBarType.success,
          );
          Navigator.pop(context);
        } else if (state is ReviewSubmitFailure) {
          showAnimatedSnackDialog(
            context,
            message: state.errorMessage,
            type: AnimatedSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          decoration: const BoxDecoration(
            color: AppColors.colorBtnAndCard,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(16),
              Text('Add Your Review', style: Style.textStyle18Bold),
              const Gap(16),
              // Star rating selector
              Text(
                'Rating',
                style: Style.textStyle14Bold.copyWith(color: Colors.grey),
              ),
              const Gap(8),
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => _selectedRating = index + 1),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        index < _selectedRating
                            ? Icons.star
                            : Icons.star_border,
                        color: AppColors.warningColor,
                        size: 36,
                      ),
                    ),
                  );
                }),
              ),
              const Gap(16),
              // Comment field
              Text(
                'Comment',
                style: Style.textStyle14Bold.copyWith(color: Colors.grey),
              ),
              const Gap(8),
              TextField(
                controller: _commentController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Share your experience...',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const Gap(20),
              // Submit button
              state is ReviewSubmitting
                  ? const Center(child: CustomeCircularLaoding())
                  : CustomBtn(
                      text: 'Submit Review',
                      height: 50,
                      width: double.infinity,
                      radius: 25,
                      weightText: FontWeight.bold,
                      sizeText: 16,
                      onTap: () {
                        if (_selectedRating == 0) {
                          showAnimatedSnackDialog(
                            context,
                            message: 'Please select a rating',
                            type: AnimatedSnackBarType.warning,
                          );
                          return;
                        }
                        if (_commentController.text.trim().isEmpty) {
                          showAnimatedSnackDialog(
                            context,
                            message: 'Please write a comment',
                            type: AnimatedSnackBarType.warning,
                          );
                          return;
                        }
                        context.read<ReviewCubit>().createReview(
                          fieldId: widget.fieldId,
                          rating: _selectedRating,
                          comment: _commentController.text.trim(),
                        );
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
