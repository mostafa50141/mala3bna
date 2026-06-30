import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/edit_court_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/edit_court_state.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/edit_court_shimmer.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/edit_court_error_view.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/edit_court_photo_grid.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/edit_court_pricing_field.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/edit_court_amenities_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/edit_court_location_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/edit_court_section_title.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/bottom_action_buttons.dart';

class EditCourtScreen extends StatefulWidget {
  final String courtId;
  const EditCourtScreen({super.key, required this.courtId});

  @override
  State<EditCourtScreen> createState() => _EditCourtScreenState();
}

class _EditCourtScreenState extends State<EditCourtScreen>
    with SingleTickerProviderStateMixin {
  late final EditCourtCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  final _offPeakController = TextEditingController();
  final _peakController = TextEditingController();
  final _discountController = TextEditingController();
  final _addressController = TextEditingController();
  final _selectedAmenities = <String>{};
  String? _selectedSportType;

  bool _initialized = false;
  bool _hasUnsavedChanges = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  // ─── Lifecycle ──────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _cubit = EditCourtCubit(repository: getIt<CourtRepository>());
    _cubit.loadCourt(widget.courtId);

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
    _offPeakController.dispose();
    _peakController.dispose();
    _discountController.dispose();
    _addressController.dispose();
    _fadeController.dispose();
    _cubit.close();
    super.dispose();
  }

  // ─── Helpers ────────────────────────────────────────────────────────

  void _markDirty() {
    if (!_hasUnsavedChanges) setState(() => _hasUnsavedChanges = true);
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

  Future<bool> _confirmDiscard() async {
    if (!_hasUnsavedChanges) return true;
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Discard changes?'.tr,
          style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
        ),
        content: Text(
          'You have unsaved changes. Are you sure?'.tr,
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Keep Editing'.tr,
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Discard'.tr,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _handleBack() async {
    if (_hasUnsavedChanges) {
      final shouldPop = await _confirmDiscard();
      if (shouldPop && mounted) Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  // ─── State Listener ─────────────────────────────────────────────────

  void _onStateChanged(BuildContext context, EditCourtState state) {
    if (state is EditCourtError) {
      _showSnack(state.message, isError: true);
    } else if (state is EditCourtSuccess) {
      _hasUnsavedChanges = false;
      _showSnack('Court updated successfully!'.tr);
    } else if (state is EditCourtFormValidation) {
      _showSnack(state.errors.values.first, isError: true);
    } else if (state is EditCourtLoaded && !_initialized) {
      _initialized = true;
      // Populate pricing controllers
      final c = state.court;
      _offPeakController.text =
          c.offPeakRate > 0 ? c.offPeakRate.toStringAsFixed(0) : '';
      _peakController.text =
          c.peakRate > 0 ? c.peakRate.toStringAsFixed(0) : c.hourlyRate.toStringAsFixed(0);
      _discountController.text =
          c.membershipDiscount > 0 ? c.membershipDiscount.toStringAsFixed(0) : '';
      if (_addressController.text != c.address) {
        _addressController.text = c.address;
      }
      _selectedSportType = c.sportType;
      _selectedAmenities.addAll(c.amenities.map((e) => e.id));
      _fadeController.forward();
    }
  }

  bool _shouldRebuild(EditCourtState prev, EditCourtState curr) =>
      curr is! EditCourtFormValidation;

  // ─── Build ──────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: PopScope(
        canPop: !_hasUnsavedChanges,
        onPopInvokedWithResult: (didPop, _) async {
          if (!didPop) await _handleBack();
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: _buildAppBar(),
          body: SafeArea(
            child: BlocConsumer<EditCourtCubit, EditCourtState>(
              listener: _onStateChanged,
              buildWhen: _shouldRebuild,
              builder: (context, state) {
                if (state is EditCourtLoading || state is EditCourtInitial) {
                  return const EditCourtShimmer();
                }

                final court = _cubit.court;
                if (court != null) return _buildForm(context, court, state);

                if (state is EditCourtError) {
                  return EditCourtErrorView(
                    message: state.message,
                    onRetry: () => _cubit.loadCourt(widget.courtId),
                  );
                }
                return EditCourtErrorView(
                  message: 'Something went wrong'.tr,
                  onRetry: () => _cubit.loadCourt(widget.courtId),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        onPressed: _handleBack,
      ),
      title: Text(
        'Edit Court'.tr,
        style: TextStyle(
          color: Theme.of(context).textTheme.titleLarge?.color,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      centerTitle: true,
    );
  }

  // ─── Form Body ──────────────────────────────────────────────────────

  Widget _buildForm(
      BuildContext context, CourtEntity court, EditCourtState state) {
    final isSaving = state is EditCourtSaving;
    final isUploading = state is EditCourtImageUploading;
    // Map CourtImageEntity -> CourtImageModel structure if needed by EditCourtPhotoGrid
    // Note: The PhotoGrid needs to accept CourtImageEntity now.

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Court title header
                  if (court.title.isNotEmpty) _courtTitleHeader(court.title),

                  // Photos
                  EditCourtSectionTitle(
                    title: 'Court Photos'.tr,
                    icon: Icons.photo_library_outlined,
                  ),
                  const SizedBox(height: 12),
                  EditCourtPhotoGrid(
                    images: court.images,
                    isUploading: isUploading,
                    onDirty: _markDirty,
                  ),
                  const SizedBox(height: 24),

                  // Sport Type
                  EditCourtSectionTitle(
                    title: 'Select Sport Type'.tr,
                    icon: Icons.sports_volleyball_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildSportTypeSelector(),
                  const SizedBox(height: 24),

                  // Pricing
                  EditCourtSectionTitle(
                    title: 'Pricing'.tr,
                    icon: Icons.attach_money_rounded,
                  ),
                  const SizedBox(height: 12),
                  EditCourtPricingField(
                    offPeakController: _offPeakController,
                    peakController: _peakController,
                    discountController: _discountController,
                    onChanged: _markDirty,
                  ),
                  const SizedBox(height: 24),

                  // Amenities
                  EditCourtSectionTitle(
                    title: 'Amenities'.tr,
                    icon: Icons.sports_soccer_outlined,
                  ),
                  const SizedBox(height: 12),
                  EditCourtAmenitiesSection(
                    amenities: court.amenities,
                    selectedIds: _selectedAmenities,
                    onToggle: (id) {
                      _markDirty();
                      setState(() {
                        _selectedAmenities.contains(id)
                            ? _selectedAmenities.remove(id)
                            : _selectedAmenities.add(id);
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  // Location
                  EditCourtSectionTitle(
                    title: 'Address'.tr,
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 12),
                  EditCourtLocationSection(
                    controller: _addressController,
                    onChanged: _markDirty,
                  ),
                ],
              ),
            ),
          ),

          // Sticky bottom action buttons
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.0),
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                ),
              ),
              child: BottomActionButtons(
                isSaving: isSaving,
                onCancel: _handleBack,
                onSave: () => _onSave(context, court),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _courtTitleHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge?.color,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportTypeSelector() {
    final types = [
      {'id': 'football', 'label': 'Football'.tr, 'icon': Icons.sports_soccer},
      {'id': 'padel', 'label': 'Padel'.tr, 'icon': Icons.sports_tennis},
      {'id': 'tennis', 'label': 'Tennis'.tr, 'icon': Icons.sports_tennis_rounded},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: types.map((type) {
        final id = type['id'] as String;
        final selected = _selectedSportType == id;
        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            _markDirty();
            setState(() => _selectedSportType = id);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primaryColor.withValues(alpha: 0.18)
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? AppColors.primaryColor
                    : Colors.grey.withValues(alpha: 0.2),
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  type['icon'] as IconData,
                  size: 20,
                  color: selected ? AppColors.primaryColor : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  type['label'] as String,
                  style: TextStyle(
                    color: selected ? Theme.of(context).textTheme.bodyMedium?.color : Colors.grey,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _onSave(BuildContext context, CourtEntity court) async {
    FocusScope.of(context).unfocus();
    HapticFeedback.mediumImpact();
    final amenityIds = _selectedAmenities.toList();
    await context.read<EditCourtCubit>().saveChanges(
          peakRate: _peakController.text,
          offPeakRate: _offPeakController.text,
          membershipDiscount: _discountController.text,
          amenityIds: amenityIds,
          address: _addressController.text,
          sportType: _selectedSportType ?? '',
        );
  }
}
