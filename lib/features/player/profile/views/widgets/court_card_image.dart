import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/assets_data.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/profile/models/my_booking_court_card_model.dart';

class CourtCardImage extends StatelessWidget {
  const CourtCardImage({super.key, required this.myBookingCourtCardModel});
  final MyBookingCourtCardModel myBookingCourtCardModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(myBookingCourtCardModel.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              myBookingCourtCardModel.sportsIconType == 'padel'
                  ? AssetsData.padelIcon
                  : AssetsData.footballIcon,
              width: 24,
              height: 24,
            ),
            Spacer(),
            myBookingCourtCardModel.paidStatus
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "paid",
                      style: Style.textStyle12Bold.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0XFFEAB308),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Pending",
                      style: Style.textStyle12Bold.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
