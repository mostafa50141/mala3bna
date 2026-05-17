import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_state.dart';
import 'package:mala3bna/features/owner/setting/presentation/model/owner_profile_model.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_picture.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_form_section.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_save_button.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_connected_accounts.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();

  String _username = '';
  bool _isInitialized = false;
  bool _hasChanges = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  // ─── Lifecycle ──────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  // ─── Helpers ────────────────────────────────────────────────────────

  void _populateFields(OwnerProfileModel profile) {
    if (_isInitialized) return;
    _fullNameController.text = profile.fullName;
    _emailController.text = profile.email;
    _phoneController.text = profile.phone;
    _bioController.text = profile.bio;
    _username = profile.username;
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
      username: _username,
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      bio: _bioController.text.trim(),
      birthDate: '',
      gender: '',
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
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none_rounded,
            color: AppColors.primaryColor,
            size: 22,
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  // ─── Body ───────────────────────────────────────────────────────────

  Widget _buildBody(BuildContext context, OwnerProfileState state) {
    // Loading
    if (state is OwnerProfileLoading || state is OwnerProfileInitial) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    }

    // Error
    if (state is OwnerProfileError) {
      return _buildError(context, state.message);
    }

    // Profile loaded
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
                const SizedBox(height: 4),
                const EditProfilePicture(),
                const SizedBox(height: 16),

                // Name + Username
                Text(
                  _fullNameController.text.isNotEmpty
                      ? _fullNameController.text
                      : 'Your Name',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '@$_username',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 28),

                // Form fields
                EditProfileFormSection(
                  fullNameController: _fullNameController,
                  emailController: _emailController,
                  phoneController: _phoneController,
                  bioController: _bioController,
                  onFieldChanged: _markDirty,
                ),
                const SizedBox(height: 32),

                // Save button
                EditProfileSaveButton(
                  isLoading: isUpdating,
                  onPressed: _saveProfile,
                ),
                const SizedBox(height: 32),

                // Divider
                Divider(
                  color: Colors.white.withValues(alpha: 0.06),
                  height: 1,
                ),
                const SizedBox(height: 24),

                // Connected Accounts
                const EditProfileConnectedAccounts(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
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
              message,
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
}
