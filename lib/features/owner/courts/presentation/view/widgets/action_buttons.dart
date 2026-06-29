import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_state.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/edit_court_screen.dart';

class ActionButtons extends StatefulWidget {
  final String? courtId;
  const ActionButtons({super.key, this.courtId});

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleCtrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.94,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  Future<void> _animateTap() async {
    await _scaleCtrl.reverse();
    await _scaleCtrl.forward();
  }

  void _handleToggle(BuildContext context, bool isActive) {
    if (isActive) {
      _showMaintenanceDialog(context);
    } else {
      HapticFeedback.mediumImpact();
      _animateTap();
      context.read<CourtProfileCubit>().toggleStatus();
    }
  }

  void _showMaintenanceDialog(BuildContext context) {
    final cubit = context.read<CourtProfileCubit>();
    String selectedType = 'other';
    final TextEditingController descriptionCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.colorBtnAndCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    'Disable Court'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Maintenance Type'.tr,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedType,
                    dropdownColor: AppColors.colorBtnAndCard,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    items: [
                      DropdownMenuItem(value: 'lights', child: Text('Lighting Issue'.tr)),
                      DropdownMenuItem(value: 'turf', child: Text('Turf Maintenance'.tr)),
                      DropdownMenuItem(value: 'facilities', child: Text('Facilities Maintenance'.tr)),
                      DropdownMenuItem(value: 'periodic', child: Text('Periodic Maintenance'.tr)),
                      DropdownMenuItem(value: 'other', child: Text('Other'.tr)),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => selectedType = val);
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Details (Optional)'.tr,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descriptionCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'e.g. replacing LED lights...'.tr,
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        HapticFeedback.mediumImpact();
                        _animateTap();
                        cubit.toggleStatus(
                          maintenanceType: selectedType,
                          maintenanceDescription: descriptionCtrl.text.trim(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Confirm Disable'.tr,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourtProfileCubit, CourtProfileState>(
      listenWhen: (_, curr) => curr is CourtProfileToggleError,
      listener: (context, state) {
        if (state is CourtProfileToggleError) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.white, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.redAccent.shade700,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 3),
              ),
            );
        }
      },
      buildWhen: (prev, curr) {
        // Only rebuild for states that carry court data
        return curr is CourtProfileLoaded ||
            curr is CourtProfileToggling ||
            curr is CourtProfileToggleError;
      },
      builder: (context, state) {
        final court = state is CourtProfileLoaded
            ? state.courtProfile
            : state is CourtProfileToggling
                ? state.courtProfile
                : state is CourtProfileToggleError
                    ? state.courtProfile
                    : null;

        final isActive = court?.isActive ?? true;
        final isToggling = state is CourtProfileToggling;

        return Row(
          children: [
            // ── Edit Court ───────────────────────────────────────────
            Expanded(
              child: _EditButton(
                courtId: widget.courtId,
                cubit: context.read<CourtProfileCubit>(),
              ),
            ),
            const SizedBox(width: 12),

            // ── Toggle Status ────────────────────────────────────────
            Expanded(
              child: ScaleTransition(
                scale: _scaleAnim,
                child: _StatusToggleButton(
                  isActive: isActive,
                  isLoading: isToggling,
                  onTap: isToggling ? null : () => _handleToggle(context, isActive),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── Edit Button ──────────────────────────────────────────────────────────────

class _EditButton extends StatelessWidget {
  final String? courtId;
  final CourtProfileCubit cubit;

  const _EditButton({required this.courtId, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        final id = courtId;
        if (id == null || id.isEmpty) return;
        Get.to(
          () => EditCourtScreen(courtId: id),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 300),
        )?.then((_) => cubit.loadCourtProfile());
      },
      icon: const Icon(Icons.edit_outlined, size: 16),
      label: Text(
        'Edit Court'.tr,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: AppColors.primaryColor.withValues(alpha: 0.4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// ─── Status Toggle Button ─────────────────────────────────────────────────────

class _StatusToggleButton extends StatelessWidget {
  final bool isActive;
  final bool isLoading;
  final VoidCallback? onTap;

  const _StatusToggleButton({
    required this.isActive,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Colors per state
    final Color accentColor = isActive ? Colors.redAccent : AppColors.primaryColor;
    final String label = isActive ? 'Disable Court'.tr : 'Enable Court'.tr;
    final IconData icon =
        isActive ? Icons.pause_circle_outline : Icons.play_circle_outline;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isLoading
              ? Colors.white.withValues(alpha: 0.15)
              : accentColor.withValues(alpha: 0.6),
          width: 1.5,
        ),
        color: isLoading
            ? Colors.white.withValues(alpha: 0.04)
            : accentColor.withValues(alpha: 0.07),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: accentColor.withValues(alpha: 0.12),
        highlightColor: accentColor.withValues(alpha: 0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: ScaleTransition(scale: anim, child: child),
            ),
            child: isLoading
                ? SizedBox(
                    key: const ValueKey('loading'),
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: accentColor,
                    ),
                  )
                : Row(
                    key: ValueKey(isActive),
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 16, color: accentColor),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
