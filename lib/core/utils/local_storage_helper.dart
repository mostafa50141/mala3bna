// creating a helper class to handle local storage operations using secure package package
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageHelper {
  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // ─── Auth token ─────────────────────────────────────────────────────────────

  Future<void> savetoken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> gettoken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<void> deletetoken() async {
    await storage.delete(key: 'token');
  }

  // ─── Onboarding seen flag ───────────────────────────────────────────────────

  /// Persists that the user has completed (or skipped) onboarding.
  Future<void> saveOnboardingSeen() async {
    await storage.write(key: 'onboarding_seen', value: 'true');
  }

  /// Returns [true] if the user has already seen onboarding; [false] otherwise.
  Future<bool> isOnboardingSeen() async {
    final value = await storage.read(key: 'onboarding_seen');
    return value == 'true';
  }
}
