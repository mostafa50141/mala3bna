import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/shared/custom_text.dart';

class CoachCategory extends StatelessWidget {
  const CoachCategory({
    super.key,
    required this.imageUrl,
    required this.coachName,
    required this.rating,
    required this.sport,
    required this.price,
    this.onTap,
  });
  final String imageUrl;
  final String coachName;
  final double rating;
  final String sport;
  final int price;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 170,
        constraints: BoxConstraints(minWidth: 100, maxWidth: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45.5,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage(imageUrl),
              ),
            ),
            Gap(5),
            customText(
              text: coachName,
              size: 16,
              weight: FontWeight.bold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(text: '⭐ ', size: 12),
                customText(
                  text: rating.toString(),
                  color: Colors.grey,
                  size: 12,
                ),
                customText(text: '• ', color: Colors.grey, size: 12),
                customText(text: sport, color: Colors.grey, size: 12),
              ],
            ),
            Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(text: 'EGP ', weight: FontWeight.bold),
                customText(text: price.toString(), weight: FontWeight.bold),
                customText(text: '/hr', color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
