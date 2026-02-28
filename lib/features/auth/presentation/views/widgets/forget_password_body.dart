import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/assets_data.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/custome_circular_avatar.dart';
import 'package:mala3bna/core/widgets/custome_gradiant.dart';
import 'package:mala3bna/core/widgets/custome_text_field.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GradientBackground(
          child: Column(
            children: [
              const Gap(200),
              const CustomeCirculerAvtar(
                backgroundImage: AssetImage(AssetsData.logo),
              ),
              const Gap(60),

              const Text("Reset Password", style: Style.textStyle26),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  "Enter your email to receive reset instructions.",
                  style: Style.textStyle16.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(60),
              CustomTextfield(
                hintText: "Email",
                obscureText: false,
                width: 350,
                fillcolor: Color(0xFF2C3617).withOpacity(0.3),
              ),
              const Gap(20),
              Center(
                child: CustomBtn(
                  text: ' Send a Reset Link',
                  height: 50,
                  width: 350,
                  radius: 25,
                  sizeText: 18,
                  onTap: () {},
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remember your password? ",
                      style: Style.textStyle16.copyWith(
                        color: AppColors.fieldBackground,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: Style.textStyle16Bold.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
