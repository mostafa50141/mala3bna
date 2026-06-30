import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/owner/setting/domain/repositories/setting_repository.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/change_password_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/change_password_state.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/change_password_field.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/password_strength_bar.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/password_requirements.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordCubit(getIt<SettingRepository>()),
      child: const _ChangePasswordBody(),
    );
  }
}

class _ChangePasswordBody extends StatefulWidget {
  const _ChangePasswordBody();

  @override
  State<_ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<_ChangePasswordBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                isError ? Icons.error_outline : Icons.check_circle_outline,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(message,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          backgroundColor:
              isError ? Colors.redAccent.shade700 : AppColors.primaryColor,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
          duration: Duration(seconds: isError ? 4 : 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.arrow_back_ios_new,
                size: 18, color: isDark ? Colors.white : Colors.black87),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Change Password'.tr,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              Icons.shield_outlined,
              color: AppColors.primaryColor,
              size: 22,
            ),
          ),
        ],
      ),
      body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state.status == ChangePasswordStatus.success) {
            HapticFeedback.mediumImpact();
            _showSnack('Password updated successfully!'.tr);
            Future.delayed(
              const Duration(milliseconds: 800),
              () {
                if (context.mounted) Navigator.of(context).pop();
              },
            );
          }
          if (state.status == ChangePasswordStatus.failure &&
              state.errorMessage != null) {
            _showSnack(state.errorMessage!, isError: true);
          }
          if (state.status == ChangePasswordStatus.initial &&
              state.errorMessage != null) {
            _showSnack(state.errorMessage!, isError: true);
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: SlideTransition(
              position: _slideAnim,
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                  physics: const BouncingScrollPhysics(),
                  child: _buildContent(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        final cubit = context.read<ChangePasswordCubit>();
        final isSubmitting =
            state.status == ChangePasswordStatus.submitting;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Text(
              'Secure Your Account'.tr,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Ensure you\'re using a long, random password\nto stay secure.'.tr,
              style: TextStyle(
                color: isDark ? Colors.white.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.5),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            // ── Current Password ──
            _fieldLabel(context, 'Current Password'.tr),
            const SizedBox(height: 8),
            ChangePasswordField(
              hint: 'Enter current password'.tr,
              icon: Icons.lock_outline,
              isVisible: state.isCurrentPasswordVisible,
              onChanged: cubit.currentPasswordChanged,
              onToggleVisibility: cubit.toggleCurrentPasswordVisibility,
              enabled: !isSubmitting,
            ),
            const SizedBox(height: 24),

            // ── New Password ──
            _fieldLabel(context, 'New Password'.tr),
            const SizedBox(height: 8),
            ChangePasswordField(
              hint: 'Enter new password'.tr,
              icon: Icons.lock_outline,
              isVisible: state.isNewPasswordVisible,
              onChanged: cubit.newPasswordChanged,
              onToggleVisibility: cubit.toggleNewPasswordVisibility,
              enabled: !isSubmitting,
            ),
            const SizedBox(height: 12),

            // ── Strength Bar ──
            if (state.newPassword.isNotEmpty)
              PasswordStrengthBar(
                progress: state.strengthProgress,
                label: state.strengthLabel,
              ),
            const SizedBox(height: 24),

            // ── Confirm Password ──
            _fieldLabel(context, 'Confirm New Password'.tr),
            const SizedBox(height: 8),
            ChangePasswordField(
              hint: 'Repeat new password'.tr,
              icon: Icons.lock_outline,
              isVisible: state.isConfirmPasswordVisible,
              onChanged: cubit.confirmPasswordChanged,
              onToggleVisibility: cubit.toggleConfirmPasswordVisibility,
              enabled: !isSubmitting,
              showMatchIcon: state.confirmPassword.isNotEmpty,
              isMatch: state.passwordsMatch,
            ),
            const SizedBox(height: 24),

            // ── Requirements ──
            PasswordRequirements(
              hasMinLength: state.hasMinLength,
              hasUppercase: state.hasUppercase,
              hasSpecialChar: state.hasSpecialChar,
              isVisible: state.newPassword.isNotEmpty,
            ),
            const SizedBox(height: 36),

            // ── Submit Button ──
            _buildSubmitButton(state, cubit, isSubmitting),
            const SizedBox(height: 20),

            // ── Footer ──
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_rounded,
                      size: 14,
                      color: isDark ? Colors.white.withValues(alpha: 0.25) : Colors.black.withValues(alpha: 0.25)),
                  const SizedBox(width: 6),
                  Text(
                    'Encrypted end-to-end'.tr,
                    style: TextStyle(
                      color: isDark ? Colors.white.withValues(alpha: 0.25) : Colors.black.withValues(alpha: 0.25),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _fieldLabel(BuildContext context, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      label,
      style: TextStyle(
        color: isDark ? Colors.white.withValues(alpha: 0.7) : Colors.black.withValues(alpha: 0.7),
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildSubmitButton(
    ChangePasswordState state,
    ChangePasswordCubit cubit,
    bool isSubmitting,
  ) {
    final isValid = state.isFormValid && !isSubmitting;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: isValid
              ? [
                  AppColors.primaryColor,
                  AppColors.primaryColor.withValues(alpha: 0.8),
                ]
              : [
                  AppColors.primaryColor.withValues(alpha: 0.25),
                  AppColors.primaryColor.withValues(alpha: 0.15),
                ],
        ),
        boxShadow: isValid
            ? [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: isValid ? () => cubit.submit() : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isSubmitting
              ? const SizedBox(
                  key: ValueKey('loading'),
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Row(
                  key: const ValueKey('label'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Update Password'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.security_rounded,
                      size: 18,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
