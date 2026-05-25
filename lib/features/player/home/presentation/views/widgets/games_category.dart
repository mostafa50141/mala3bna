import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class GamesCategory extends StatefulWidget {
  const GamesCategory({
    super.key,
    required this.selectedIndex,
    required this.categories,
    this.onCategorySelected,
  });
  final int selectedIndex;
  final List<String> categories;
  final ValueChanged<int>? onCategorySelected;

  @override
  State<GamesCategory> createState() => _GamesCategoryState();
}

class _GamesCategoryState extends State<GamesCategory> {
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GamesCategory oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.categories.length, (index) {
        bool isActive = selectedIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onCategorySelected?.call(index);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: isActive
                  ? AppColors.primaryColor
                  : AppColors.colorBtnAndCard,
              border: isActive
                  ? null
                  : Border.all(color: Colors.grey, width: 0.5),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.4),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                widget.categories[index],
                style: Style.textStyle14Bold.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
