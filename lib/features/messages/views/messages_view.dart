import 'package:flutter/material.dart';
import 'package:mala3bna/shared/widgets/custom_text.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(child: customText(text: 'Messages screen', size: 30)),
    );
  }
}
