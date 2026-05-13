import 'package:flutter/material.dart';

class CustomeErorrWidget extends StatelessWidget {
  const CustomeErorrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'حدث خطأ ما',
        style: TextStyle(fontSize: 18, color: Colors.red),
      ),
    );
  }
}