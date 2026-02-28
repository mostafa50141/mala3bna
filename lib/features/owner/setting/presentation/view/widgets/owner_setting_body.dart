import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/profile_header_card.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/settings_appbar.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/settings_content.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/social_footer.dart';

class OwnerSettingsBody extends StatelessWidget {
  const OwnerSettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
          const SettingAppBar(),
          const SizedBox(height: 10),
          const Divider(thickness: 0.5),
          ProfileHeaderCard(
            username: "mostafa22",
            fullName: "Mostafa Abdelaziz",
            birthDate: "22 Apr 2004",
            gender: "Male",
            imageUrl: "real-image-url",
            onEditPressed: () {},
          ),
          const SizedBox(height: 20),
          const SectionTitle(title: "Settings"),
          const SizedBox(height: 10),
          const SettingsContent(),
          const SizedBox(height: 10),
          const Divider(thickness: 0.5),
          const SocialFooter(),
        ],
      ),
    );
  }
}
