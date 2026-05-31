import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:mala3bna/core/constants/env.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/utils/api_server.dart';

class RouteService {
  final ApiService apiService;

  RouteService({required this.apiService});

  Future<Either<Failure, List<LatLng>>> fetchRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    // 1. Try OpenRouteService
    try {
      final response = await apiService.post(
        endPoint:
            'https://api.openrouteservice.org/v2/directions/driving-car/geojson',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json, application/geo+json',
            'Authorization': Env.orsApiKey,
          },
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
        body: {
          'coordinates': [
            [start.longitude, start.latitude],
            [end.longitude, end.latitude],
          ],
        },
      );

      if (response.isNotEmpty) {
        final features = response['features'] as List<dynamic>? ?? [];
        if (features.isNotEmpty) {
          final geometry = features[0]['geometry'];
          final coordinates = geometry['coordinates'] as List<dynamic>;
          return right(
            coordinates.map((coord) {
              final lng = (coord[0] as num).toDouble();
              final lat = (coord[1] as num).toDouble();
              return LatLng(lat, lng);
            }).toList(),
          );
        }
      }
    } catch (e) {
      print('OpenRouteService request failed: $e. Falling back to OSRM.');
    }

    // 2. Fallback to OSRM (completely open and keyless)
    try {
      final url =
          'https://router.project-osrm.org/route/v1/driving/'
          '${start.longitude},${start.latitude};${end.longitude},${end.latitude}'
          '?overview=full&geometries=geojson';

      final response = await apiService.get(
        endPoint: url,
        options: Options(
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      if (response.isNotEmpty) {
        final routes = response['routes'] as List<dynamic>? ?? [];
        if (routes.isNotEmpty) {
          final geometry = routes[0]['geometry'];
          final coordinates = geometry['coordinates'] as List<dynamic>;
          return right(
            coordinates.map((coord) {
              final lng = (coord[0] as num).toDouble();
              final lat = (coord[1] as num).toDouble();
              return LatLng(lat, lng);
            }).toList(),
          );
        }
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }

    return left(ServerFailure('No route found between coordinates.'));
  }
}
