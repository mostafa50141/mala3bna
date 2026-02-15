import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/custom_text.dart';

class AcademicsCategory extends StatelessWidget {
  const AcademicsCategory({
    super.key,
    required this.imageUrl,
    required this.nameAcademy,
    required this.sport,
    required this.age_1,
    required this.age_2,
  });
  final String imageUrl;
  final String nameAcademy;
  final String sport;
  final int age_1;
  final int age_2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Image.asset(imageUrl, fit: BoxFit.cover),
              ),
            ),

            Gap(10),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: nameAcademy,
                    weight: FontWeight.bold,
                    size: 15,
                    maxLines: 2,
                    //overflow: TextOverflow.ellipsis,
                  ),

                  Gap(5),

                  customText(
                    text: sport,
                    color: Colors.grey.shade600,
                    size: 12,
                    weight: FontWeight.bold,
                  ),

                  Gap(5),

                  customText(
                    text: 'Age $age_1-$age_2',
                    color: Colors.grey.shade600,
                    size: 12,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),

            Gap(15),

            CustomBtn(
              text: 'Join Now',
              weightText: FontWeight.bold,
              height: 40,
              width: 100,
              radius: 30,
            ),
          ],
        ),
      ),
    );
  }
}
