import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Tab bar that exposes [onTabChanged] so the parent can switch content.
class TabsSection extends StatefulWidget {
  final ValueChanged<int>? onTabChanged;

  const TabsSection({super.key, this.onTabChanged});

  @override
  State<TabsSection> createState() => _TabsSectionState();
}

class _TabsSectionState extends State<TabsSection> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildTab('Details'.tr, 0),
          _buildTab('Bookings'.tr, 1),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final bool active = _selected == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selected = index);
          widget.onTabChanged?.call(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: active ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: AppColors.primaryColor.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: GoogleFonts.cairo(
              color: active ? Colors.white : Colors.grey,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
