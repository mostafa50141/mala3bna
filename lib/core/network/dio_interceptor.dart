import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await getIt.get<LocalStorageHelper>().gettoken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Try to refresh token
      try {
        final refreshToken = await getIt.get<LocalStorageHelper>().getRefreshToken();
        if (refreshToken != null && refreshToken.isNotEmpty) {
          final response = await Dio().post(
            'https://graduation8project.pythonanywhere.com/api/v1/auth/token/refresh/',
            data: {'refresh': refreshToken},
          );
          final newAccessToken = response.data['access'];
          await getIt.get<LocalStorageHelper>().savetoken(newAccessToken);
          
          // Retry original request
          err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          final retryResponse = await Dio().fetch(err.requestOptions);
          handler.resolve(retryResponse);
          return;
        }
      } catch (e) {
        debugPrint('Token refresh failed: $e');
      }
    }
    handler.next(err);
  }
}
