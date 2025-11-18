import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class CustomeContinueWith extends StatelessWidget {
  const CustomeContinueWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Row(
            children: [
              Expanded(
                child: Divider(color: Colors.grey, thickness: 1, endIndent: 10),
              ),
              Text(
                'Or continue with',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Expanded(
                child: Divider(color: Colors.grey, thickness: 1, indent: 10),
              ),
            ],
          ),
        ),
        const Gap(40),
        Row(
          children: [
            const Spacer(flex: 3),
            IconButton(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.facebook),
              color: Color(0xFF4267B2),
            ),
            const Spacer(),

            IconButton(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.google),
              color: Color(0xFFDB4437),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ],
    );
  }
}
