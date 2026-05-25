import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

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
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints(minWidth: 140, maxWidth: 160),
        decoration: BoxDecoration(
          color: AppColors.colorBtnAndCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40.5,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(imageUrl),
              ),
            ),
            const Gap(8),
            Text(
              coachName,
              style: Style.textStyle14Bold.copyWith(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 12),
                Gap(4),
                Text(
                  rating.toString(),
                  style: Style.textStyle12.copyWith(color: Colors.grey),
                ),
                Gap(4),
                Text('•', style: Style.textStyle12.copyWith(color: Colors.grey)),
                Gap(4),
                Text(
                  sport,
                  style: Style.textStyle12.copyWith(color: Colors.grey),
                ),
              ],
            ),
            const Gap(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'EGP $price',
                  style: Style.textStyle14Bold.copyWith(color: AppColors.primaryColor),
                ),
                Text(
                  '/hr',
                  style: Style.textStyle12.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
