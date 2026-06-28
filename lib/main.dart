import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/controllers/locale_controller.dart';
import 'package:mala3bna/core/translations/app_translations.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/auth/presentation/data/auth_controller.dart';
import 'package:mala3bna/features/splash/presentation/views/splash_screen.dart';
import 'package:mala3bna/generated/l10n.dart';

void main() async {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AuthController());
  Get.put(LocaleController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocaleController>(
      builder: (localeCtrl) {
        return GetMaterialApp(
          locale: localeCtrl.locale.value,
          // GetX translations (covers all .tr keys in the app)
          translations: AppTranslations(),
          debugShowCheckedModeBanner: false,
          // Support both English and Arabic
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // Automatically mirrors layout for Arabic (RTL)
          localeResolutionCallback: (locale, supported) {
            if (locale == null) return const Locale('en');
            for (final s in supported) {
              if (s.languageCode == locale.languageCode) return s;
            }
            return const Locale('en');
          },
          theme: ThemeData.dark().copyWith(
            textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
            splashColor: Colors.transparent,
            scaffoldBackgroundColor: AppColors.backgroundColor,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
