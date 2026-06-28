import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Profile picture with camera overlay.
///
/// Tapping anywhere on the avatar (or the camera button) opens a
/// bottom sheet that lets the user pick from Gallery or Camera.
/// The chosen image is displayed immediately as a local preview.
class EditProfilePicture extends StatefulWidget {
  final ValueChanged<File>? onImagePicked;
  final String? initialImageUrl;

  const EditProfilePicture({super.key, this.onImagePicked, this.initialImageUrl});

  @override
  State<EditProfilePicture> createState() => _EditProfilePictureState();
}

class _EditProfilePictureState extends State<EditProfilePicture> {
  File? _pickedImage;
  final _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context); // close bottom sheet first
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 800,
        maxHeight: 800,
      );
      if (file != null && mounted) {
        final f = File(file.path);
        setState(() => _pickedImage = f);
        if (widget.onImagePicked != null) widget.onImagePicked!(f);
      }
    } catch (_) {
      // Permission denied or other error — show snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image'.tr),
            backgroundColor: Colors.redAccent.shade700,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }

  void _showPickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.colorBtnAndCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Text(
                'Change Profile Picture'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              // Gallery
              _SheetOption(
                icon: Icons.photo_library_rounded,
                label: 'Choose from Gallery'.tr,
                onTap: () => _pickImage(ImageSource.gallery),
              ),

              const Divider(color: Colors.white10, height: 1),

              // Camera
              _SheetOption(
                icon: Icons.camera_alt_rounded,
                label: 'Take a Photo'.tr,
                onTap: () => _pickImage(ImageSource.camera),
              ),

              const Divider(color: Colors.white10, height: 1),

              // Cancel
              _SheetOption(
                icon: Icons.close_rounded,
                label: 'Cancel'.tr,
                color: Colors.redAccent,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _showPickerSheet,
        child: Stack(
          children: [
            // ── Avatar circle ────────────────────────────────────────────
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.25),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
                border: Border.all(color: AppColors.primaryColor, width: 2.5),
              ),
              child: ClipOval(
                child: _pickedImage != null
                    ? Image.file(
                        _pickedImage!,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      )
                    : (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty)
                        ? CachedNetworkImage(
                            imageUrl: widget.initialImageUrl!,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                            placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (_, __, ___) => const Icon(Icons.person, size: 60, color: Colors.white54),
                          )
                        : Image.asset(
                            'assets/images/app_logo.png',
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
              ),
            ),

            // ── Camera badge ──────────────────────────────────────────────
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withValues(alpha: 0.85),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Single row item inside the picker bottom sheet.
class _SheetOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _SheetOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? Colors.white;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: c, size: 20),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                color: c,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
