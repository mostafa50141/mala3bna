import 'package:dio/dio.dart';
import 'package:mala3bna/core/network/api_endpoints.dart';
import 'package:mala3bna/core/network/dio_client.dart';
import '../models/court_model.dart';
import '../models/court_image_model.dart';

abstract class CourtRemoteDataSource {
  Future<List<CourtModel>> getOwnerFields();
  Future<CourtModel> getFieldDetails(String id);
  Future<CourtModel> addField({
    required String title,
    required double hourlyRate,
    required String address,
    required String sportType,
    required List<String> amenityIds,
  });
  Future<CourtModel> updateField({
    required String id,
    String? title,
    double? hourlyRate,
    double? offPeakRate,
    double? membershipDiscount,
    String? address,
    List<String>? amenityIds,
    String? sportType,
  });
  Future<bool> toggleFieldStatus(
    String id, {
    String? maintenanceType,
    String? maintenanceDescription,
  });
  Future<CourtImageModel> uploadFieldImage(String fieldId, String filePath);
  Future<void> deleteFieldImage(String imageId);
}

class CourtRemoteDataSourceImpl implements CourtRemoteDataSource {
  final DioClient _client;

  CourtRemoteDataSourceImpl(this._client);

  @override
  Future<List<CourtModel>> getOwnerFields() async {
    final response = await _client.get(ApiEndpoints.fields);
    print('[Courts] Raw getOwnerFields response: $response');

    // Django REST Framework can return either:
    //   A) A raw List  → [{ "id": 1, ... }, ...]
    //   B) A paginated Map  → { "count": N, "results": [...] }
    final List<dynamic> data;
    if (response is List) {
      data = response;
    } else if (response is Map && response.containsKey('results')) {
      data = response['results'] as List<dynamic>;
    } else {
      print('[Courts] Unexpected response structure: $response');
      data = [];
    }

    print('[Courts] Parsed ${data.length} court(s)');
    return data.map((json) => CourtModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<CourtModel> getFieldDetails(String id) async {
    final endpoint = ApiEndpoints.fieldDetail(id);
    print('[Court Details] Calling endpoint: $endpoint');
    final response = await _client.get(endpoint);
    print('[Court Details] Raw response type: ${response.runtimeType}');
    print('[Court Details] Raw response: $response');
    
    // Ensure the ID is preserved if the backend detail serializer omits it
    if (response is Map<String, dynamic>) {
      response['id'] ??= id;
    }
    
    return CourtModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<CourtModel> addField({
    required String title,
    required double hourlyRate,
    required String address,
    required String sportType,
    required List<String> amenityIds,
  }) async {
    final response = await _client.post(
      ApiEndpoints.fields,
      data: {
        'name': title,
        'price_per_hour': hourlyRate,
        'address': address,
        'sport_type': sportType,
        'has_lights': amenityIds.contains('lights'),
        'has_showers': amenityIds.contains('showers'),
        'has_cafe': amenityIds.contains('cafe'),
        'has_equipment': amenityIds.contains('equipment'),
      },
    );
    return CourtModel.fromJson(response);
  }

  @override
  Future<CourtModel> updateField({
    required String id,
    String? title,
    double? hourlyRate,
    double? offPeakRate,
    double? membershipDiscount,
    String? address,
    List<String>? amenityIds,
    String? sportType,
  }) async {
    final Map<String, dynamic> data = {};
    if (title != null) data['name'] = title;
    if (hourlyRate != null) data['price_per_hour'] = hourlyRate;
    if (offPeakRate != null) data['off_peak_price'] = offPeakRate;
    if (membershipDiscount != null) data['membership_discount'] = membershipDiscount;
    if (address != null) data['address'] = address;
    if (sportType != null) data['sport_type'] = sportType;

    // Backend uses boolean flags, not a list of amenity IDs
    if (amenityIds != null) {
      data['has_lights']    = amenityIds.contains('lights');
      data['has_showers']   = amenityIds.contains('showers');
      data['has_cafe']      = amenityIds.contains('cafe');
      data['has_equipment'] = amenityIds.contains('equipment');
    }

    print('[UpdateField] Sending PATCH to ${ApiEndpoints.fieldDetail(id)}');
    print('[UpdateField] Body: $data');

    // Use JSON patch to properly encode booleans (has_lights, etc.)
    final rawResponse = await _client.patch(
      ApiEndpoints.fieldDetail(id),
      data: data,
    );

    print('[UpdateField] Response: $rawResponse');
    return CourtModel.fromJson(rawResponse);
  }

  @override
  Future<bool> toggleFieldStatus(
    String id, {
    String? maintenanceType,
    String? maintenanceDescription,
  }) async {
    final Map<String, dynamic> data = {};
    if (maintenanceType != null) {
      data['maintenance_type'] = maintenanceType;
    }
    if (maintenanceDescription != null) {
      data['maintenance_description'] = maintenanceDescription;
    }

    final response = await _client.post(
      ApiEndpoints.fieldToggleStatus(id),
      data: data,
    );
    if (response is Map<String, dynamic> && response.containsKey('is_active')) {
      return response['is_active'] == true;
    }
    return false; // Default fallback
  }

  @override
  Future<CourtImageModel> uploadFieldImage(
    String fieldId,
    String filePath,
  ) async {
    final formData = FormData.fromMap({
      'field': fieldId,
      'image': await MultipartFile.fromFile(filePath),
    });
    final response = await _client.postMultipart(
      ApiEndpoints.fieldImages,
      formData: formData,
    );
    return CourtImageModel.fromJson(response);
  }

  @override
  Future<void> deleteFieldImage(String imageId) async {
    await _client.delete(ApiEndpoints.fieldImageDetail(imageId));
  }
}
