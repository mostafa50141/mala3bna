import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class RecentBookingsSection extends StatelessWidget {
  const RecentBookingsSection({super.key});

  final List<Map<String, dynamic>> recentBookings = const [
    {
      'courtName': 'Smash Padel Club',
      'date': 'Oct 24, 2023 at 08:00 PM',
      'status': 'Paid',
    },
    {
      'courtName': 'Ace Tennis Arena',
      'date': 'Nov 12, 2023 at 06:30 PM',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        itemCount: recentBookings.length,
        itemBuilder: (context, index) {
          final booking = recentBookings[index];
          final isPaid = booking['status'] == 'Paid';

          return Container(
            width: 280,
            margin: EdgeInsets.only(right: 12),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.colorBtnAndCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/Court.png',
                    width: 70,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        booking['courtName'],
                        style: Style.textStyle14Bold.copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(4),
                      Text(
                        booking['date'],
                        style: Style.textStyle12.copyWith(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(6),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isPaid ? AppColors.primaryColor : AppColors.warningColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          booking['status'],
                          style: Style.textStyle12.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
