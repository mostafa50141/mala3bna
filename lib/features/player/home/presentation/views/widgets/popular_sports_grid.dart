import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class PopularSportsGrid extends StatelessWidget {
  const PopularSportsGrid({super.key});

  final List<Map<String, dynamic>> sports = const [
    {'name': 'Football', 'icon': Icons.sports_soccer},
    {'name': 'Tennis', 'icon': Icons.sports_tennis},
    {'name': 'Swimming', 'icon': Icons.pool},
    {'name': 'Padel', 'icon': Icons.sports_volleyball}, 
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.8,
      ),
      itemCount: sports.length,
      itemBuilder: (context, index) {
        final sport = sports[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.colorBtnAndCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(sport['icon'], color: AppColors.primaryColor, size: 28),
              Gap(10),
              Text(
                sport['name'],
                style: Style.textStyle14Bold.copyWith(color: Colors.white),
              )
            ],
          ),
        );
      },
    );
  }
}
