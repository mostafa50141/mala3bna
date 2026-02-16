import 'package:flutter/material.dart';
import 'package:mala3bna/generated/l10n.dart';

class OwnerDashboardView extends StatelessWidget {
  const OwnerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).title)),
      body: Center(child: Text("OwnerDashboardView")),
    );
  }
}
