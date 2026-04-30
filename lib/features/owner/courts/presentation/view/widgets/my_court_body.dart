import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_state.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/action_buttons.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/amenities_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/header_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/pricing_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/rating_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/reviews_List.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/tabs_section.dart';

class CourtProfileBody extends StatelessWidget {
  const CourtProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<CourtProfileCubit, CourtProfileState>(
        builder: (context, state) {
          if (state is CourtProfileLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is CourtProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.grey[600],
                    size: 52,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.read<CourtProfileCubit>().loadCourtProfile(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is CourtProfileLoaded) {
            final vm = state.courtProfile;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Hero image with app bar overlay ──────────────────
                  HeaderSection(vm: vm),

                  // ── Content below image ───────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Edit / Disable buttons
                        const ActionButtons(),

                        const SizedBox(height: 16),

                        // Details / Bookings tab toggle
                        const TabsSection(),

                        const SizedBox(height: 20),

                        // Pricing card
                        const PricingSection(),

                        const SizedBox(height: 16),

                        // Amenities card
                        AmenitiesSectionCourtProfile(vm: vm),

                        const SizedBox(height: 16),

                        // Reviews & Ratings card (header inside widget)
                        RatingsSection(vm: vm),

                        const SizedBox(height: 16),

                        // Individual review cards
                        ReviewsList(reviews: vm.reviews),

                        const SizedBox(height: 32),
                      ],
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
