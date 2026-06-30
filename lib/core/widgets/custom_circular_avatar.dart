import 'package:flutter/material.dart';

class CustomeCirculerAvtar extends StatelessWidget {
  const CustomeCirculerAvtar({super.key, this.backgroundImage});
  final ImageProvider<Object>? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: Color(0xFF39E079),
        radius: 45,
        backgroundImage: backgroundImage,
      ),
    );
  }
}
