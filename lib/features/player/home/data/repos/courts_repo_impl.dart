import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/features/player/home/data/repos/courts_repo.dart';

final List<CourtModel> mockCourtsList = [
  // Padel Courts
  const CourtModel(
    id: 1,
    name: 'Smash Padel Club',
    sport: 'Padel',
    location: 'Zamalek, Cairo',
    rating: 4.9,
    pricePerHour: 350,
    distance: '2.5 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0626,
    lng: 31.2497,
  ),
  const CourtModel(
    id: 2,
    name: 'Grand Padel Court',
    sport: 'Padel',
    location: 'Heliopolis, Cairo',
    rating: 4.8,
    pricePerHour: 400,
    distance: '4.0 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0875,
    lng: 31.3411,
  ),
  const CourtModel(
    id: 3,
    name: 'Elite Padel Arena',
    sport: 'Padel',
    location: 'New Cairo, Cairo',
    rating: 4.7,
    pricePerHour: 380,
    distance: '6.0 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0271,
    lng: 31.4736,
  ),
  const CourtModel(
    id: 4,
    name: 'Padel Hub',
    sport: 'Padel',
    location: 'Maadi, Cairo',
    rating: 4.6,
    pricePerHour: 320,
    distance: '5.0 km',
    imageUrl: 'assets/images/Court.png',
    lat: 29.9626,
    lng: 31.2600,
  ),
  const CourtModel(
    id: 5,
    name: 'Pro Padel Center',
    sport: 'Padel',
    location: '6th October, Giza',
    rating: 4.5,
    pricePerHour: 300,
    distance: '8.0 km',
    imageUrl: 'assets/images/Court.png',
    lat: 29.9285,
    lng: 30.9188,
  ),
  const CourtModel(
    id: 6,
    name: 'Padel Zone',
    sport: 'Padel',
    location: 'Nasr City, Cairo',
    rating: 4.4,
    pricePerHour: 280,
    distance: '3.5 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0500,
    lng: 31.3300,
  ),

  // Tennis Courts
  const CourtModel(
    id: 7,
    name: 'Ace Tennis Arena',
    sport: 'Tennis',
    location: 'Nasr City, Cairo',
    rating: 4.5,
    pricePerHour: 300,
    distance: '3.1 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0682,
    lng: 31.3279,
  ),
  const CourtModel(
    id: 8,
    name: 'Elite Tennis Club',
    sport: 'Tennis',
    location: 'Dokki, Giza',
    rating: 4.6,
    pricePerHour: 320,
    distance: '2.8 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0392,
    lng: 31.2133,
  ),
  const CourtModel(
    id: 9,
    name: 'Cairo Tennis Academy',
    sport: 'Tennis',
    location: 'Mohandessin, Giza',
    rating: 4.7,
    pricePerHour: 350,
    distance: '3.0 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0566,
    lng: 31.2000,
  ),
  const CourtModel(
    id: 10,
    name: 'Wimbledon Club',
    sport: 'Tennis',
    location: 'Heliopolis, Cairo',
    rating: 4.8,
    pricePerHour: 400,
    distance: '5.5 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0900,
    lng: 31.3200,
  ),
  const CourtModel(
    id: 11,
    name: 'Tennis Pro Club',
    sport: 'Tennis',
    location: 'Maadi, Cairo',
    rating: 4.3,
    pricePerHour: 250,
    distance: '6.0 km',
    imageUrl: 'assets/images/Court.png',
    lat: 29.9700,
    lng: 31.2700,
  ),
  const CourtModel(
    id: 12,
    name: 'Green Tennis Court',
    sport: 'Tennis',
    location: 'New Cairo, Cairo',
    rating: 4.5,
    pricePerHour: 300,
    distance: '7.0 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0100,
    lng: 31.4500,
  ),

  // Football Courts
  const CourtModel(
    id: 13,
    name: 'Al Ahly Football',
    sport: 'Football',
    location: 'Nasr City, Cairo',
    rating: 4.9,
    pricePerHour: 200,
    distance: '1.5 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0682,
    lng: 31.3279,
  ),
  const CourtModel(
    id: 14,
    name: 'Zamalek Football',
    sport: 'Football',
    location: 'Zamalek, Cairo',
    rating: 4.7,
    pricePerHour: 180,
    distance: '3.5 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0626,
    lng: 31.2497,
  ),
  const CourtModel(
    id: 15,
    name: 'Cairo Football Club',
    sport: 'Football',
    location: 'Giza, Giza',
    rating: 4.5,
    pricePerHour: 150,
    distance: '4.0 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0131,
    lng: 31.2089,
  ),
  const CourtModel(
    id: 16,
    name: 'Champions Arena',
    sport: 'Football',
    location: '6th October, Giza',
    rating: 4.6,
    pricePerHour: 170,
    distance: '9.0 km',
    imageUrl: 'assets/images/Court.png',
    lat: 29.9500,
    lng: 30.9300,
  ),
  const CourtModel(
    id: 17,
    name: 'Victory Football Ground',
    sport: 'Football',
    location: 'Shoubra, Cairo',
    rating: 4.4,
    pricePerHour: 140,
    distance: '2.0 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0950,
    lng: 31.2450,
  ),
  const CourtModel(
    id: 18,
    name: 'Goal Football Club',
    sport: 'Football',
    location: 'Maadi, Cairo',
    rating: 4.3,
    pricePerHour: 130,
    distance: '5.5 km',
    imageUrl: 'assets/images/Court.png',
    lat: 29.9550,
    lng: 31.2550,
  ),

  // Swimming
  const CourtModel(
    id: 19,
    name: 'Blue Wave Swimming',
    sport: 'Swimming',
    location: 'Maadi, Cairo',
    rating: 4.7,
    pricePerHour: 250,
    distance: '1.2 km',
    imageUrl: 'assets/images/Court.png',
    lat: 29.9626,
    lng: 31.2497,
  ),
  const CourtModel(
    id: 20,
    name: 'Aqua Center',
    sport: 'Swimming',
    location: 'Heliopolis, Cairo',
    rating: 4.8,
    pricePerHour: 280,
    distance: '4.5 km',
    imageUrl: 'assets/images/Court.png',
    lat: 30.0850,
    lng: 31.3350,
  ),
];

class CourtsRepoImpl implements CourtsRepo {
  final ApiService apiService;

  CourtsRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<CourtModel>>> getCourts() async {
    try {
      // Simulate fake delayed api response (similar to fake login flow)
      await Future.delayed(const Duration(milliseconds: 800));

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
