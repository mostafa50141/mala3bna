import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_animateds_snack_bar.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/custom_circular_loading.dart';
import 'package:mala3bna/core/widgets/custome_gradiant.dart';
import 'package:mala3bna/core/widgets/custome_text_field.dart';
import 'package:mala3bna/features/auth/data/Repos/reset_password_repo.dart';
import 'package:mala3bna/features/auth/presentation/views/otp_verification_screen.dart';
import 'package:mala3bna/features/auth/presentation/views_model/cubit/reset_password_cubit.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(getIt.get<ResetPasswordRepo>()),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is SendEmailSuccess) {
            Get.to(
              () => OTPVerificationScreen(
                cubit: context.read<ResetPasswordCubit>(),
              ),
            );
          } else if (state is ResetPasswordFailure) {
            showAnimatedSnackDialog(
              context,
              message: state.errorMessage,
              type: AnimatedSnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: GradientBackground(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Gap(10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_reset,
                            size: 40,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const Gap(24),
                        Text(
                          "Forgot Password?",
                          style: Style.textStyle30Bold.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(12),
                        Text(
                          "Enter your email to receive a reset code",
                          style: Style.textStyle16.copyWith(
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(40),
                        CustomTextfield(
                          controller: emailController,
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
                          hintText: "Email Address",
                          obscureText: false,
                          width: double.infinity,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.white70,
                          ),
                          fillcolor: const Color(0xFF2C3617).withOpacity(0.3),
                        ),
                        const Gap(24),
                        state is ResetPasswordLoading
                            ? const CustomeCircularLaoding()
                            : CustomBtn(
                                text: 'Send Reset Code →',
                                height: 50,
                                width: double.infinity,
                                radius: 25,
                                weightText: FontWeight.bold,
                                sizeText: 18,
                                onTap: () {
                                  if (emailController.text.trim().isEmpty) {
                                    showAnimatedSnackDialog(
                                      context,
                                      message: "Please enter your email",
                                      type: AnimatedSnackBarType.warning,
                                    );
                                    return;
                                  }
                                  if (formKey.currentState!.validate()) {
                                    context
                                        .read<ResetPasswordCubit>()
                                        .sendEmail(
                                          email: emailController.text.trim(),
                                        );
                                  }
                                },
                              ),
                        const Gap(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Remember your password?",
                              style: Style.textStyle16.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Back to Login',
                                style: Style.textStyle16Bold.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
