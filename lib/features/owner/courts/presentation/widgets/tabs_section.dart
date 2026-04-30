import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Details / Bookings tab bar
class TabsSection extends StatefulWidget {
  const TabsSection({super.key});

  @override
  State<TabsSection> createState() => _TabsSectionState();
}

class _TabsSectionState extends State<TabsSection> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _tab('Details', 0),
          _tab('Bookings', 1),
        ],
      ),
    );
  }

  Widget _tab(String label, int index) {
    final bool active = _selected == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selected = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: active ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : Colors.grey,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
