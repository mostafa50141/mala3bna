import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/edit_court_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/edit_court_state.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/amenity_chip.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/dashed_add_photo.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/bottom_action_buttons.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/shared/section_card.dart';
import 'package:mala3bna/features/owner/courts/data/datasources/court_remote_data_source.dart';
import 'package:mala3bna/features/owner/courts/data/repositories/court_repository_impl.dart';
import '../../data/models/court_model.dart';

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
  final _hourlyController = TextEditingController();
  final _selectedAmenities = <String>{};
  bool _initialized = false;
  bool _hasUnsavedChanges = false;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    final remote = CourtRemoteDataSourceImpl();
    final repo = CourtRepositoryImpl(remoteDataSource: remote);
    _cubit = EditCourtCubit(repository: repo);
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
    _hourlyController.dispose();
    _fadeController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _markDirty() {
    if (!_hasUnsavedChanges) setState(() => _hasUnsavedChanges = true);
  }

  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges) return true;
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.colorBtnAndCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Discard changes?',
            style: TextStyle(color: Colors.white)),
        content: const Text('You have unsaved changes. Are you sure?',
            style: TextStyle(color: Colors.white70)),
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

  void _showStyledSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
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
              child: Text(message,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        backgroundColor:
            isError ? Colors.redAccent.shade700 : AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: PopScope(
        canPop: !_hasUnsavedChanges,
        onPopInvokedWithResult: (didPop, _) async {
          if (didPop) return;
          final shouldPop = await _onWillPop();
          if (shouldPop && context.mounted) Navigator.of(context).pop();
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: _buildAppBar(),
          body: SafeArea(
            child: BlocConsumer<EditCourtCubit, EditCourtState>(
              listener: _stateListener,
              buildWhen: _shouldRebuild,
              builder: (context, state) {
                // Use cubit.court to keep form visible during transient states
                final court = _cubit.court;

                if (state is EditCourtLoading || state is EditCourtInitial) {
                  return _buildShimmerLoading();
                }

                if (court != null) {
                  return _buildForm(context, court, state);
                }

                if (state is EditCourtError) {
                  return _buildErrorState(state.message);
                }

                return _buildErrorState('Something went wrong');
              },
            ),
          ),
        ),
      ),
    );
  }

  bool _shouldRebuild(EditCourtState prev, EditCourtState curr) {
    // Don't rebuild for form validation — handled in listener
    if (curr is EditCourtFormValidation) return false;
    return true;
  }

  void _stateListener(BuildContext context, EditCourtState state) {
    if (state is EditCourtError) {
      _showStyledSnackBar(state.message, isError: true);
    }
    if (state is EditCourtSuccess) {
      _hasUnsavedChanges = false;
      _showStyledSnackBar('Court updated successfully!');
    }
    if (state is EditCourtFormValidation) {
      final msg = state.errors.values.first;
      _showStyledSnackBar(msg, isError: true);
    }
    if (state is EditCourtLoaded && !_initialized) {
      _initialized = true;
      final hourly = state.court.hourlyRate.toStringAsFixed(0);
      if (_hourlyController.text != hourly) {
        _hourlyController.text = hourly;
      }
      _selectedAmenities.addAll(state.court.amenities.map((e) => e.id));
      _fadeController.forward();
    }
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
          child: const Icon(Icons.arrow_back_ios_new,
              size: 18, color: Colors.white),
        ),
        onPressed: () async {
          if (_hasUnsavedChanges) {
            final shouldPop = await _onWillPop();
            if (shouldPop && mounted) Navigator.of(context).pop();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      title: const Text(
        'Edit Court',
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

  // ─── Shimmer Loading Skeleton ───────────────────────────────────────
  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(80, double.infinity, radius: 14),
          const SizedBox(height: 20),
          _shimmerBox(120, double.infinity, radius: 14),
          const SizedBox(height: 20),
          _shimmerBox(60, double.infinity, radius: 14),
          const SizedBox(height: 20),
          _shimmerBox(160, double.infinity, radius: 14),
        ],
      ),
    );
  }

  Widget _shimmerBox(double height, double width, {double radius = 12}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 0.7),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: value * 0.06),
                Colors.white.withValues(alpha: value * 0.12),
                Colors.white.withValues(alpha: value * 0.06),
              ],
            ),
          ),
        );
      },
      onEnd: () {
        // Rebuild to reverse direction for continuous shimmer effect
        if (mounted) setState(() {});
      },
    );
  }

  // ─── Error State ────────────────────────────────────────────────────
  Widget _buildErrorState(String message) {
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
              child: const Icon(Icons.error_outline,
                  color: Colors.redAccent, size: 48),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _cubit.loadCourt(widget.courtId),
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Main Form ──────────────────────────────────────────────────────
  Widget _buildForm(BuildContext context, CourtModel court, EditCourtState state) {
    final isSaving = state is EditCourtSaving;
    final isUploading = state is EditCourtImageUploading;

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
                  // ── Court Title Header ──
                  if (court.title.isNotEmpty)
                    Padding(
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
                              court.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // ── Photos Section ──
                  _buildSectionTitle('Court Photos', Icons.photo_library_outlined),
                  const SizedBox(height: 12),
                  _buildPhotoGrid(court, isUploading),
                  const SizedBox(height: 24),

                  // ── Pricing Section ──
                  _buildSectionTitle('Pricing', Icons.attach_money_rounded),
                  const SizedBox(height: 12),
                  SectionCard(
                    child: TextFormField(
                      controller: _hourlyController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (_) => _markDirty(),
                      decoration: InputDecoration(
                        hintText: 'Enter hourly rate',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(Icons.monetization_on_outlined,
                            color: AppColors.primaryColor, size: 22),
                        suffixText: 'EGP/hr',
                        suffixStyle: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.white.withValues(alpha: 0.08)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Amenities Section ──
                  _buildSectionTitle('Amenities', Icons.sports_soccer_outlined),
                  const SizedBox(height: 12),
                  SectionCard(child: _buildAmenities(court)),
                  const SizedBox(height: 24),

                  // ── Location Section ──
                  _buildSectionTitle('Location', Icons.location_on_outlined),
                  const SizedBox(height: 12),
                  SectionCard(child: _buildLocationPreview(court)),
                ],
              ),
            ),
          ),

          // ── Sticky Bottom Buttons ──
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
                    AppColors.backgroundColor.withValues(alpha: 0.0),
                    AppColors.backgroundColor,
                  ],
                ),
              ),
              child: BottomActionButtons(
                onCancel: () async {
                  if (_hasUnsavedChanges) {
                    final shouldPop = await _onWillPop();
                    if (shouldPop && context.mounted) Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                onSave: () async {
                  FocusScope.of(context).unfocus();
                  HapticFeedback.mediumImpact();
                  final amenityIds = court.amenities
                      .where((a) => _selectedAmenities.contains(a.id))
                      .map((e) => e.id)
                      .toList();
                  final lat = court.lat ?? 0.0;
                  final lng = court.lng ?? 0.0;
                  await context.read<EditCourtCubit>().saveChanges(
                        hourlyRate: _hourlyController.text,
                        amenityIds: amenityIds,
                        lat: lat,
                        lng: lng,
                      );
                },
                isSaving: isSaving,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section Title ──────────────────────────────────────────────────
  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  // ─── Photo Grid ─────────────────────────────────────────────────────
  Widget _buildPhotoGrid(CourtModel court, bool isUploading) {
    final images = court.images;
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (index == images.length) {
            return GestureDetector(
              onTap: isUploading
                  ? null
                  : () async {
                      HapticFeedback.lightImpact();
                      const samplePath = 'assets/images/sample_court_1.jpg';
                      await context
                          .read<EditCourtCubit>()
                          .pickAndUploadImage(samplePath);
                    },
              child: isUploading
                  ? _buildUploadingPlaceholder()
                  : const DashedAddPhoto(),
            );
          }

          final img = images[index];
          return _buildImageTile(img.id, img.url);
        },
      ),
    );
  }

  Widget _buildUploadingPlaceholder() {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.colorBtnAndCard,
        border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Uploading…',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageTile(String imageId, String url) {
    final isNetwork =
        url.startsWith('http://') || url.startsWith('https://');

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: 130,
        height: 130,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image
            isNetwork
                ? CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: AppColors.colorBtnAndCard,
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.colorBtnAndCard,
                      child: const Icon(Icons.broken_image,
                          color: Colors.white38, size: 32),
                    ),
                  )
                : Image.asset(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.colorBtnAndCard,
                      child: const Icon(Icons.broken_image,
                          color: Colors.white38, size: 32),
                    ),
                  ),

            // Gradient overlay for delete button
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.black45, Colors.transparent],
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(14)),
                ),
                padding: const EdgeInsets.all(4),
                child: IconButton(
                  icon: const Icon(Icons.close_rounded,
                      size: 18, color: Colors.white),
                  constraints:
                      const BoxConstraints(minWidth: 28, minHeight: 28),
                  padding: EdgeInsets.zero,
                  onPressed: () => _confirmRemoveImage(imageId),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmRemoveImage(String imageId) async {
    HapticFeedback.lightImpact();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.colorBtnAndCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Remove Photo?',
            style: TextStyle(color: Colors.white, fontSize: 17)),
        content: const Text('This action cannot be undone.',
            style: TextStyle(color: Colors.white60)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remove',
                style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      _markDirty();
      context.read<EditCourtCubit>().removeImage(imageId);
    }
  }

  // ─── Amenities ──────────────────────────────────────────────────────
  Widget _buildAmenities(CourtModel court) {
    if (court.amenities.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'No amenities available',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
        ),
      );
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: court.amenities.map((amenity) {
        final selected = _selectedAmenities.contains(amenity.id);
        return AmenityChip(
          amenity: amenity,
          selected: selected,
          onTap: () {
            HapticFeedback.selectionClick();
            _markDirty();
            setState(() {
              if (selected) {
                _selectedAmenities.remove(amenity.id);
              } else {
                _selectedAmenities.add(amenity.id);
              }
            });
          },
        );
      }).toList(),
    );
  }

  // ─── Location Preview ───────────────────────────────────────────────
  Widget _buildLocationPreview(CourtModel court) {
    final hasLocation = court.lat != null && court.lng != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  hasLocation ? Icons.place : Icons.map_outlined,
                  color: hasLocation
                      ? AppColors.primaryColor
                      : Colors.white.withValues(alpha: 0.3),
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  hasLocation ? 'Location Set' : 'No location set',
                  style: TextStyle(
                    color: hasLocation
                        ? Colors.white70
                        : Colors.white.withValues(alpha: 0.3),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.my_location_rounded,
                size: 16, color: AppColors.primaryColor),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                hasLocation
                    ? '${court.lat!.toStringAsFixed(4)}, ${court.lng!.toStringAsFixed(4)}'
                    : 'Not specified',
                style: const TextStyle(color: Colors.white60, fontSize: 13),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                _showStyledSnackBar(
                    'Location picker coming soon', isError: false);
              },
              icon: Icon(Icons.edit_location_alt_outlined,
                  size: 16, color: AppColors.primaryColor),
              label: Text(
                'Change',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                      color: AppColors.primaryColor.withValues(alpha: 0.3)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
