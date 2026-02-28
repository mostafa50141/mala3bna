import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:mala3bna/core/constants/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;
  final List<int>? badges; // Optional badge count per item

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.badges,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 8,
        items: List.generate(items.length, (index) {
          final item = items[index];
          final badgeCount = badges != null && index < badges!.length
              ? badges![index]
              : 0;

          return BottomNavigationBarItem(
            label: item.label,
            icon: badgeCount > 0
                ? Badge(
                    badgeContent: Text(
                      badgeCount.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    badgeStyle: BadgeStyle(
                      badgeColor: Colors.red,
                      padding: const EdgeInsets.all(5),
                    ),
                    child: item.icon,
                  )
                : item.icon,
            activeIcon: item.activeIcon,
          );
        }),
      ),
    );
  }
}
