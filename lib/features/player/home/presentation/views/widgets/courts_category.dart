import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/features/player/courts_booking/views/court_details.dart';

class CourtsCategory extends StatelessWidget {
  const CourtsCategory({super.key, required this.court, this.onTap});

  final CourtModel court;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            Get.to(
              () => BookingsView(courtModel: court),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500),
            );
          },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
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
                child: Image(
                  image: AssetImage(court.imageUrl),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: AppColors.colorBtnAndCard,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        court.name,
                        style: Style.textStyle14Bold.copyWith(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14,
                          ),
                          const Gap(4),
                          Text(
                            court.rating.toString(),
                            style: Style.textStyle12.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            '•',
                            style: Style.textStyle12.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            court.distance,
                            style: Style.textStyle12.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'EGP ${court.pricePerHour}',
                            style: Style.textStyle14Bold.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            '/hr',
                            style: Style.textStyle12.copyWith(
                              color: Colors.grey,
                            ),
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
