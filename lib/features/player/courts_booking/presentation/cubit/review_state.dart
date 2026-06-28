part of 'review_cubit.dart';

@immutable
sealed class ReviewState {}
final class ReviewInitial extends ReviewState {}
final class ReviewLoading extends ReviewState {}
final class ReviewLoaded extends ReviewState {
  final List<ReviewModel> reviews;
  final double averageRating;
  ReviewLoaded({required this.reviews, required this.averageRating});
}
final class ReviewFailure extends ReviewState {
  final String errorMessage;
  ReviewFailure(this.errorMessage);
}
final class ReviewEmpty extends ReviewState {}
final class ReviewSubmitting extends ReviewState {}
final class ReviewSubmitted extends ReviewState {}
final class ReviewSubmitFailure extends ReviewState {
  final String errorMessage;
  ReviewSubmitFailure(this.errorMessage);
}
