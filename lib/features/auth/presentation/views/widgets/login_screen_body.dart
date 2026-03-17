import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/role/app_root.dart';
import 'package:mala3bna/core/utils/assets_data.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/auth/presentation/data/auth_controller.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/forget_password_body.dart';
import 'package:mala3bna/features/auth/presentation/views/sign_up_screen.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/contuie_with.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/custome_circular_avatar.dart';
import 'package:mala3bna/core/widgets/custome_gradiant.dart';
import 'package:mala3bna/core/widgets/custome_text_field.dart';
import 'package:mala3bna/features/auth/presentation/views_model/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final GlobalKey<FormState> formkay = GlobalKey();
  late TextEditingController email;
  late TextEditingController password;
  final authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              Get.snackbar("Error", state.errorMessage);
            }
            if (state is AuthSuccess) {
              Get.offAll(() => const AppRoot());
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: GradientBackground(
                child: Form(
                  key: formkay,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(40),
                      const CustomeCirculerAvtar(
                        backgroundImage: AssetImage(AssetsData.logo),
                      ),
                      const Gap(40),
                      Center(
                        child: Text(
                          "Welcome Back!",
                          style: Style.textStyle30Bold,
                        ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Text(
                          "Email Address",
                          style: Style.textStyle16Bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomTextfield(
                          controller: email,
                          hintText: "Email",
                          obscureText: false,
                          width: 350,
                          fillcolor: Color(0xFF2C3617).withOpacity(0.3),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "⚠️ Please enter an email";
                            } else if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return "⚠️ Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                      ),
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Text("Password", style: Style.textStyle16Bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: PasswordTextField(controller: password),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.to(() => const ForgetPasswordBody());
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
                            if (!formkay.currentState!.validate()) {
                              return;
                            }
                            if (authController.userRole.value == null) {
                              Get.snackbar(
                                "Error",
                                "No account found. Please Sign Up first.",
                              );
                              return;
                            }
                            context.read<AuthCubit>().login(
                              email: email.text.trim(),
                              password: password.text.trim(),
                            );

                            Get.offAll(() => const AppRoot());
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
                              Get.to(() => const SignUpScreen());
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
            );
          },
        ),
      ),
    );
  }
}
