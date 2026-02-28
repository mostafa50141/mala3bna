import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    required this.radius,
  });

  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            width: radius * 2,
            height: radius * 2,
            color: Colors.grey.shade800,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (_, __, ___) => Container(
            width: radius * 2,
            height: radius * 2,
            color: Colors.grey.shade800,
            child: const Icon(Icons.person, color: Colors.white54),
          ),
        ),
      ),
    );
  }
}
