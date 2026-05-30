// creating a helper class to handle local storage operations using secure package package
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/booking_model.dart';

class LocalStorageHelper {
  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  Future<void> savetoken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> gettoken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<void> deletetoken() async {
    await storage.delete(key: 'token');
    await deleteUserData();
    await deleteAllBookings();
  }

  Future<void> saveUserData({
    required String name,
    required String email,
    required String phone,
    required String userType,
  }) async {
    await storage.write(key: 'user_name', value: name);
    await storage.write(key: 'user_email', value: email);
    await storage.write(key: 'user_phone', value: phone);
    await storage.write(key: 'user_type', value: userType);
  }

  Future<String> getUserName() async =>
      await storage.read(key: 'user_name') ?? '';
  Future<String> getUserEmail() async =>
      await storage.read(key: 'user_email') ?? '';
  Future<String> getUserPhone() async =>
      await storage.read(key: 'user_phone') ?? '';
  Future<String> getUserType() async =>
      await storage.read(key: 'user_type') ?? '';

  Future<void> deleteUserData() async {
    await storage.delete(key: 'user_name');
    await storage.delete(key: 'user_email');
    await storage.delete(key: 'user_phone');
    await storage.delete(key: 'user_type');
  }

  Future<void> saveProfileImagePath(String path) async {
    await storage.write(key: 'profile_image_path', value: path);
  }

  Future<String?> getProfileImagePath() async {
    return await storage.read(key: 'profile_image_path');
  }

  Future<void> deleteProfileImagePath() async {
    await storage.delete(key: 'profile_image_path');
  }

  Future<void> saveBooking(BookingModel booking) async {
    final existing = await getBookings();
    existing.add(booking);
    final jsonList = existing.map((b) => jsonEncode(b.toJson())).toList();
    await storage.write(key: 'bookings', value: jsonEncode(jsonList));
  }

  Future<List<BookingModel>> getBookings() async {
    final raw = await storage.read(key: 'bookings');
    if (raw == null || raw.isEmpty) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((item) => BookingModel.fromJson(jsonDecode(item))).toList();
  }

  Future<void> cancelBooking(String bookingId) async {
    final bookings = await getBookings();
    final updated = bookings.map((b) {
      if (b.id == bookingId) {
        return BookingModel(
          id: b.id,
          courtName: b.courtName,
          courtLocation: b.courtLocation,
          courtImage: b.courtImage,
          sport: b.sport,
          date: b.date,
          time: b.time,
          price: b.price,
          status: 'cancelled',
        );
      }
      return b;
    }).toList();
    final jsonList = updated.map((b) => jsonEncode(b.toJson())).toList();
    await storage.write(key: 'bookings', value: jsonEncode(jsonList));
  }

  Future<void> deleteAllBookings() async {
    await storage.delete(key: 'bookings');
  }
}
