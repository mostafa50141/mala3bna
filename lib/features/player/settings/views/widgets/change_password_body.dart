import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/password_text_field.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;

  @override
  void initState() {
    super.initState();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(30),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.lock,
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                ),
              ),
              const Gap(40),

              Text("Current Password", style: Style.textStyle16Bold),
              const Gap(4),
              PasswordTextField(controller: currentPasswordController),

              const Gap(20),

              Text("New Password", style: Style.textStyle16Bold),
              const Gap(4),
              PasswordTextField(controller: newPasswordController),
              const Gap(4),
              Text(
                "Must be at least 8 characters",
                style: Style.textStyle12.copyWith(color: Colors.grey),
              ),

              const Gap(20),

              Text("Confirm New Password", style: Style.textStyle16Bold),
              const Gap(4),
              PasswordTextField(controller: confirmNewPasswordController),

              const Gap(40),

              CustomBtn(
                text: 'Save Changes',
                height: 50,
                width: double.infinity,
                radius: 25,
                weightText: FontWeight.bold,
                sizeText: 18,
                colorText: Colors.white,
                onTap: () {
                  // Logic to change password
                },
              ),
              const Gap(60),
            ],
          ),
        ),
      ),
    );
  }
}
