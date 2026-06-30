import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/form_widgets.dart';
import 'package:mala3bna/features/owner/setting/domain/entities/user_entity.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_state.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_app_bar.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_fields_card.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_form_field.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_gender_selector.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_picture.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_save_button.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_section_header.dart';

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

  // ─── Helpers ─────────────────────────────────────────────────────────────

  void _populateFields(UserEntity profile) {
    if (_isInitialized) return;
    _fullNameController.text = profile.name;
    _usernameController.text = profile.email;
    _phoneController.text = profile.phoneNumber ?? '';
    _birthDateController.text =
        profile.dateOfBirth.toIso8601String().split('T').first;
    _genderController.text = profile.gender == Gender.female ? 'Female' : 'Male';
    _isInitialized = true;
  }

  UserEntity? _extractProfile(OwnerProfileState state) {
    if (state is OwnerProfileLoaded) return state.profile;
    if (state is OwnerProfileUpdating) return state.profile;
    if (state is OwnerProfileUpdateError) return state.profile;
    if (state is OwnerProfileUpdateSuccess) return state.profile;
    return null;
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) return;
    final current = _extractProfile(context.read<OwnerProfileCubit>().state);
    final updatedProfile = UserEntity(
      name: _fullNameController.text.trim(),
      email: _usernameController.text.trim(),
      dateOfBirth: current?.dateOfBirth ?? DateTime(2000),
      gender: _genderController.text == 'Female' ? Gender.female : Gender.male,
      imageUrl: current?.imageUrl,
      phoneNumber: _phoneController.text.trim(),
    );
    context.read<OwnerProfileCubit>().updateProfile(updatedProfile);
  }

  void _onGenderChanged(String value) {
    setState(() => _genderController.text = value);
  }

  // ─── State Listener ───────────────────────────────────────────────────────

  void _onStateChanged(BuildContext context, OwnerProfileState state) {
    if (state is OwnerProfileUpdateSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully!'),
          backgroundColor: AppColors.primaryColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } else if (state is OwnerProfileUpdateError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnerProfileCubit, OwnerProfileState>(
      listener: _onStateChanged,
      builder: _buildContent,
    );
  }

  Widget _buildContent(BuildContext context, OwnerProfileState state) {
    final profile = _extractProfile(state);
    if (profile != null) _populateFields(profile);

    final isUpdating = state is OwnerProfileUpdating;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth > 600 ? 48.0 : 24.0;
    final cardPadding = screenWidth > 600 ? 24.0 : 20.0;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            0,
            horizontalPadding,
            bottomInset + 16,
          ),
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

                  // ── Section label ──
                  const EditProfileSectionHeader(title: 'Personal Information'),

                  // ── Form fields card ──
                  EditProfileFieldsCard(
                    padding: cardPadding,
                    child: Column(
                      children: [
                        EditProfileFormField(
                          controller: _fullNameController,
                          hint: 'Full Name',
                          icon: Icons.person_outline,
                          validator: (v) =>
                              v!.isEmpty ? 'Please enter your name' : null,
                        ),
                        const SizedBox(height: 16),
                        EditProfileFormField(
                          controller: _usernameController,
                          hint: 'Username',
                          icon: Icons.alternate_email,
                          validator: (v) =>
                              v!.isEmpty ? 'Please enter username' : null,
                        ),
                        const SizedBox(height: 16),
                        EditProfileFormField(
                          controller: _phoneController,
                          hint: 'Phone Number',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (v) =>
                              v!.isEmpty ? 'Please enter phone number' : null,
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
                              child: EditProfileGenderSelector(
                                value: _genderController.text,
                                onChanged: _onGenderChanged,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ── Save button ──
                  EditProfileSaveButton(
                    isLoading: isUpdating,
                    onPressed: _saveProfile,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
