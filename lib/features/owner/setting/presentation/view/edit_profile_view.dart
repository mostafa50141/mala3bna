import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_state.dart';
import 'package:mala3bna/features/owner/setting/presentation/model/owner_profile_model.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_picture.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_form_section.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_save_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _genderController = TextEditingController();

  bool _isInitialized = false;
  bool _hasChanges = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _genderController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  // ─── Helpers ────────────────────────────────────────────────────────

  void _populateFields(OwnerProfileModel profile) {
    if (_isInitialized) return;
    _fullNameController.text = profile.fullName;
    _usernameController.text = profile.username;
    _phoneController.text = profile.phone;
    _birthDateController.text = profile.birthDate;
    _genderController.text = profile.gender;
    _isInitialized = true;
    _fadeController.forward();
  }

  OwnerProfileModel? _extractProfile(OwnerProfileState state) {
    if (state is OwnerProfileLoaded) return state.profile;
    if (state is OwnerProfileUpdating) return state.profile;
    if (state is OwnerProfileUpdateError) return state.profile;
    if (state is OwnerProfileUpdateSuccess) return state.profile;
    return null;
  }

  void _markDirty() {
    if (!_hasChanges) setState(() => _hasChanges = true);
  }

  void _showSnack(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                isError ? Icons.error_outline : Icons.check_circle_outline,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor:
              isError ? Colors.redAccent.shade700 : AppColors.primaryColor,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
          duration: Duration(seconds: isError ? 4 : 2),
        ),
      );
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final updated = OwnerProfileModel(
      fullName: _fullNameController.text.trim(),
      username: _usernameController.text.trim(),
      phone: _phoneController.text.trim(),
      birthDate: _birthDateController.text.trim(),
      gender: _genderController.text.trim(),
      imageUrl: 'assets/images/app_logo.png',
    );
    context.read<OwnerProfileCubit>().updateProfile(updated);
  }

  Future<bool> _confirmDiscard() async {
    if (!_hasChanges) return true;
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.colorBtnAndCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Discard changes?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'You have unsaved changes. Are you sure?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Keep Editing',
                style: TextStyle(color: AppColors.primaryColor)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Discard',
                style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // ─── State Listener ─────────────────────────────────────────────────

  void _onStateChanged(BuildContext context, OwnerProfileState state) {
    if (state is OwnerProfileUpdateSuccess) {
      _hasChanges = false;
      _showSnack('Profile updated successfully!');
      Navigator.pop(context);
    } else if (state is OwnerProfileUpdateError) {
      _showSnack(state.message, isError: true);
    }
  }

  // ─── Build ──────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _confirmDiscard();
        if (shouldPop && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: _buildAppBar(),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BlocConsumer<OwnerProfileCubit, OwnerProfileState>(
            listener: _onStateChanged,
            builder: _buildBody,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          if (_hasChanges) {
            final shouldPop = await _confirmDiscard();
            if (shouldPop && mounted) Navigator.of(context).pop();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      title: const Text(
        'Edit Profile',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context, OwnerProfileState state) {
    // Loading state
    if (state is OwnerProfileLoading || state is OwnerProfileInitial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Error with no profile
    if (state is OwnerProfileError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                state.message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () =>
                    context.read<OwnerProfileCubit>().loadProfile(),
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Extract profile from any loaded state
    final profile = _extractProfile(state);
    if (profile != null) _populateFields(profile);
    final isUpdating = state is OwnerProfileUpdating;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Avatar
                const SizedBox(height: 8),
                const EditProfilePicture(),
                const SizedBox(height: 32),

                // Form section
                EditProfileFormSection(
                  fullNameController: _fullNameController,
                  usernameController: _usernameController,
                  phoneController: _phoneController,
                  birthDateController: _birthDateController,
                  genderValue: _genderController.text,
                  onGenderChanged: (v) {
                    _markDirty();
                    setState(() => _genderController.text = v);
                  },
                  onFieldChanged: _markDirty,
                ),
                const SizedBox(height: 40),

                // Save button
                EditProfileSaveButton(
                  isLoading: isUpdating,
                  onPressed: _saveProfile,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
