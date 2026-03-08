import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/features/player/profile/models/my_booking_court_card_model.dart';
import 'package:mala3bna/features/player/profile/views/widgets/court_card_image.dart';

class CustomeCourtCard extends StatelessWidget {
  const CustomeCourtCard({super.key, required this.myBookingCourtCardModel});
  final MyBookingCourtCardModel myBookingCourtCardModel;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 4,
      child: Column(
        children: [
          Expanded(
            child: CourtCardImage(
              myBookingCourtCardModel: myBookingCourtCardModel,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    myBookingCourtCardModel.title,
                    style: Style.textStyle20Bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 14,
                    ),
                    Text(
                      myBookingCourtCardModel.date,
                      style: Style.textStyle12,
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 14,
                    ),
                    Text(
                      myBookingCourtCardModel.time,
                      style: Style.textStyle12,
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomBtn(
                        icon: Icons.directions,
                        text: "Directions",
                        colorText: Colors.black,
                        height: 40,
                        width: 120,
                        radius: 15,
                        color: AppColors.primaryColor,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: CustomBtn(
                        icon: Icons.phone,
                        text: "Contact",
                        colorText: Colors.white,
                        height: 40,
                        width: 120,
                        radius: 15,
                        color: Colors.black,
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.close, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
