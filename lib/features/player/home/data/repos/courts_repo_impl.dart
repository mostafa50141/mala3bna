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
      // Simulate fake delayed api response (similar to fake login flow)
      await Future.delayed(const Duration(milliseconds: 800));

      final List<CourtModel> mockCourtsList = [
        const CourtModel(id:1, name:'Smash Padel Club', sport:'Padel', location:'Zamalek, Cairo', rating:4.9, pricePerHour:350, distance:'2.5 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:2, name:'Ace Tennis Arena', sport:'Tennis', location:'Nasr City, Cairo', rating:4.5, pricePerHour:300, distance:'3.1 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:3, name:'Blue Wave Swimming', sport:'Swimming', location:'Maadi, Cairo', rating:4.7, pricePerHour:250, distance:'1.2 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:4, name:'Grand Padel Court', sport:'Padel', location:'Heliopolis, Cairo', rating:4.8, pricePerHour:400, distance:'4.0 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:5, name:'Elite Tennis Club', sport:'Tennis', location:'Dokki, Cairo', rating:4.6, pricePerHour:320, distance:'2.8 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:6, name:'Al Ahly Football', sport:'Football', location:'Nasr City, Cairo', rating:4.9, pricePerHour:200, distance:'1.5 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:7, name:'Zamalek Football', sport:'Football', location:'Zamalek, Cairo', rating:4.7, pricePerHour:180, distance:'3.5 km', imageUrl:'assets/images/Court.png'),
      ];

      return right(mockCourtsList);
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
      // Simulate fake delayed api response
      await Future.delayed(const Duration(milliseconds: 500));

      final List<CourtModel> mockCourtsList = [
        const CourtModel(id:1, name:'Smash Padel Club', sport:'Padel', location:'Zamalek, Cairo', rating:4.9, pricePerHour:350, distance:'2.5 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:2, name:'Ace Tennis Arena', sport:'Tennis', location:'Nasr City, Cairo', rating:4.5, pricePerHour:300, distance:'3.1 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:3, name:'Blue Wave Swimming', sport:'Swimming', location:'Maadi, Cairo', rating:4.7, pricePerHour:250, distance:'1.2 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:4, name:'Grand Padel Court', sport:'Padel', location:'Heliopolis, Cairo', rating:4.8, pricePerHour:400, distance:'4.0 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:5, name:'Elite Tennis Club', sport:'Tennis', location:'Dokki, Cairo', rating:4.6, pricePerHour:320, distance:'2.8 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:6, name:'Al Ahly Football', sport:'Football', location:'Nasr City, Cairo', rating:4.9, pricePerHour:200, distance:'1.5 km', imageUrl:'assets/images/Court.png'),
        const CourtModel(id:7, name:'Zamalek Football', sport:'Football', location:'Zamalek, Cairo', rating:4.7, pricePerHour:180, distance:'3.5 km', imageUrl:'assets/images/Court.png'),
      ];

      final court = mockCourtsList.firstWhere(
        (c) => c.id == id,
        orElse: () => throw Exception('Court not found'),
      );

      return right(court);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
