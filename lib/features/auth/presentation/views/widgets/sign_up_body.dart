import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/contuie_with.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/custome_Choice_Chip.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/custome_toggle_tab.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/navigate_to_term.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:mala3bna/features/home/presentation/views/home_view.dart';
import 'package:mala3bna/shared/widgets/custom_btn.dart';
import 'package:mala3bna/shared/widgets/custome_gradiant.dart';
import 'package:mala3bna/shared/widgets/custome_text_field.dart';
class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GradientBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(30),
                  Text("Create Your\n Account", style: Style.textStyle35Bold),
                  const Gap(10),
                  CustomeToggleTab(),
                  const Gap(30),
                  const Text("Email Address", style: Style.textStyle16Bold),
                  CustomTextfield(
                    hintText: " Enter Your Email",
                    obscureText: false,
                    width: 350,
                    fillcolor: Color(0xFF2C3617).withOpacity(0.3),
                  ),
                  const Gap(10),
                  const Text("Password", style: Style.textStyle16Bold),
                  PasswordTextField(),
                  // CustomTextfield(
                  //   hintText: "Password",
                  //   obscureText: true,
                  //   width: 350,
                  //   fillcolor: Color(0xFF2C3617).withOpacity(0.3),
                  //   suffixIcon: IconButton(
                  //     icon: Icon(Icons.visibility_off),
                  //     color: Colors.white70,
                  //     onPressed: () {

                  //     },
                  //   ),
                  // ),
                  const Gap(10),
                  const Text("Full name ", style: Style.textStyle16Bold),
                  CustomTextfield(
                    hintText: " Enter Your Full name",
                    obscureText: false,
                    width: 350,
                    fillcolor: Color(0xFF2C3617).withOpacity(0.3),
                  ),
                  const Gap(10),
                  const Text("phone ", style: Style.textStyle16Bold),
                  CustomTextfield(
                    hintText: "Phone",
                    obscureText: false,
                    width: 350,
                    fillcolor: Color(0xFF2C3617).withOpacity(0.3),
                  ),
                  const Gap(10),
                  const Text("I am a ....", style: Style.textStyle16Bold),
                  const Gap(5),
                  const CustomeChoiceChip(),
                  const Gap(30),
                  CustomBtn(
                    text: ' Sign Up ',
                    height: 50,
                    width: 350,
                    radius: 25,
                    weightText: FontWeight.bold,
                    sizeText: 18,
                    onTap: () {
                      Get.to(const HomeView());
                    },
                  ),
                  const Gap(30),
                  const CustomeContinueWith(),
                  const Gap(10),
                  const NavigateToTerms(),

                  Gap(60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
