import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/edit_court_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/dashed_add_photo.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';

/// Horizontal photo grid with upload, delete confirmation, and network image support.
class EditCourtPhotoGrid extends StatelessWidget {
  final List<CourtImageEntity> images;
  final bool isUploading;
  final VoidCallback onDirty;

  const EditCourtPhotoGrid({
    super.key,
    required this.images,
    required this.isUploading,
    required this.onDirty,
  });

  @override
  Widget build(BuildContext context) {
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
                      // Open gallery with multi-image selection
                      final picker = ImagePicker();
                      final picked = await picker.pickMultiImage(
                        imageQuality: 80,
                      );
                      if (picked.isEmpty || !context.mounted) return;
                      final cubit = context.read<EditCourtCubit>();
                      // Upload each selected image one by one
                      for (final file in picked) {
                        await cubit.pickAndUploadImage(file.path);
                      }
                    },
              child: isUploading
                  ? const _UploadingPlaceholder()
                  : const DashedAddPhoto(),
            );
          }
          final img = images[index];
          return _ImageTile(
            imageId: img.id,
            url: img.url,
            onDirty: onDirty,
          );
        },
      ),
    );
  }
}

// ─── Uploading Placeholder ──────────────────────────────────────────────────

class _UploadingPlaceholder extends StatelessWidget {
  const _UploadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Theme.of(context).cardColor,
        border:
            Border.all(color: AppColors.primaryColor.withValues(alpha: 0.4)),
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
}

// ─── Image Tile ─────────────────────────────────────────────────────────────

class _ImageTile extends StatelessWidget {
  final String imageId;
  final String url;
  final VoidCallback onDirty;

  const _ImageTile({
    required this.imageId,
    required this.url,
    required this.onDirty,
  });

  bool get _isNetwork =>
      url.startsWith('http://') || url.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: 130,
        height: 130,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(context),
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
                  onPressed: () => _confirmRemove(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (_isNetwork) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          color: Theme.of(context).cardColor,
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        errorWidget: (_, __, ___) => Container(
          color: Theme.of(context).cardColor,
          child:
              const Icon(Icons.broken_image, color: Colors.white38, size: 32),
        ),
      );
    }
    return Image.asset(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: Theme.of(context).cardColor,
        child: const Icon(Icons.broken_image, color: Colors.white38, size: 32),
      ),
    );
  }

  Future<void> _confirmRemove(BuildContext context) async {
    HapticFeedback.lightImpact();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Remove Photo?',
            style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color ?? Colors.black87, fontSize: 17)),
        content: const Text('This action cannot be undone.',
            style: TextStyle(color: Colors.grey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child:
                const Text('Remove', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      onDirty();
      context.read<EditCourtCubit>().removeImage(imageId);
    }
  }
}
