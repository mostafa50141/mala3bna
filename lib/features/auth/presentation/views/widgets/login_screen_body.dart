import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/assets_data.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/forget_password_body.dart';
import 'package:mala3bna/features/auth/presentation/views/sign_up_screen.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/contuie_with.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:mala3bna/features/home/presentation/views/home_view.dart';
import 'package:mala3bna/shared/widgets/custom_btn.dart';
import 'package:mala3bna/shared/widgets/custome_circular_avatar.dart';
import 'package:mala3bna/shared/widgets/custome_gradiant.dart';
import 'package:mala3bna/shared/widgets/custome_text_field.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GradientBackground(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),
                const CustomeCirculerAvtar(
                  backgroundImage: AssetImage(AssetsData.logo),
                ),
                const Gap(40),
                const Center(
                  child: Text("Welcome Back!", style: Style.textStyle30Bold),
                ),
                Center(
                  child: Text(
                    "Log in to continue your journey",
                    style: Style.textStyle16.copyWith(
                      color: AppColors.fieldBackground,
                    ),
                  ),
                ),
                const Gap(80),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text("Email Address", style: Style.textStyle16Bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomTextfield(
                    hintText: "Email",
                    obscureText: false,
                    width: 350,
                    fillcolor: Color(0xFF2C3617).withOpacity(0.3),
                  ),
                ),
                const Gap(20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text("Password", style: Style.textStyle16Bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: PasswordTextField(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(const ForgetPasswordBody());
                      },
                      child: Text(
                        'Forgot Password?',
                        style: Style.textStyle16.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(48),

                Center(
                  child: CustomBtn(
                    text: ' Log In ',
                    height: 50,
                    width: 350,
                    radius: 25,
                    weightText: FontWeight.bold,
                    sizeText: 18,
                    onTap: () {
                      Get.to(const HomeView());
                    },
                  ),
                ),
                const Gap(40),
                const CustomeContinueWith(),

                const Gap(25),
                Row(
                  children: [
                    const Spacer(flex: 2),
                    Text(
                      "Don't have an account?",
                      style: Style.textStyle16.copyWith(
                        color: AppColors.fieldBackground,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const SignUpScreen());
                      },
                      child: Text(
                        'Sign Up',
                        style: Style.textStyle16Bold.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
