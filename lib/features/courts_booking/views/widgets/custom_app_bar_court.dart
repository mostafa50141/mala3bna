import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';

class CustomAppBarCourt extends StatelessWidget {
  const CustomAppBarCourt({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10),
        const BackButton(),
        Spacer(),
        Text(title, style: Style.textStyle20),
        Spacer(),
      ],
    );
  }
}
