import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.trailainIcone,
    this.onPressedTrailingIcon,
    this.onPressedLeadingIcon,
  });
  final String title;
  final Icon leadingIcon;
  final Icon trailainIcone;
  final void Function()? onPressedLeadingIcon;
  final void Function()? onPressedTrailingIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: onPressedLeadingIcon, icon: leadingIcon),
        Text(title, style: Style.textStyle20),
        IconButton(onPressed: onPressedTrailingIcon, icon: trailainIcone),
      ],
    );
    // ListTile(
    //   leading: IconButton(onPressed: onPressedLeadingIcon, icon: leadingIcon),
    //   title: Text(title, style: Style.textStyle20),
    //   trailing: IconButton(
    //     onPressed: onPressedTrailingIcon,
    //     icon: trailainIcone,
    //   ),
    // );
  }
}
