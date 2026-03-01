import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_app_bar.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_picture.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 5),
              EditProfileAppBar(),
              SizedBox(height: 10),
              EditProfilePicture(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
