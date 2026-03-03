import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.trailainIcone,
  });
  final String title;
  final IconData leadingIcon;
  final IconData? trailainIcone;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(title, style: Style.textStyle20),
    );
  }
}
