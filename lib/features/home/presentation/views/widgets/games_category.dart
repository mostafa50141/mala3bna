import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/shared/custom_text.dart';

class GamesCategory extends StatefulWidget {
  const GamesCategory({
    super.key,
    required this.selectedIndex,
    required this.category,
  });
  final int selectedIndex;
  final List category;

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
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.category.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            width: 100,
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: selectedIndex == index
                  ? AppColors.primaryColor
                  : AppColors.colorBtnAndCard,
              border: Border.all(
                color: selectedIndex == index ? Color(0xff19462a) : Colors.grey,
                width: 0.5,
              ),
            ),
            child: Center(
              child: customText(
                text: widget.category[index],
                weight: FontWeight.w500,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        );
      }),
    );
  }
}
