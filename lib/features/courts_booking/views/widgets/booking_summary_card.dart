import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/info_row.dart';

class BookingSummaryCard extends StatelessWidget {
  const BookingSummaryCard({
    super.key,
    required this.imageUrl,
    required this.courtTitle,
    required this.location,
    required this.dateLabel,
    required this.timeLabel,
    required this.rentalLabel,
    required this.dateValue,
    required this.timeValue,
    required this.rentalValue,
    required this.extraMoney,
    required this.extraMoneyvaue,
  });
  final String imageUrl;
  final String courtTitle;
  final String location;
  final String dateLabel;
  final String timeLabel;
  final String rentalLabel;
  final String dateValue;
  final String timeValue;
  final String rentalValue;
  final String extraMoney;
  final int extraMoneyvaue;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: const Color(0xFF1F2A24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(imageUrl),
                  ),
                ),
                const Gap(25),
                Column(
                  children: [
                    Text(courtTitle, style: Style.textStyle20Bold),
                    Text(
                      location,
                      style: Style.textStyle16.copyWith(
                        color: Color(0xff91A16C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),
            const Divider(),
            const Gap(20),
            InfoRow(
              label: dateLabel,
              value: dateValue,
              valueColor: Color(0xff91A16C),
            ),
            const Gap(10),
            InfoRow(
              label: timeLabel,
              value: timeValue,
              valueColor: Color(0xff91A16C),
            ),
            const Gap(10),
            InfoRow(
              label: rentalLabel,
              value: rentalValue,
              valueColor: Color(0xff91A16C),
            ),
            const Gap(10),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  color: AppColors.primaryColor,
                ),
                Text(extraMoney),
                Spacer(),
                Text(
                  "+ $extraMoneyvaue EGP",
                  style: Style.textStyle16Bold.copyWith(
                    color: Color(0xff91A16C),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
