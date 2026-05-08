import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
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

  OwnerProfileModel? _extractProfile(OwnerProfileState state) {
    if (state is OwnerProfileLoaded) return state.profile;
    if (state is OwnerProfileUpdating) return state.profile;
    if (state is OwnerProfileUpdateError) return state.profile;
    if (state is OwnerProfileUpdateSuccess) return state.profile;
    return null;
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final updatedProfile = OwnerProfileModel(
        fullName: _fullNameController.text.trim(),
        username: _usernameController.text.trim(),
        phone: _phoneController.text.trim(),
        birthDate: _birthDateController.text.trim(),
        gender: _genderController.text.trim(),
        imageUrl: "assets/images/app_logo.png",
      );

      context.read<OwnerProfileCubit>().updateProfile(updatedProfile);
    }
  }

  void _onGenderChanged(String value) {
    setState(() => _genderController.text = value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnerProfileCubit, OwnerProfileState>(
      listener: _onStateChanged,
      builder: _buildContent,
    );
  }

  void _onStateChanged(BuildContext context, OwnerProfileState state) {
    if (state is OwnerProfileUpdateSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Profile updated successfully!"),
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
          padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, bottomInset + 16),
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
                  const _SectionHeader(title: 'Personal Information'),
                  _FormFieldsCard(
                    padding: cardPadding,
                    child: Column(
                      children: [
                        _FormField(
                          controller: _fullNameController,
                          hint: 'Full Name',
                          icon: Icons.person_outline,
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter your name' : null,
                        ),
                        const _FieldGap(),
                        _FormField(
                          controller: _usernameController,
                          hint: 'Username',
                          icon: Icons.alternate_email,
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter username' : null,
                        ),
                        const _FieldGap(),
                        _FormField(
                          controller: _phoneController,
                          hint: 'Phone Number',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter phone number' : null,
                        ),
                        const _FieldGap(),
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
                              child: _GenderSelector(
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
                  _SaveButton(
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

// ─────────────────────────────────────────────────────────────────────────────
// Spacing constants
// ─────────────────────────────────────────────────────────────────────────────

class _FieldGap extends StatelessWidget {
  const _FieldGap();

  @override
  Widget build(BuildContext context) => const SizedBox(height: 16);
}

// ─────────────────────────────────────────────────────────────────────────────
// Section header with accent bar + title
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 14),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: Style.textStyle16Bold.copyWith(
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card container wrapping form fields
// ─────────────────────────────────────────────────────────────────────────────

class _FormFieldsCard extends StatelessWidget {
  const _FormFieldsCard({
    required this.child,
    this.padding = 20,
  });

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable form field using AddCourtTextField
// ─────────────────────────────────────────────────────────────────────────────

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return AddCourtTextField(
      controller: controller,
      hintText: hint,
      prefixIcon: icon,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Gender selector with Male/Female toggle pills
// ─────────────────────────────────────────────────────────────────────────────

class _GenderSelector extends StatelessWidget {
  const _GenderSelector({
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
      ),
      child: Row(
        children: [
          Icon(Icons.male_outlined, color: AppColors.primaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _GenderToggleButton(
                    label: 'Male',
                    icon: Icons.male,
                    isSelected: value == 'Male',
                    onTap: () => onChanged('Male'),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _GenderToggleButton(
                    label: 'Female',
                    icon: Icons.female,
                    isSelected: value == 'Female',
                    onTap: () => onChanged('Female'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Save button with loading state
// ─────────────────────────────────────────────────────────────────────────────

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primaryColor.withOpacity(0.4),
          shadowColor: AppColors.primaryColor.withOpacity(0.3),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Save Changes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Gender toggle pill button
// ─────────────────────────────────────────────────────────────────────────────

class _GenderToggleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderToggleButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 36,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor.withOpacity(0.5)
                : Colors.white.withOpacity(0.07),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 15,
              color: isSelected ? AppColors.primaryColor : Colors.white38,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primaryColor : Colors.white54,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
