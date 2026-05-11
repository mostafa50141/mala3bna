import 'dart:async';

import '../models/court_model.dart';
import '../models/court_image_model.dart';
import '../models/amenity_model.dart';
import '../models/update_court_request.dart';

/// Remote data source. Currently mocked and prepared for real HTTP integration.
abstract class CourtRemoteDataSource {
  Future<CourtModel> getCourtDetails(String id);

  /// Uploads an image and returns created CourtImageModel
  Future<CourtImageModel> uploadCourtImage(String courtId, String filePath);

  Future<void> removeCourtImage(String courtId, String imageId);

  Future<void> updateCourt(UpdateCourtRequest request);
}

class CourtRemoteDataSourceImpl implements CourtRemoteDataSource {
  // In production, inject http client / api client here

  @override
  Future<CourtModel> getCourtDetails(String id) async {
    // Placeholder mocked response (simulate network latency)
    await Future.delayed(const Duration(milliseconds: 600));

    final sampleAmenities = [
      AmenityModel(id: '1', title: 'Lights', iconAsset: ''),
      AmenityModel(id: '2', title: 'Showers', iconAsset: ''),
      AmenityModel(id: '3', title: 'Cafe', iconAsset: ''),
      AmenityModel(id: '4', title: 'Parking', iconAsset: ''),
      AmenityModel(id: '5', title: 'Equipment', iconAsset: ''),
      AmenityModel(id: '6', title: 'Toilets', iconAsset: ''),
    ];

    final images = [
      CourtImageModel(id: 'i1', url: 'assets/images/sample_court_1.jpg'),
      CourtImageModel(id: 'i2', url: 'assets/images/sample_court_2.jpg'),
    ];

    return CourtModel(
      id: id,
      title: 'Sample Court',
      hourlyRate: 450.0,
      images: images,
      amenities: sampleAmenities,
      lat: 30.0444,
      lng: 31.2357,
    );
  }

  @override
  Future<CourtImageModel> uploadCourtImage(
    String courtId,
    String filePath,
  ) async {
    // Simulate upload delay and return a new image model with mock url
    await Future.delayed(const Duration(seconds: 1));
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    return CourtImageModel(id: id, url: filePath);
  }

  @override
  Future<void> removeCourtImage(String courtId, String imageId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  @override
  Future<void> updateCourt(UpdateCourtRequest request) async {
    // Simulate network latency and success
    await Future.delayed(const Duration(seconds: 1));
    return;
  }
}
