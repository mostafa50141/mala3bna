import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_animateds_snack_bar.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/custome_circular_laoding.dart';
import 'package:mala3bna/core/widgets/custome_gradiant.dart';
import 'package:mala3bna/features/auth/presentation/views/login_screen.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:mala3bna/features/auth/presentation/views_model/cubit/reset_password_cubit.dart';

class CreateNewPasswordBody extends StatefulWidget {
  const CreateNewPasswordBody({super.key});

  @override
  State<CreateNewPasswordBody> createState() => _CreateNewPasswordBodyState();
}

class _CreateNewPasswordBodyState extends State<CreateNewPasswordBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          showAnimatedSnackDialog(
            context,
            message: "Password reset successfully!",
            type: AnimatedSnackBarType.success,
          );
          Get.offAll(() => const LoginScreen());
        } else if (state is ResetPasswordFailure) {
          showAnimatedSnackDialog(
            context,
            message: state.errorMessage,
            type: AnimatedSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: GradientBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.key,
                        size: 40,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const Gap(24),
                    Text(
                      "Create New Password",
                      style: Style.textStyle30Bold.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(12),
                    Text(
                      "Your new password must be different from previous",
                      style: Style.textStyle16.copyWith(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(40),
                    PasswordTextField(
                      controller: _newPasswordController,
                      hintText: "New Password",
                    ),
                    const Gap(16),
                    PasswordTextField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                    ),
                    const Gap(40),
                    state is ResetPasswordLoading
                        ? const CustomeCircularLaoding()
                        : CustomBtn(
                            text: 'Reset Password',
                            height: 50,
                            width: double.infinity,
                            radius: 25,
                            weightText: FontWeight.bold,
                            sizeText: 18,
                            colorText: Colors.white,
                            // onTap: () {
                            //   if (_formKey.currentState!.validate()) {
                            //     if (_newPasswordController.text !=
                            //         _confirmPasswordController.text) {
                            //       showAnimatedSnackDialog(
                            //         context,
                            //         message: "⚠️ Passwords do not match",
                            //         type: AnimatedSnackBarType.warning,
                            //       );
                            //       return;
                            //     }
                            //     context.read<ResetPasswordCubit>().resetPassword(
                            //           newPassword: _newPasswordController.text,
                            //         );
                            //   }
                            // },
                            onTap: () {
                              Get.offAll(() => const LoginScreen());
                            },
                          ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
