import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/role/app_root.dart';
import 'package:mala3bna/core/role/user_role.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custome_circular_laoding.dart';
import 'package:mala3bna/features/auth/presentation/data/auth_controller.dart';
import 'package:mala3bna/features/auth/presentation/views/login_screen.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/contuie_with.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/custome_Choice_Chip.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/custome_toggle_tab.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/navigate_to_term.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/custome_gradiant.dart';
import 'package:mala3bna/core/widgets/custome_text_field.dart';
import 'package:mala3bna/features/auth/presentation/views_model/cubit/auth_cubit.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController name;
  late TextEditingController phone;

  UserRole selectedRole = UserRole.player;
  GlobalKey<FormState> formkay = GlobalKey();
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    phone = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: GradientBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            child: SingleChildScrollView(
              child: Form(
                key: formkay,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(30),
                    Text("Create Your\n Account", style: Style.textStyle35Bold),
                    const Gap(10),
                    CustomeToggleTab(
                      onLoginTap: () {
                        Get.to(const LoginScreen());
                      },
                    ),
                    const Gap(30),
                    Text("Email Address", style: Style.textStyle16Bold),
                    CustomTextfield(
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "⚠️Please enter an email";
                        } else if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return "⚠️ Please enter a valid email";
                        }
                        return null;
                      },
                      hintText: " Enter Your Email",
                      obscureText: false,
                      width: 350,
                      fillcolor: Color(0xFF2C3617).withOpacity(0.3),
                    ),
                    const Gap(10),
                    Text("Password", style: Style.textStyle16Bold),
                    PasswordTextField(controller: password),
                    const Gap(10),
                    Text("Full name ", style: Style.textStyle16Bold),
                    CustomTextfield(
                        controller: name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "⚠️Please enter your full name";
                        }
                        return null;
                      },
                      hintText: " Enter Your Full name",
                      obscureText: false,
                      width: 350,
                      fillcolor: Color(0xFF2C3617).withOpacity(0.3),
                    ),
                    const Gap(10),
                    Text("phone ", style: Style.textStyle16Bold),
                    CustomTextfield(
                      controller: phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "⚠️ Please enter a phone number";
                        } else if (!RegExp(
                          r'^\+?[0-9]{7,15}$',
                        ).hasMatch(value)) {
                          return "⚠️ Please enter a valid phone number";
                        }
                        return null;
                      },
                      hintText: "Phone",
                      obscureText: false,
                      width: 350,
                      fillcolor: Color(0xFF2C3617).withOpacity(0.3),
                    ),
                    const Gap(10),
                    Text("I am a ....", style: Style.textStyle16Bold),
                    const Gap(5),
                    CustomeChoiceChip(
                      onRoleSelected: (role) {
                        setState(() {
                          selectedRole = role;
                        });
                      },
                    ),
                    const Gap(30),
                    BlocConsumer<AuthCubit, AuthState>(
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
                          return const Center(
                            child: CustomeCircularLaoding()
                          );
                        }
                        return CustomBtn(
                          text: ' Sign Up ',
                          height: 50,
                          width: 350,
                          radius: 25,
                          weightText: FontWeight.bold,
                          sizeText: 18,
                          onTap: () {
                            if (formkay.currentState!.validate()) {
                              authController.setRole(selectedRole);

                              Get.offAll(() => const AppRoot());
                            }
                          },
                        );
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
      ),
    );
  }
}
