import 'package:dio/dio.dart';

class ApiService {
  final String _baseUrl = "https://graduation8project.pythonanywhere.com/api/v1/";
  // final String _baseUrl = "https://fakestoreapi.com/";

  final Dio dio;

  ApiService({required this.dio});
  Future<dynamic> get({
    required String endPoint,
    Options? options,
  }) async {
    var response = await dio.get(
      endPoint.startsWith('http') ? endPoint : '$_baseUrl$endPoint',
      options: options,
    );
    return response.data;
  }

  Future<dynamic> post({
    required String endPoint,
    required Map<String, dynamic> body,
    Options? options,
  }) async {
    var response = await dio.post(
      endPoint.startsWith('http') ? endPoint : '$_baseUrl$endPoint',
      data: body,
      options: options,
    );
    return response.data;
  }

  Future<dynamic> delete({required String endPoint}) async {
    var response = await dio.delete('$_baseUrl$endPoint');
    return response.data;
  }
}
