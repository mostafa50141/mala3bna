import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationResult {
  final LatLng? location;
  final bool isPermissionDenied;
  final String? errorMessage;

  const LocationResult._({
    this.location,
    this.isPermissionDenied = false,
    this.errorMessage,
  });

  factory LocationResult.success(LatLng location) =>
      LocationResult._(location: location);

  factory LocationResult.permissionDenied() =>
      LocationResult._(isPermissionDenied: true);

  factory LocationResult.error(String message) =>
      LocationResult._(errorMessage: message);

  bool get isSuccess => location != null;
}

class LocationService {
  Future<LocationResult> getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return LocationResult.error('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return LocationResult.permissionDenied();
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      return LocationResult.success(
        LatLng(position.latitude, position.longitude),
      );
    } catch (e) {
      return LocationResult.error(e.toString());
    }
  }
}
