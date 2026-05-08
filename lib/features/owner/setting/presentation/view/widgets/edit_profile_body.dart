import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/form_widgets.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_state.dart';
import 'package:mala3bna/features/owner/setting/presentation/model/owner_profile_model.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_app_bar.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_picture.dart';

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({super.key});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _genderController = TextEditingController();

  bool _isInitialized = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _populateFields(OwnerProfileModel profile) {
    if (!_isInitialized) {
      _fullNameController.text = profile.fullName;
      _usernameController.text = profile.username;
      _phoneController.text = profile.phone;
      _birthDateController.text = profile.birthDate;
      _genderController.text = profile.gender;
      _isInitialized = true;
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final updatedProfile = OwnerProfileModel(
        fullName: _fullNameController.text.trim(),
        username: _usernameController.text.trim(),
        phone: _phoneController.text.trim(),
        birthDate: _birthDateController.text.trim(),
        gender: _genderController.text.trim(),
        imageUrl: "assets/images/app_logo.png", // keeping old for now
      );

      context.read<OwnerProfileCubit>().updateProfile(updatedProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnerProfileCubit, OwnerProfileState>(
      listener: (context, state) {
        if (state is OwnerProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Profile updated successfully!"),
              backgroundColor: AppColors.primaryColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context); // Go back after success
        } else if (state is OwnerProfileUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        // Find current profile data to populate
        OwnerProfileModel? profile;
        if (state is OwnerProfileLoaded) {
          profile = state.profile;
        } else if (state is OwnerProfileUpdating) {
          profile = state.profile;
        } else if (state is OwnerProfileUpdateError) {
          profile = state.profile;
        } else if (state is OwnerProfileUpdateSuccess) {
          profile = state.profile;
        }

        if (profile != null) {
          _populateFields(profile);
        }

        final isUpdating = state is OwnerProfileUpdating;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    const EditProfileAppBar(),
                    const SizedBox(height: 10),
                    const EditProfilePicture(),
                    const SizedBox(height: 32),

                    // ── Form Fields ──
                    AddCourtTextField(
                      controller: _fullNameController,
                      hintText: 'Full Name',
                      prefixIcon: Icons.person_outline,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 16),

                    AddCourtTextField(
                      controller: _usernameController,
                      hintText: 'Username',
                      prefixIcon: Icons.alternate_email,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter username' : null,
                    ),
                    const SizedBox(height: 16),

                    AddCourtTextField(
                      controller: _phoneController,
                      hintText: 'Phone Number',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter phone number' : null,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: AddCourtTextField(
                            controller: _birthDateController,
                            hintText: 'Birth Date',
                            prefixIcon: Icons.calendar_today_outlined,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AddCourtTextField(
                            controller: _genderController,
                            hintText: 'Gender',
                            prefixIcon: Icons.male_outlined,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // ── Save Button ──
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isUpdating ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isUpdating
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                "Save Changes",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
