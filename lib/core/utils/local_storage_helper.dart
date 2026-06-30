// Helper class to handle local storage operations using flutter_secure_storage.
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/booking_model.dart';

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

  /// Deletes the stored access token and user data.
  Future<void> deletetoken() async {
    await deleteAccessToken();
    await deleteUserData();
    await deleteAllBookings();
  }

  // ─── Onboarding seen flag ─────────────────────────────────────────────────

  /// Persists that the user has completed (or skipped) onboarding.
  Future<void> saveOnboardingSeen() =>
      _storage.write(key: _onboardingKey, value: 'true');

  /// Returns [true] if the user has already seen onboarding; [false] otherwise.
  Future<bool> isOnboardingSeen() async {
    final value = await _storage.read(key: _onboardingKey);
    return value == 'true';
  }

  // ─── User Data ────────────────────────────────────────────────────────────

  Future<void> saveUserData({
    required String name,
    required String email,
    required String phone,
    required String userType,
  }) async {
    await _storage.write(key: 'user_name', value: name);
    await _storage.write(key: 'user_email', value: email);
    await _storage.write(key: 'user_phone', value: phone);
    await _storage.write(key: 'user_type', value: userType);
  }

  Future<String> getUserName() async =>
      await _storage.read(key: 'user_name') ?? '';
  Future<String> getUserEmail() async =>
      await _storage.read(key: 'user_email') ?? '';
  Future<String> getUserPhone() async =>
      await _storage.read(key: 'user_phone') ?? '';
  Future<String> getUserType() async =>
      await _storage.read(key: 'user_type') ?? '';

  Future<void> deleteUserData() async {
    await _storage.delete(key: 'user_name');
    await _storage.delete(key: 'user_email');
    await _storage.delete(key: 'user_phone');
    await _storage.delete(key: 'user_type');
  }

  // ─── Profile Image ────────────────────────────────────────────────────────

  Future<void> saveProfileImagePath(String path) async {
    await _storage.write(key: 'profile_image_path', value: path);
  }

  Future<String?> getProfileImagePath() async {
    return await _storage.read(key: 'profile_image_path');
  }

  Future<void> deleteProfileImagePath() async {
    await _storage.delete(key: 'profile_image_path');
  }

  // ─── Bookings ─────────────────────────────────────────────────────────────

  Future<void> saveBooking(BookingModel booking) async {
    final existing = await getBookings();
    existing.add(booking);
    final jsonList = existing.map((b) => jsonEncode(b.toJson())).toList();
    await _storage.write(key: 'bookings', value: jsonEncode(jsonList));
  }

  Future<List<BookingModel>> getBookings() async {
    final raw = await _storage.read(key: 'bookings');
    if (raw == null || raw.isEmpty) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((item) => BookingModel.fromJson(jsonDecode(item))).toList();
  }

  Future<void> cancelBooking(String bookingId) async {
    final bookings = await getBookings();
    final updated = bookings.map((b) {
      if (b.id.toString() == bookingId) {
        return BookingModel(
          id: b.id,
          fieldId: b.fieldId,
          courtName: b.courtName,
          courtImage: b.courtImage,
          sport: b.sport,
          date: b.date,
          startTime: b.startTime,
          endTime: b.endTime,
          duration: b.duration,
          price: b.price,
          status: 'cancelled',
        );
      }
      return b;
    }).toList();
    final jsonList = updated.map((b) => jsonEncode(b.toJson())).toList();
    await _storage.write(key: 'bookings', value: jsonEncode(jsonList));
  }

  Future<void> deleteAllBookings() async {
    await _storage.delete(key: 'bookings');
  }
}
