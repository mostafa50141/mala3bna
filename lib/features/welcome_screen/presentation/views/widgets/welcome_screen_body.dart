import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/assets_data.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/auth/presentation/views/login_screen.dart';
import 'package:mala3bna/features/auth/presentation/views/sign_up_screen.dart';
import 'package:mala3bna/features/player/home/presentation/views/home_view.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/custome_circular_avatar.dart';

class WelcomeScreenBody extends StatelessWidget {
  const WelcomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Lottie.asset(
                'assets/animations/Football team players.json',
                fit: BoxFit.cover,
                repeat: true,
              ),
            ),

            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.3), // لتغشيش خفيف على الخلفية
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  CustomeCirculerAvtar(
                    backgroundImage: AssetImage(AssetsData.logo),
                  ),
                  const Spacer(flex: 2),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Your Court Awaits',
                          style: Style.textStyle30Bold,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Book courts, find players, and connect\n with coaches across Egypt.',
                          style: Style.textStyle16Bold.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        CustomBtn(
                          text: ' Log In ',
                          height: 50,
                          width: 350,
                          radius: 25,
                          weightText: FontWeight.bold,
                          sizeText: 18,
                          onTap: () {
                            Get.to(const LoginScreen());
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomBtn(
                          text: 'Sign Up',
                          height: 50,
                          width: 350,
                          radius: 25,
                          color: Colors.transparent,
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          colorText: AppColors.primaryColor,
                          sizeText: 18,
                          weightText: FontWeight.bold,
                          onTap: () {
                            Get.to(const SignUpScreen());
                          },
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Get.to(const HomeView());
                          },
                          child: Text(
                            'Continue as Guest',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
