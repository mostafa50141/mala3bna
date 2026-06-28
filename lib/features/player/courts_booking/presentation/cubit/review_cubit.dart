import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/review_model.dart';
import 'package:mala3bna/features/player/courts_booking/data/repos/review_repo.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepo repo;
  ReviewCubit(this.repo) : super(ReviewInitial());

  Future<void> getReviews({required int fieldId}) async {
    emit(ReviewLoading());
    var result = await repo.getReviewsByField(fieldId: fieldId);
    result.fold(
      (failure) => emit(ReviewFailure(failure.errmessage ?? 'Failed to load reviews')),
      (reviews) {
        if (reviews.isEmpty) {
          emit(ReviewEmpty());
        } else {
          final avg = reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;
          emit(ReviewLoaded(reviews: reviews, averageRating: avg));
        }
      },
    );
  }

  Future<void> createReview({
    required int fieldId,
    required int rating,
    required String comment,
  }) async {
    emit(ReviewSubmitting());
    var result = await repo.createReview(
      fieldId: fieldId,
      rating: rating,
      comment: comment,
    );
    result.fold(
      (failure) => emit(ReviewSubmitFailure(
        failure.errmessage ?? 'Failed to submit review'
      )),
      (review) {
        emit(ReviewSubmitted());
        // Reload reviews after submission
        getReviews(fieldId: fieldId);
      },
    );
  }
}
