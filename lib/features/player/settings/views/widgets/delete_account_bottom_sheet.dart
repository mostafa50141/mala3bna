import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_animateds_snack_bar.dart';
import 'package:mala3bna/core/widgets/custom_circular_loading.dart';
import 'package:mala3bna/features/player/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:mala3bna/features/player/profile/presentation/cubit/user_profile_state.dart';
import 'package:mala3bna/features/welcome_screen/presentation/views/welcome_screen.dart';

class DeleteAccountBottomSheet extends StatefulWidget {
  const DeleteAccountBottomSheet({super.key});

  @override
  State<DeleteAccountBottomSheet> createState() =>
      _DeleteAccountBottomSheetState();
}

class _DeleteAccountBottomSheetState extends State<DeleteAccountBottomSheet> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileDeleted) {
          Navigator.pop(context);
          Get.offAll(() => const WelcomeScreen());
        } else if (state is UserProfileDeleteFailure) {
          showAnimatedSnackDialog(
            context,
            message: state.errorMessage,
            type: AnimatedSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          decoration: const BoxDecoration(
            color: AppColors.colorBtnAndCard,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Handle bar ────────────────────────────────────────
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(16),

              // ── Warning icon + title ──────────────────────────────
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    'Delete Account',
                    style: Style.textStyle18Bold.copyWith(color: Colors.red),
                  ),
                ],
              ),
              const Gap(12),

              Text(
                'This action is permanent and cannot be undone. '
                'All your bookings and data will be lost forever.',
                style: Style.textStyle14.copyWith(color: Colors.grey.shade400),
              ),
              const Gap(20),

              Text(
                'Enter your password to confirm:',
                style: Style.textStyle14Bold.copyWith(color: Colors.white),
              ),
              const Gap(8),

              // ── Password field ────────────────────────────────────
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Your password',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              const Gap(20),

              // ── Delete button / Loading ───────────────────────────
              state is UserProfileDeleting
                  ? const Center(child: CustomeCircularLaoding())
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_passwordController.text.trim().isEmpty) {
                            showAnimatedSnackDialog(
                              context,
                              message: 'Please enter your password',
                              type: AnimatedSnackBarType.warning,
                            );
                            return;
                          }
                          // Second guard: confirmation dialog
                          showDialog<void>(
                            context: context,
                            builder: (dialogCtx) => AlertDialog(
                              backgroundColor: AppColors.colorBtnAndCard,
                              title: Text(
                                'Are you sure?',
                                style: Style.textStyle18Bold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              content: Text(
                                'Your account will be permanently deleted.',
                                style: Style.textStyle14.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogCtx),
                                  child: Text(
                                    'Cancel',
                                    style: Style.textStyle14Bold.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogCtx);
                                    context
                                        .read<UserProfileCubit>()
                                        .deleteAccount(
                                          password: _passwordController.text
                                              .trim(),
                                        );
                                  },
                                  child: Text(
                                    'Delete',
                                    style: Style.textStyle14Bold.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Delete My Account',
                          style: Style.textStyle16Bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
              const Gap(8),

              // ── Cancel button ─────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: Style.textStyle16Bold.copyWith(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
