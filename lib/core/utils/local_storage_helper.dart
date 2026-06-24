// Helper class to handle local storage operations using flutter_secure_storage.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageHelper {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _onboardingKey = 'onboarding_seen';

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // ─── Access Token ─────────────────────────────────────────────────────────

  Future<void> saveAccessToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);

  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);

  Future<void> deleteAccessToken() => _storage.delete(key: _accessTokenKey);

  // ─── Refresh Token ────────────────────────────────────────────────────────

  Future<void> saveRefreshToken(String token) =>
      _storage.write(key: _refreshTokenKey, value: token);

  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<void> deleteRefreshToken() => _storage.delete(key: _refreshTokenKey);

  // ─── Save / clear both tokens together ───────────────────────────────────

  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await saveAccessToken(access);
    await saveRefreshToken(refresh);
  }

  Future<void> clearAllTokens() async {
    await deleteAccessToken();
    await deleteRefreshToken();
  }

  // ─── Backward-compat aliases (used by existing auth feature) ─────────────

  /// Saves an access token. Prefer [saveAccessToken] for new code.
  Future<void> savetoken(String token) => saveAccessToken(token);

  /// Returns the stored access token. Prefer [getAccessToken] for new code.
  Future<String?> gettoken() => getAccessToken();

  /// Deletes the stored access token. Prefer [deleteAccessToken] for new code.
  Future<void> deletetoken() => deleteAccessToken();

  // ─── Onboarding seen flag ─────────────────────────────────────────────────

  /// Persists that the user has completed (or skipped) onboarding.
  Future<void> saveOnboardingSeen() =>
      _storage.write(key: _onboardingKey, value: 'true');

  /// Returns [true] if the user has already seen onboarding; [false] otherwise.
  Future<bool> isOnboardingSeen() async {
    final value = await _storage.read(key: _onboardingKey);
    return value == 'true';
  }
}
