import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/courts/presentation/view_model/court_view_model.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/action_buttons.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/amenities_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/header_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/pricing_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/rating_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/widgets/reviews_List.dart';
import 'package:provider/provider.dart';

class CourtProfileBody extends StatelessWidget {
  const CourtProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourtViewModel(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<CourtViewModel>(
            builder: (context, vm, _) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      HeaderSection(vm: vm),
                      const SizedBox(height: 16),
                      ActionButtons(),
                      //const SizedBox(height: 16),
                      //TabsSection(),
                      const SizedBox(height: 16),
                      PricingSection(),
                      const SizedBox(height: 16),
                      AmenitiesSectionCourtProfile(vm: vm),
                      const SizedBox(height: 16),
                      const Divider(thickness: 0.5, endIndent: 16, indent: 16),
                      const SizedBox(height: 16),
                      RatingsSection(),
                      const SizedBox(height: 16),
                      ReviewsList(reviews: vm.reviews),
                      const SizedBox(height: 16),
                      const Divider(thickness: 0.5, endIndent: 16, indent: 16),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
