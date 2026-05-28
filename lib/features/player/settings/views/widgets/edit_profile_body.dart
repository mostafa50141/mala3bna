import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_animateds_snack_bar.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/custome_circular_laoding.dart';
import 'package:mala3bna/core/widgets/custome_text_field.dart';

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({super.key});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  bool _isLoading = true;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController(text: '22 Apr 2004');

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final storage = getIt.get<LocalStorageHelper>();
    final name = await storage.getUserName();
    final email = await storage.getUserEmail();
    final phone = await storage.getUserPhone();
    setState(() {
      _fullNameController.text = name;
      _emailController.text = email;
      _phoneController.text = phone;
      _isLoading = false;
    });
  }

  // this function to pick image from gallery and set it to _selectedImage
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CustomeCircularLaoding());
    }

    final border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(24),
    );

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade800,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : null,
                        child: _selectedImage == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              )
                            : null,
                      ),
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
                  const SizedBox(height: 16),
                  Text(
                    'Mostafa Ahmed',
                    style: Style.textStyle20Bold.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'mostafa@gmail.com',
                    style: Style.textStyle14.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _buildLabel('Full Name'),
            CustomTextfield(
              controller: _fullNameController,
              hintText: 'Enter your full name',
              fillcolor: AppColors.colorBtnAndCard,
              border: border,
              prefixIcon: const Icon(Icons.person, color: Colors.white70),
            ),

            _buildLabel('Email'),
            CustomTextfield(
              controller: _emailController,
              hintText: 'Enter your email',
              fillcolor: AppColors.colorBtnAndCard,
              border: border,
              prefixIcon: const Icon(Icons.email, color: Colors.white70),
            ),

            _buildLabel('Phone Number'),
            CustomTextfield(
              controller: _phoneController,
              hintText: 'Enter your phone number',
              keyboardType: TextInputType.phone,
              fillcolor: AppColors.colorBtnAndCard,
              border: border,
              prefixIcon: const Icon(Icons.phone, color: Colors.white70),
            ),

            _buildLabel('Date of Birth'),
            CustomTextfield(
              controller: _birthDateController,
              hintText: 'Enter your date of birth',
              fillcolor: AppColors.colorBtnAndCard,
              border: border,
              prefixIcon: const Icon(
                Icons.calendar_today,
                color: Colors.white70,
              ),
              suffixIcon: const Icon(
                Icons.calendar_today,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 40),

            CustomBtn(
              text: "Save Changes",
              height: 55,
              width: double.infinity,
              radius: 30,
              color: AppColors.primaryColor,
              colorText: Colors.white,
              weightText: FontWeight.bold,
              onTap: () async {
                final storage = getIt.get<LocalStorageHelper>();
                await storage.saveUserData(
                  name: _fullNameController.text.trim(),
                  email: _emailController.text.trim(),
                  phone: _phoneController.text.trim(),
                  userType: await storage.getUserType(),
                );
                showAnimatedSnackDialog(
                  context,
                  message: "Profile updated successfully",
                  type: AnimatedSnackBarType.success,
                );
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
