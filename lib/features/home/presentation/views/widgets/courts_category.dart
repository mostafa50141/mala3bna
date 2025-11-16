import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/shared/custom_text.dart';

class CourtsCategory extends StatelessWidget {
  const CourtsCategory({
    super.key,
    required this.courtName,
    required this.price,
    required this.rating,
    this.onTap,
  });
  final String courtName;
  final int price;
  final double rating;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        height: 180,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.colorBtnAndCard,
          border: Border.all(color: Colors.grey, width: 0.5),
        ),

        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 80,
                child: Image.asset(
                  'assets/images/Court.png',
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                left: 12,
                right: 12,
                bottom: 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          customText(text: courtName, weight: FontWeight.bold),

                          Gap(5),

                          Row(
                            children: [
                              customText(text: '⭐ '),
                              customText(text: rating.toString()),
                            ],
                          ),

                          Row(
                            children: [
                              Spacer(),
                              customText(text: 'EGP ', weight: FontWeight.bold),
                              customText(
                                text: price.toString(),
                                weight: FontWeight.bold,
                              ),
                              customText(text: '/hr', color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
