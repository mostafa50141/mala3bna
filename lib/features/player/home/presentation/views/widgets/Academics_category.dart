import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(imageUrl, fit: BoxFit.cover),
              ),
            ),
            Gap(12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameAcademy,
                    style: Style.textStyle14Bold.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4),
                  Text(
                    sport,
                    style: Style.textStyle12.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(4),
                  Text(
                    'Ages: $age_1 - $age_2 years',
                    style: Style.textStyle12.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Gap(10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                'Join Now',
                style: Style.textStyle12.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

    //           ),
    //         ),

    //         Gap(15),

    //         CustomBtn(
    //           text: 'Join Now',
    //           weightText: FontWeight.bold,
    //           height: 40,
    //           width: 100,
    //           radius: 30,
    //         ),
    //       ],
    //     ),
    //   ),
    // );

