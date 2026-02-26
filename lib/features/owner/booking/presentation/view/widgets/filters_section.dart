import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/widgets/filter_chip_widget.dart';

class FiltersSection extends StatelessWidget {
  const FiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          FilterChipWidget(label: "Date: All", icon: Icons.date_range),
          SizedBox(width: 10),
          FilterChipWidget(label: "Sport: All", icon: Icons.sports_soccer),
          SizedBox(width: 10),
          FilterChipWidget(
            label: "Status: Pending",
            isActive: true,
            icon: Icons.pending_actions,
          ),
        ],
      ),
    );
  }
}
