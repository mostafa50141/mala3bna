import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/view_model/court_view_model.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/action_buttons.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/amenities_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/header_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/pricing_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/rating_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/reviews_List.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/tabs_section.dart';
import 'package:provider/provider.dart';

class CourtProfileBody extends StatelessWidget {
  const CourtProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourtViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Consumer<CourtViewModel>(
          builder: (context, vm, _) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Hero image with app bar overlay ──────────────────
                  HeaderSection(vm: vm),

                  // ── Content below image ───────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
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
                        const RatingsSection(),

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
          },
        ),
      ),
    );
  }
}
