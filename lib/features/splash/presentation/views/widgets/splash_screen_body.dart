import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/role/app_root.dart';
import 'package:mala3bna/core/utils/assets_data.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/sliding_text.dart';
import 'package:mala3bna/features/welcome_screen/presentation/views/welcome_screen.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    _checkTokenAndNavigate();
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsData.splashscreenBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsData.splashscreenLogo),

            SizedBox(height: 20),
            SlidingText(slidingAnimation: slidingAnimation),
          ],
        ),
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 5),
      end: const Offset(0, 0),
    ).animate(animationController);
    animationController.forward();
  }
  Future<void> _checkTokenAndNavigate() async {
  await Future.delayed(const Duration(seconds: 3));
  final token = await getIt.get<LocalStorageHelper>().gettoken();
  if (token != null && token.isNotEmpty) {
    Get.offAll(
      () => const AppRoot(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 500),
    );
  } else {
    Get.offAll(
      () => const WelcomeScreen(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 500),
    );
  }
}
}
