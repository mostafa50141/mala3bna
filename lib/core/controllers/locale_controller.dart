import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Controls the app locale and persists it across sessions via GetStorage.
///
/// Usage:
///   `Get.find<LocaleController>().changeLocale('ar');`
///   `Get.find<LocaleController>().changeLocale('en');`
class LocaleController extends GetxController {
  static const _storageKey = 'app_locale';

  final _box = GetStorage();

  /// The currently active locale (reactive).
  final Rx<Locale> locale = const Locale('en').obs;

  @override
  void onInit() {
    super.onInit();
    // Restore persisted locale on app start
    final saved = _box.read<String>(_storageKey);
    if (saved != null) {
      locale.value = Locale(saved);
      Get.updateLocale(Locale(saved));
    }
  }

  /// Switch to [languageCode] ('en' or 'ar') and persist the choice.
  void changeLocale(String languageCode) {
    final newLocale = Locale(languageCode);
    locale.value = newLocale;
    _box.write(_storageKey, languageCode);
    Get.updateLocale(newLocale);
  }

  /// Whether the current locale is Arabic.
  bool get isArabic => locale.value.languageCode == 'ar';

  /// Whether the current locale is English.
  bool get isEnglish => locale.value.languageCode == 'en';
}
