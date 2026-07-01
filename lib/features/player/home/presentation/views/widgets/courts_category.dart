import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_animateds_snack_bar.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/features/player/courts_booking/views/court_details.dart';

class CourtsCategory extends StatelessWidget {
  const CourtsCategory({super.key, required this.court, this.onTap});

  final CourtModel court;
  final void Function()? onTap;

  Widget _buildCourtImage() {
    if (court.imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: court.imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: AppColors.colorBtnAndCard,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/Court.png',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.asset(
      court.imageUrl,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: court.isActive
          ? onTap ??
                () {
                  Get.to(
                    () => BookingsView(courtModel: court),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500),
                  );
                }
          : () {
              showAnimatedSnackDialog(
                context,
                message: 'This court is closed today',
                type: AnimatedSnackBarType.warning,
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
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    court.isActive
                        ? _buildCourtImage()
                        : ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.45),
                              BlendMode.darken,
                            ),
                            child: _buildCourtImage(),
                          ),
                    if (!court.isActive)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Closed Today',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
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
