import 'package:dio/dio.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/network/auth_interceptor.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';

/// Central HTTP client for all owner feature API calls.
/// Wraps Dio with:
///   - JWT Bearer auth + auto-refresh via [AuthInterceptor]
///   - Unified error translation (DioException → ServerFailure)
///   - Typed helpers: get, post, patch, delete, postMultipart
class DioClient {
  static const String _baseUrl =
      'https://graduation8project.pythonanywhere.com/api/v1/';

  late final Dio _dio;

  DioClient(LocalStorageHelper storage) {
    // Bare Dio used only by AuthInterceptor for token-refresh calls.
    // Must NOT have AuthInterceptor attached (would cause infinite loop).
    final refreshDio = Dio(BaseOptions(baseUrl: _baseUrl));

    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      AuthInterceptor(storage: storage, refreshDio: refreshDio),
    );
  }

  // ─── GET ──────────────────────────────────────────────────────────────────

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  // ─── POST ─────────────────────────────────────────────────────────────────

  Future<dynamic> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  // ─── PATCH ────────────────────────────────────────────────────────────────

  Future<dynamic> patch(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.patch(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  // ─── DELETE ───────────────────────────────────────────────────────────────

  Future<dynamic> delete(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  // ─── POST multipart (image / file upload) ─────────────────────────────────

  Future<dynamic> postMultipart(
    String endpoint, {
    required FormData formData,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  // ─── PATCH multipart (update with form fields) ─────────────────────────────

  Future<dynamic> patchMultipart(
    String endpoint, {
    required FormData formData,
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  // ─── PATCH form-urlencoded (lightweight, no file upload) ─────────────────

  Future<dynamic> patchForm(
    String endpoint, {
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }
}
