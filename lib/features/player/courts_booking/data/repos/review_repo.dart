import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/review_model.dart';

abstract class ReviewRepo {
  Future<Either<Failure, List<ReviewModel>>> getReviewsByField({
    required int fieldId,
  });

  Future<Either<Failure, ReviewModel>> createReview({
    required int fieldId,
    required int rating,
    required String comment,
  });
}
