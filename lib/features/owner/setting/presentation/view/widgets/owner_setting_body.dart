import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_state.dart';
import 'package:mala3bna/features/owner/setting/presentation/model/owner_profile_model.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/edit_profile_view.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/profile_header_card.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/settings_appbar.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/settings_content.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/social_footer.dart';

class OwnerSettingsBody extends StatefulWidget {
  const OwnerSettingsBody({super.key});

  @override
  State<OwnerSettingsBody> createState() => _OwnerSettingsBodyState();
}

class _OwnerSettingsBodyState extends State<OwnerSettingsBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  OwnerProfileModel _extractProfile(OwnerProfileState state) {
    if (state is OwnerProfileLoaded) return state.profile;
    if (state is OwnerProfileUpdating) return state.profile;
    if (state is OwnerProfileUpdateSuccess) return state.profile;
    return (state as OwnerProfileUpdateError).profile;
  }

  void _showSnackBar(BuildContext ctx,
      {required String message, required bool isError}) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Row(children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ]),
        backgroundColor: isError ? Colors.redAccent : AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<OwnerProfileCubit, OwnerProfileState>(
        listener: (ctx, state) {
          if (state is OwnerProfileUpdateSuccess) {
            _showSnackBar(ctx,
                message: 'Profile updated successfully!', isError: false);
          }
          if (state is OwnerProfileUpdateError) {
            _showSnackBar(ctx, message: state.message, isError: true);
          }
        },
        builder: (ctx, state) {
          if (state is OwnerProfileLoading) {
            return const _SettingsSkeleton();
          }

          if (state is OwnerProfileError) {
            return _ErrorState(
              message: state.message,
              onRetry: () => ctx.read<OwnerProfileCubit>().loadProfile(),
            );
          }

          if (state is OwnerProfileLoaded ||
              state is OwnerProfileUpdating ||
              state is OwnerProfileUpdateSuccess ||
              state is OwnerProfileUpdateError) {
            _fadeCtrl.forward();
            final profile = _extractProfile(state);
            final isUpdating = state is OwnerProfileUpdating;

            return FadeTransition(
              opacity: _fadeAnim,
              child: Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding:
                            const EdgeInsets.fromLTRB(16, 16, 16, 40),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            const SettingAppBar(),
                            const SizedBox(height: 16),
                            const Divider(color: Colors.white10, height: 1),
                            const SizedBox(height: 16),
                            ProfileHeaderCard(
                              username: profile.username,
                              fullName: profile.fullName,
                              birthDate: profile.birthDate,
                              gender: profile.gender,
                              imageUrl: profile.imageUrl,
                              onEditPressed: () {
                                final cubit =
                                    ctx.read<OwnerProfileCubit>();
                                Navigator.push(
                                  ctx,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: cubit,
                                      child: const EditProfileView(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            const SettingsContent(),
                            const SizedBox(height: 12),
                            const Divider(color: Colors.white10, height: 1),
                            const SizedBox(height: 8),
                            const SocialFooter(),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  // Thin progress bar while updating
                  if (isUpdating)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: LinearProgressIndicator(
                        color: AppColors.primaryColor,
                        backgroundColor:
                            AppColors.primaryColor.withValues(alpha: 0.15),
                        minHeight: 3,
                      ),
                    ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ─── Skeleton Loading ──────────────────────────────────────────────────────────
class _SettingsSkeleton extends StatefulWidget {
  const _SettingsSkeleton();

  @override
  State<_SettingsSkeleton> createState() => _SettingsSkeletonState();
}

class _SettingsSkeletonState extends State<_SettingsSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final op = 0.10 + (_anim.value * 0.14);
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              // App bar skeleton
              Row(children: [
                _Box(w: 40, h: 40, op: op, r: 12),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _Box(w: 80, h: 14, op: op, r: 6),
                  const SizedBox(height: 6),
                  _Box(w: 130, h: 11, op: op, r: 6),
                ]),
              ]),
              const SizedBox(height: 20),
              // Profile card skeleton
              _Box(w: double.infinity, h: 110, op: op, r: 20),
              const SizedBox(height: 24),
              // Section label
              _Box(w: 80, h: 12, op: op, r: 6),
              const SizedBox(height: 12),
              for (int i = 0; i < 6; i++) ...[
                _Box(w: double.infinity, h: 58, op: op, r: 18),
                const SizedBox(height: 8),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _Box extends StatelessWidget {
  final double w, h, op, r;
  const _Box({required this.w, required this.h, required this.op, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: op),
        borderRadius: BorderRadius.circular(r),
      ),
    );
  }
}

// ─── Error State ───────────────────────────────────────────────────────────────
class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  width: 2),
            ),
            child: Icon(Icons.cloud_off_outlined,
                size: 40, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 24),
          const Text('Could not load profile',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(message,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(color: Colors.grey, fontSize: 13, height: 1.5)),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Try Again',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
