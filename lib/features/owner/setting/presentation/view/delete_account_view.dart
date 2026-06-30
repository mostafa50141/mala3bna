import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/auth/presentation/data/auth_controller.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/owner/setting/domain/repositories/setting_repository.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/delete_account_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/delete_account_state.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/delete_account_danger_icon.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/delete_account_delete_button.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/delete_account_keep_button.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/delete_account_password_field.dart';
import 'package:mala3bna/features/splash/presentation/views/splash_screen.dart';

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeleteAccountCubit(getIt<SettingRepository>()),
      child: const _DeleteAccountBody(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Body — orchestrates layout, animation, and state listening
// ─────────────────────────────────────────────────────────────────────────────

class _DeleteAccountBody extends StatefulWidget {
  const _DeleteAccountBody();

  @override
  State<_DeleteAccountBody> createState() => _DeleteAccountBodyState();
}

class _DeleteAccountBodyState extends State<_DeleteAccountBody>
    with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  late final AnimationController _iconCtrl;
  late final Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();
    _iconCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _iconScale = CurvedAnimation(parent: _iconCtrl, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _iconCtrl.dispose();
    super.dispose();
  }

  // ─── Listener ───────────────────────────────────────────────────────

  void _onStateChanged(BuildContext context, DeleteAccountState state) {
    if (state.status == DeleteAccountStatus.success) {
      HapticFeedback.mediumImpact();
      _handleSuccessNavigation(context);
    }
    if (state.status == DeleteAccountStatus.failure &&
        state.errorMessage != null) {
      HapticFeedback.heavyImpact();
      _showErrorSnack(context, state.errorMessage!);
    }
  }

  void _handleSuccessNavigation(BuildContext context) {
    Get.find<AuthController>().logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SplashScreen()),
      (_) => false,
    );
  }

  void _showErrorSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.redAccent.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
        ),
      );
  }

  // ─── Build ──────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context, isDark),
      body: BlocListener<DeleteAccountCubit, DeleteAccountState>(
        listener: _onStateChanged,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              physics: const BouncingScrollPhysics(),
              child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
                builder: (context, state) {
                  final cubit = context.read<DeleteAccountCubit>();
                  final isLoading =
                      state.status == DeleteAccountStatus.loading;

                  return Column(
                    children: [
                      // ── Danger Icon ──
                      ScaleTransition(
                        scale: _iconScale,
                        child: const DeleteAccountDangerIcon(),
                      ),
                      const SizedBox(height: 28),

                      // ── Title ──
                      Text(
                        'Are you sure you want\nto delete your\naccount?'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ── Subtitle ──
                      Text(
                        'This action is permanent. All your bookings,\nstats, and personal data will be erased\nforever.'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white.withValues(alpha: 0.45) : Colors.black.withValues(alpha: 0.45),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 36),

                      // ── Password Field ──
                      DeleteAccountPasswordField(
                        controller: _passwordController,
                        isVisible: state.isPasswordVisible,
                        isEnabled: !isLoading,
                        onChanged: cubit.passwordChanged,
                        onToggleVisibility: cubit.togglePasswordVisibility,
                      ),
                      const SizedBox(height: 28),

                      // ── Delete Button ──
                      DeleteAccountDeleteButton(
                        isLoading: isLoading,
                        canSubmit: state.canSubmit,
                        onPressed: cubit.deleteAccount,
                      ),
                      const SizedBox(height: 14),

                      // ── Keep Account Button ──
                      DeleteAccountKeepButton(
                        isEnabled: !isLoading,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(height: 40),

                      // ── Brand Footer ──
                      Text(
                        'Mala3bna',
                        style: TextStyle(
                          color:
                              AppColors.primaryColor.withValues(alpha: 0.5),
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isDark) {
    return AppBar(
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
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Account Security'.tr,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      centerTitle: true,
    );
  }
}
