import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/widgets/custom_text.dart';

class UserInfoInHomeScreen extends StatelessWidget {
  const UserInfoInHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(10),

        CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage('assets/images/MyPhoto.jpg'),
        ),

        Gap(15),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              text: 'Hi, Mostafa 👋🏻',
              size: 18,
              weight: FontWeight.bold,
            ),

            customText(text: 'Hi, Mostafa', size: 14, color: Colors.grey),
          ],
        ),

        Spacer(),

        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_on_sharp),
          iconSize: 25,
          color: Colors.white,
        ),
      ],
    );
  }
}
