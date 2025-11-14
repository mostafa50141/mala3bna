import 'package:flutter/material.dart';

// ignore: camel_case_types
class customText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;

  const customText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textScaler: TextScaler.linear(1.0),
      text,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
