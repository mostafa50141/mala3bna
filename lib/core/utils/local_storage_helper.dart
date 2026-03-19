// creating a helper class to handle local storage operations using secure package package
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageHelper {
  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  Future<void> savetoken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> gettoken() async {
    return await storage.read(key: 'token')??'';
  }

  Future<void> deletetoken() async {
    await storage.delete(key: 'token');
  }
}
