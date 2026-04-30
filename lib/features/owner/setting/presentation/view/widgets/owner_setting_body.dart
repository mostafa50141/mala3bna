import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_state.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/edit_profile_view.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/profile_header_card.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/settings_appbar.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/settings_content.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/social_footer.dart';

class OwnerSettingsBody extends StatelessWidget {
  const OwnerSettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<OwnerProfileCubit, OwnerProfileState>(
        builder: (context, state) {
          if (state is OwnerProfileLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is OwnerProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.grey[600], size: 52),
                  const SizedBox(height: 16),
                  Text(state.message, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.read<OwnerProfileCubit>().loadProfile(),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                    child: const Text("Retry", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          if (state is OwnerProfileLoaded || state is OwnerProfileUpdating || state is OwnerProfileUpdateSuccess || state is OwnerProfileUpdateError) {
            // Extract profile from any of these states
            final profile = (state is OwnerProfileLoaded)
                ? state.profile
                : (state is OwnerProfileUpdating)
                    ? state.profile
                    : (state is OwnerProfileUpdateSuccess)
                        ? state.profile
                        : (state as OwnerProfileUpdateError).profile;

            return ListView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              children: [
                const SettingAppBar(),
                const SizedBox(height: 10),
                const Divider(thickness: 0.5),
                ProfileHeaderCard(
                  username: profile.username,
                  fullName: profile.fullName,
                  birthDate: profile.birthDate,
                  gender: profile.gender,
                  imageUrl: profile.imageUrl,
                  onEditPressed: () {
                    // Navigate to EditProfileView and pass the cubit instance to share state
                    final cubit = context.read<OwnerProfileCubit>();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: cubit,
                          child: const EditProfileView(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const SectionTitle(title: "Settings"),
                const SizedBox(height: 10),
                const SettingsContent(),
                const SizedBox(height: 10),
                const Divider(thickness: 0.5),
                const SocialFooter(),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
