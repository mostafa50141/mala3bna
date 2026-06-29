import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_animateds_snack_bar.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/custome_circular_laoding.dart';
import 'package:mala3bna/core/widgets/custome_text_field.dart';
import 'package:mala3bna/features/player/profile/data/repos/user_profile_repo.dart';
import 'package:mala3bna/features/player/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:mala3bna/features/player/profile/presentation/cubit/user_profile_state.dart';

// ── Outer wrapper: owns BlocProvider ────────────────────────────────────────
class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          UserProfileCubit(getIt.get<UserProfileRepo>())..getProfile(),
      child: const _EditProfileContent(),
    );
  }
}

// ── Inner content ────────────────────────────────────────────────────────────
class _EditProfileContent extends StatefulWidget {
  const _EditProfileContent();

  @override
  State<_EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<_EditProfileContent> {
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();

  File? _selectedImage;
  String? _networkImageUrl; // profile_image from API

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 500,
        maxHeight: 500,
      );
      if (image == null) return;

      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final permanentPath = '${appDir.path}/$fileName';
      final permanentFile = await File(image.path).copy(permanentPath);

      if (!await permanentFile.exists()) return;

      await getIt
          .get<LocalStorageHelper>()
          .saveProfileImagePath(permanentFile.path);

      setState(() {
        _selectedImage = permanentFile;
      });
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: Text(
        text,
        style: Style.textStyle14Bold.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildAvatar() {
    if (_selectedImage != null) {
      return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: FileImage(_selectedImage!),
      );
    }
    if (_networkImageUrl != null && _networkImageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: _networkImageUrl!,
        imageBuilder: (ctx, imageProvider) => CircleAvatar(
          radius: 50,
          backgroundImage: imageProvider,
        ),
        placeholder: (ctx, url) => CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade800,
          child: const CustomeCircularLaoding(),
        ),
        errorWidget: (ctx, url, err) => CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade800,
          child: const Icon(Icons.person, size: 50, color: Colors.white),
        ),
      );
    }
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey.shade800,
      child: const Icon(Icons.person, size: 50, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(24),
    );

    return BlocListener<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileLoaded) {
          _fullNameController.text = state.profile.fullName;
          _usernameController.text = state.profile.username;
          _phoneController.text = state.profile.phoneNumber ?? '';
          _bioController.text = state.profile.bio ?? '';
          setState(() => _networkImageUrl = state.profile.profileImage);
        } else if (state is UserProfileUpdated) {
          showAnimatedSnackDialog(
            context,
            message: 'Profile updated successfully!',
            type: AnimatedSnackBarType.success,
          );
          Get.back();
        } else if (state is UserProfileFailure) {
          showAnimatedSnackDialog(
            context,
            message: state.errorMessage,
            type: AnimatedSnackBarType.error,
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Avatar section ──────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        _buildAvatar(),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.backgroundColor,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    // Show name from controller (populated by BlocListener)
                    BlocBuilder<UserProfileCubit, UserProfileState>(
                      builder: (context, state) {
                        if (state is UserProfileLoading) {
                          return const CustomeCircularLaoding();
                        }
                        return Column(
                          children: [
                            Text(
                              _fullNameController.text.isNotEmpty
                                  ? _fullNameController.text
                                  : '—',
                              style: Style.textStyle20Bold
                                  .copyWith(color: Colors.white),
                            ),
                            const Gap(4),
                            Text(
                              _usernameController.text.isNotEmpty
                                  ? '@${_usernameController.text}'
                                  : '',
                              style: Style.textStyle14
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Gap(32),

              // ── Form fields ─────────────────────────────────────
              _buildLabel('Full Name'),
              CustomTextfield(
                controller: _fullNameController,
                hintText: 'Enter your full name',
                fillcolor: AppColors.colorBtnAndCard,
                border: border,
                prefixIcon:
                    const Icon(Icons.person, color: Colors.white70),
              ),

              _buildLabel('Username'),
              CustomTextfield(
                controller: _usernameController,
                hintText: 'Enter your username',
                fillcolor: AppColors.colorBtnAndCard,
                border: border,
                prefixIcon: const Icon(Icons.alternate_email,
                    color: Colors.white70),
              ),

              _buildLabel('Phone Number'),
              CustomTextfield(
                controller: _phoneController,
                hintText: 'Enter your phone number',
                keyboardType: TextInputType.phone,
                fillcolor: AppColors.colorBtnAndCard,
                border: border,
                prefixIcon:
                    const Icon(Icons.phone, color: Colors.white70),
              ),

              _buildLabel('Bio'),
              CustomTextfield(
                controller: _bioController,
                hintText: 'Tell us about yourself',
                fillcolor: AppColors.colorBtnAndCard,
                border: border,
                prefixIcon: const Icon(Icons.info_outline,
                    color: Colors.white70),
              ),

              const Gap(40),

              // ── Save button ─────────────────────────────────────
              BlocBuilder<UserProfileCubit, UserProfileState>(
                builder: (context, state) {
                  if (state is UserProfileLoading) {
                    return const Center(child: CustomeCircularLaoding());
                  }
                  return CustomBtn(
                    text: 'Save Changes',
                    height: 55,
                    width: double.infinity,
                    radius: 30,
                    color: AppColors.primaryColor,
                    colorText: Colors.white,
                    weightText: FontWeight.bold,
                    onTap: () {
                      context.read<UserProfileCubit>().updateProfile(
                            fullName: _fullNameController.text.trim(),
                            username: _usernameController.text.trim(),
                            phoneNumber: _phoneController.text.trim(),
                            bio: _bioController.text.trim(),
                            profileImage: _selectedImage,
                          );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
