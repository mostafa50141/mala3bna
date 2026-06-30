import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_animateds_snack_bar.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/custom_circular_loading.dart';
import 'package:mala3bna/core/widgets/custome_gradiant.dart';
import 'package:mala3bna/features/auth/presentation/views/create_new_password_screen.dart';
import 'package:mala3bna/features/auth/presentation/views_model/cubit/reset_password_cubit.dart';

class OTPVerificationBody extends StatefulWidget {
  const OTPVerificationBody({super.key});

  @override
  State<OTPVerificationBody> createState() => _OTPVerificationBodyState();
}

class _OTPVerificationBodyState extends State<OTPVerificationBody> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  Widget _buildOTPBox(int index) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFF2C3617).withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _focusNodes[index].hasFocus
              ? AppColors.primaryColor
              : Colors.transparent,
        ),
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: Style.textStyle16Bold.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
          ),
          onChanged: (value) => _onChanged(value, index),
          onTap: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    for (var node in _focusNodes) {
      node.addListener(() {
        if (!mounted) return;
        setState(() {}); // Trigger rebuild to update border color
      });
    }

    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccess) {
          Get.to(
            () => CreateNewPasswordScreen(
              cubit: context.read<ResetPasswordCubit>(),
            ),
          );
        } else if (state is ResetPasswordFailure) {
          showAnimatedSnackDialog(
            context,
            message: state.errorMessage,
            type: AnimatedSnackBarType.error,
          );
        } else if (state is SendEmailSuccess) {
          showAnimatedSnackDialog(
            context,
            message: "OTP has been resent successfully!",
            type: AnimatedSnackBarType.success,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<ResetPasswordCubit>();
        return SafeArea(
          child: GradientBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shield,
                      size: 40,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const Gap(24),
                  Text(
                    "Enter Verification Code",
                    style: Style.textStyle30Bold.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(12),
                  Text(
                    "We sent a 6-digit code to ${cubit.email}",
                    style: Style.textStyle16.copyWith(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) => _buildOTPBox(index)),
                  ),
                  const Gap(40),
                  state is ResetPasswordLoading
                      ? const CustomeCircularLaoding()
                      : CustomBtn(
                          text: 'Verify Code',
                          height: 50,
                          width: double.infinity,
                          radius: 25,
                          weightText: FontWeight.bold,
                          sizeText: 18,
                          onTap: () {
                            String otp = _controllers.map((c) => c.text).join();
                            if (otp.length < 6) {
                              showAnimatedSnackDialog(
                                context,
                                message: "Please enter the 6-digit code",
                                type: AnimatedSnackBarType.warning,
                              );
                              return;
                            }
                            context.read<ResetPasswordCubit>().verifyOtp(
                              otp: otp,
                            );
                          },
                        ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code?",
                        style: Style.textStyle16.copyWith(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: state is ResetPasswordLoading
                            ? null
                            : () {
                                context.read<ResetPasswordCubit>().sendEmail(
                                  email: cubit.email,
                                );
                              },
                        child: Text(
                          'Resend Code',
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
        );
      },
    );
  }
}
