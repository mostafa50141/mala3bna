import 'package:dio/dio.dart';
import 'package:mala3bna/core/network/api_endpoints.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';

/// Attaches the JWT access token to every outgoing request.
/// On 401, transparently refreshes the access token using the refresh token
/// and retries the original request. On refresh failure, clears all stored
/// tokens so the app can redirect to login.
class AuthInterceptor extends Interceptor {
  final LocalStorageHelper _storage;

  /// A separate bare Dio instance used ONLY for the refresh call.
  /// Using a separate instance avoids infinite interceptor loops.
  final Dio _refreshDio;

  bool _isRefreshing = false;
  final List<_PendingRequest> _queue = [];

  AuthInterceptor({
    required LocalStorageHelper storage,
    required Dio refreshDio,
  })  : _storage = storage,
        _refreshDio = refreshDio;

  // ── Attach Bearer token to every request ───────────────────────────────────
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip Authorization on refresh endpoint itself to avoid loops.
    if (options.path.contains(ApiEndpoints.tokenRefresh)) {
      return handler.next(options);
    }
    final token = await _storage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      print('DEBUG AuthInterceptor: Attached Bearer token to ${options.path} — ${token.substring(0, 20)}...');
    } else {
      print('DEBUG AuthInterceptor: NO token found for ${options.path} — request will be unauthenticated!');
    }
    handler.next(options);
  }

  // ── Handle 401 — refresh then retry ────────────────────────────────────────
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final isRefreshEndpoint =
        err.requestOptions.path.contains(ApiEndpoints.tokenRefresh);

    // Only handle 401 on non-refresh endpoints.
    if (statusCode != 401 || isRefreshEndpoint) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      // Queue requests that arrive while a refresh is in progress.
      _queue.add(_PendingRequest(err.requestOptions, handler));
      return;
    }

    _isRefreshing = true;
    try {
      final refreshed = await _performTokenRefresh();
      if (refreshed) {
        // Retry all queued requests first.
        for (final pending in _queue) {
          await _retryRequest(pending.options, pending.handler);
        }
        _queue.clear();
        // Retry the request that triggered the 401.
        await _retryRequest(err.requestOptions, handler);
      } else {
        // Refresh failed — clear tokens so the app knows the session is dead.
        await _storage.clearAllTokens();
        for (final pending in _queue) {
          pending.handler.next(
            DioException(requestOptions: pending.options),
          );
        }
        _queue.clear();
        handler.next(err);
      }
    } finally {
      _isRefreshing = false;
    }
  }

  Future<bool> _performTokenRefresh() async {
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return false;

    try {
      final response = await _refreshDio.post(
        ApiEndpoints.tokenRefresh,
        data: {'refresh': refreshToken},
      );
      final data = response.data as Map<String, dynamic>;
      final newAccess = data['access'] as String?;
      final newRefresh = data['refresh'] as String?; // rotated refresh token

      if (newAccess == null) return false;
      await _storage.saveAccessToken(newAccess);
      if (newRefresh != null) await _storage.saveRefreshToken(newRefresh);
      return true;
    } on DioException {
      return false;
    }
  }

  Future<void> _retryRequest(
    RequestOptions options,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final token = await _storage.getAccessToken();
      final updatedOptions = options.copyWith(
        headers: {...options.headers, 'Authorization': 'Bearer $token'},
      );
      final response = await _refreshDio.fetch(updatedOptions);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }
}

/// Holds a failed request and its handler so it can be retried after refresh.
class _PendingRequest {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;
  const _PendingRequest(this.options, this.handler);
}
