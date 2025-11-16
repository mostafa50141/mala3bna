import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/Splash_Screen/presentation/views/splash_screen.dart';
// import 'package:mala3bna/root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      home: const SplashScreen(),
    );
  }
}
