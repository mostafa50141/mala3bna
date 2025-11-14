import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.colorBtnAndCard,
      borderRadius: BorderRadius.circular(40),
      elevation: 5,
      shadowColor: Colors.black,

      child: TextField(
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        cursorHeight: 25,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.primaryColor,
            size: 20,
          ),
          hintText: 'Search courts, coaches, academies..',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
