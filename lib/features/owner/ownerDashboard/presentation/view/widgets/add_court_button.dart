import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/add_court_view.dart';

// ignore: unused_element
class AddCourtButton extends StatelessWidget {
  const AddCourtButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          navigator?.push(
            GetPageRoute(
              page: () => const AddCourtView(),
              transition: Transition.rightToLeft,
            ),
          );
        },
        icon: const Icon(Icons.add, size: 20),
        label: const Text("Add New Court", style: Style.textStyle16Bold),
      ),
    );
  }
}
