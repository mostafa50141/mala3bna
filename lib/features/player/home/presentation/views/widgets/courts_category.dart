import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class CourtsCategory extends StatelessWidget {
  const CourtsCategory({
    super.key,
    required this.courtName,
    required this.price,
    required this.rating,
    required this.distance,
    this.onTap,
  });
  final String courtName;
  final int price;
  final double rating;
  final String distance;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 12),
        width: 170,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.colorBtnAndCard,
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Image.asset(
                  'assets/images/Court.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: AppColors.colorBtnAndCard,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        courtName,
                        style: Style.textStyle14Bold.copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 14),
                          Gap(4),
                          Text(
                            rating.toString(),
                            style: Style.textStyle12.copyWith(color: Colors.grey),
                          ),
                          Gap(4),
                          Text(
                            '•',
                            style: Style.textStyle12.copyWith(color: Colors.grey),
                          ),
                          Gap(4),
                          Text(
                            distance,
                            style: Style.textStyle12.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'EGP $price',
                            style: Style.textStyle14Bold.copyWith(
                              color: AppColors.primaryColor,
                            ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
