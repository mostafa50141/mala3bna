import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final _key = 'isDarkMode';

  // Get current theme from storage, default to dark
  bool get isDarkMode => _storage.read(_key) ?? true;

  // Get ThemeMode based on isDarkMode
  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Toggle theme and save to storage
  void toggleTheme() {
    _storage.write(_key, !isDarkMode);
    Get.changeThemeMode(themeMode);
    update();
  }

  // Set explicit theme
  void setThemeMode(bool isDark) {
    _storage.write(_key, isDark);
    Get.changeThemeMode(themeMode);
    update();
  }
}
