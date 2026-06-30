import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_cubit.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_state.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Top app bar showing the owner's greeting, avatar, and notification bell.
class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerProfileCubit, OwnerProfileState>(
      builder: (context, profileState) {
        return BlocBuilder<OwnerDashboardCubit, OwnerDashboardState>(
          builder: (context, dashboardState) {
            String ownerName = '...';
            String? profileImage;

            if (profileState is OwnerProfileLoaded) {
              ownerName = profileState.profile.name;
              profileImage = profileState.profile.imageUrl;
            } else if (profileState is OwnerProfileUpdating) {
              ownerName = profileState.profile.name;
              profileImage = profileState.profile.imageUrl;
            } else if (profileState is OwnerProfileUpdateError) {
              ownerName = profileState.profile.name;
              profileImage = profileState.profile.imageUrl;
            } else if (profileState is OwnerProfileUpdateSuccess) {
              ownerName = profileState.profile.name;
              profileImage = profileState.profile.imageUrl;
            } else if (dashboardState is OwnerDashboardLoaded) {
              ownerName = dashboardState.dashboardData.ownerName;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  // ── Avatar ──
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primaryColor.withValues(alpha: 0.25),
                          Theme.of(context).cardColor,
                        ],
                      ),
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: profileImage != null && profileImage.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: profileImage,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.person_rounded,
                              color: AppColors.primaryColor,
                              size: 22,
                            ),
                          )
                        : Icon(
                            Icons.person_rounded,
                            color: AppColors.primaryColor,
                            size: 22,
                          ),
                  ),
                  const SizedBox(width: 14),

                  // ── Greeting ──
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _greeting().tr,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6) ?? Colors.white.withValues(alpha: 0.45),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          ownerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Notification Bell ──
                  GestureDetector(
                    onTap: () => _showNotificationsSheet(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.1) ?? Colors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.notifications_none_rounded,
                              color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white,
                              size: 22,
                            ),
                          ),
                          // Live indicator dot
                          Positioned(
                            top: 10,
                            right: 11,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).cardColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Returns a time-aware greeting string.
  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }

  /// Opens a bottom sheet showing the notifications panel.
  void _showNotificationsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _NotificationsSheet(),
    );
  }
}

// ─── Notifications Bottom Sheet ───────────────────────────────────────────────

class _NotificationsSheet extends StatelessWidget {
  const _NotificationsSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.06) ?? Colors.white.withValues(alpha: 0.06)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Row(
            children: [
              Icon(
                Icons.notifications_rounded,
                color: AppColors.primaryColor,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                'Notifications'.tr,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Empty state
          Icon(
            Icons.notifications_off_outlined,
            size: 52,
            color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.15) ?? Colors.white.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications yet'.tr,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6) ?? Colors.white.withValues(alpha: 0.6),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "You're all caught up! New alerts\nwill appear here.".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.4) ?? Colors.white.withValues(alpha: 0.35),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
