import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_state.dart';
import 'package:mala3bna/features/owner/courts/presentation/model/court_profile_model.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/action_buttons.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/amenities_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/header_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/pricing_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/rating_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/reviews_list.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/tabs_section.dart';

class CourtProfileBody extends StatefulWidget {
  const CourtProfileBody({super.key});

  @override
  State<CourtProfileBody> createState() => _CourtProfileBodyState();
}

class _CourtProfileBodyState extends State<CourtProfileBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<CourtProfileCubit, CourtProfileState>(
        builder: (context, state) {
          if (state is CourtProfileLoading) {
            return const _CourtProfileSkeleton();
          }

          if (state is CourtProfileError) {
            return _ErrorState(
              message: state.message,
              onRetry: () =>
                  context.read<CourtProfileCubit>().loadCourtProfile(),
            );
          }

          if (state is CourtProfileLoaded) {
            _fadeCtrl.forward();
            final vm = state.courtProfile;

            return FadeTransition(
              opacity: _fadeAnim,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: HeaderSection(vm: vm)),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const ActionButtons(),
                        const SizedBox(height: 20),
                        TabsSection(
                          onTabChanged: (i) =>
                              setState(() => _selectedTab = i),
                        ),
                        const SizedBox(height: 20),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          transitionBuilder: (child, anim) =>
                              FadeTransition(opacity: anim, child: child),
                          child: _selectedTab == 0
                              ? _DetailsTab(key: const ValueKey(0), vm: vm)
                              : const _BookingsTab(key: ValueKey(1)),
                        ),
                      ]),
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

// ─── Details Tab ───────────────────────────────────────────────────────────────
class _DetailsTab extends StatelessWidget {
  final CourtProfileModel vm;

  const _DetailsTab({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PricingSection(),
        const SizedBox(height: 16),
        AmenitiesSectionCourtProfile(vm: vm),
        const SizedBox(height: 16),
        RatingsSection(vm: vm),
        const SizedBox(height: 16),
        ReviewsList(reviews: vm.reviews),
      ],
    );
  }
}

// ─── Bookings Tab Placeholder ──────────────────────────────────────────────────
class _BookingsTab extends StatelessWidget {
  const _BookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(Icons.calendar_today_outlined,
                  size: 36, color: AppColors.primaryColor),
            ),
            const SizedBox(height: 20),
            const Text(
              'No bookings yet',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Upcoming reservations will appear here.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Skeleton Loading ──────────────────────────────────────────────────────────
class _CourtProfileSkeleton extends StatefulWidget {
  const _CourtProfileSkeleton();

  @override
  State<_CourtProfileSkeleton> createState() => _CourtProfileSkeletonState();
}

class _CourtProfileSkeletonState extends State<_CourtProfileSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heroHeight = MediaQuery.of(context).size.height * 0.30;

    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final opacity = 0.12 + (_anim.value * 0.15);
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              _SkeletonBox(height: heroHeight, opacity: opacity, radius: 0),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                          child: _SkeletonBox(
                              height: 48, opacity: opacity, radius: 12)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _SkeletonBox(
                              height: 48, opacity: opacity, radius: 12)),
                    ]),
                    const SizedBox(height: 20),
                    _SkeletonBox(height: 46, opacity: opacity, radius: 12),
                    const SizedBox(height: 20),
                    _SkeletonBox(height: 120, opacity: opacity, radius: 16),
                    const SizedBox(height: 16),
                    _SkeletonBox(height: 140, opacity: opacity, radius: 16),
                    const SizedBox(height: 16),
                    _SkeletonBox(height: 170, opacity: opacity, radius: 16),
                    const SizedBox(height: 16),
                    _SkeletonBox(height: 100, opacity: opacity, radius: 16),
                    const SizedBox(height: 16),
                    _SkeletonBox(height: 100, opacity: opacity, radius: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double height;
  final double opacity;
  final double radius;

  const _SkeletonBox(
      {required this.height, required this.opacity, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(radius),
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Icon(Icons.cloud_off_outlined,
                  size: 44, color: AppColors.primaryColor),
            ),
            const SizedBox(height: 24),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Try Again',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15)),
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
      ),
    );
  }
}
