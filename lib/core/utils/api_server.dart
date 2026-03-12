import 'package:dio/dio.dart';

class ApiService {
  final String _baseUrl = "https://bqsl6hrg-8000.uks1.devtunnels.ms/api/v1/";
  final Dio dio;

  ApiService({required this.dio});
  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await dio.get('$_baseUrl$endPoint');
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> body,
  }) async {
    var response = await dio.post('$_baseUrl$endPoint', data: body);
    return response.data;
  }
}
