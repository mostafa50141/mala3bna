import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/review_model.dart';
import 'package:mala3bna/features/player/courts_booking/data/repos/review_repo.dart';

class ReviewRepoImpl implements ReviewRepo {
  final ApiService apiService;
  ReviewRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<ReviewModel>>> getReviewsByField({
    required int fieldId,
  }) async {
    try {
      var response = await apiService.get(endPoint: 'reviews/');
      final List<dynamic> data = response is List
          ? response
          : (response['results'] as List<dynamic>? ?? []);
      final reviews = data
          .map((json) => ReviewModel.fromJson(json as Map<String, dynamic>))
          .where((review) => review.fieldId == fieldId)
          .toList();
      return right(reviews);
    } catch (e) {
      if (e is DioException) return left(ServerFailure.fromDioError(e));
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReviewModel>> createReview({
    required int fieldId,
    required int rating,
    required String comment,
  }) async {
    try {
      var response = await apiService.post(
        endPoint: 'reviews/',
        body: {
          'field': fieldId,
          'rating': rating,
          'comment': comment,
        },
      );
      return right(ReviewModel.fromJson(response as Map<String, dynamic>));
    } catch (e) {
      if (e is DioException) return left(ServerFailure.fromDioError(e));
      return left(ServerFailure(e.toString()));
    }
  }
}
