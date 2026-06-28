import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/features/player/home/data/repos/courts_repo.dart';

class CourtsRepoImpl implements CourtsRepo {
  final ApiService apiService;

  CourtsRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<CourtModel>>> getCourts() async {
    try {
      var response = await apiService.get(endPoint: 'fields/');
      
      // API returns a direct array, not wrapped in "results"
      final List<dynamic> data = response is List
          ? response
          : (response['results'] as List<dynamic>? ?? []);
      
      final courts = data
          .map((json) => CourtModel.fromJson(json as Map<String, dynamic>))
          .where((court) => court.isActive)
          .toList();
      
      return right(courts);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourtModel>> getCourtById({required int id}) async {
    try {
      var response = await apiService.get(endPoint: 'fields/$id/');
      return right(CourtModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
} 
