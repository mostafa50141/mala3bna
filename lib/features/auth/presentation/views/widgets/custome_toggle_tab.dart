import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class CustomeToggleTab extends StatefulWidget {
  const CustomeToggleTab({super.key});

  @override
  State<CustomeToggleTab> createState() => _CustomeToggleTabState();
}

class _CustomeToggleTabState extends State<CustomeToggleTab> {
  bool isSignUpSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.61,
      decoration: BoxDecoration(
        color: AppColors.fieldBackground.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isSignUpSelected = true;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: isSignUpSelected ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),

              alignment: Alignment.center,
              child: const Text('Sign Up', style: Style.textStyle16Bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSignUpSelected = false;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: isSignUpSelected ? Colors.transparent : Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),

              alignment: Alignment.center,
              child: const Text('Log In', style: Style.textStyle16Bold),
            ),
          ),
        ],
      ),
    );
  }
}
