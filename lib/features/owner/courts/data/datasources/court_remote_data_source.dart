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
    required List<String> amenityIds,
  });
  Future<CourtModel> updateField({
    required String id,
    String? title,
    double? hourlyRate,
    String? address,
    List<String>? amenityIds,
  });
  Future<CourtModel> toggleFieldStatus(String id);
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
    return CourtModel.fromJson(response);
  }

  @override
  Future<CourtModel> addField({
    required String title,
    required double hourlyRate,
    required String address,
    required List<String> amenityIds,
  }) async {
    final response = await _client.post(
      ApiEndpoints.fields,
      data: {
        'title': title,
        'hourly_rate': hourlyRate,
        'address': address,
        'amenities': amenityIds,
      },
    );
    return CourtModel.fromJson(response);
  }

  @override
  Future<CourtModel> updateField({
    required String id,
    String? title,
    double? hourlyRate,
    String? address,
    List<String>? amenityIds,
  }) async {
    final Map<String, dynamic> data = {};
    if (title != null) data['name'] = title;
    if (hourlyRate != null) data['price_per_hour'] = hourlyRate;
    if (address != null) data['address'] = address;

    // Backend uses boolean flags, not a list of amenity IDs
    if (amenityIds != null) {
      data['has_lights']    = amenityIds.contains('lights');
      data['has_showers']   = amenityIds.contains('showers');
      data['has_cafe']      = amenityIds.contains('cafe');
      data['has_equipment'] = amenityIds.contains('equipment');
    }

    print('[UpdateField] Sending PATCH (form-urlencoded) to ${ApiEndpoints.fieldDetail(id)}');
    print('[UpdateField] Body: $data');

    // Use form-urlencoded (lighter than multipart, no file overhead)
    // Django accepts this via FormParser alongside MultiPartParser
    final rawResponse = await _client.patchForm(
      ApiEndpoints.fieldDetail(id),
      data: data,
    );

    print('[UpdateField] Response: $rawResponse');
    return CourtModel.fromJson(rawResponse);
  }

  @override
  Future<CourtModel> toggleFieldStatus(String id) async {
    final response = await _client.post(ApiEndpoints.fieldToggleStatus(id));
    return CourtModel.fromJson(response);
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
