import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/owner/courts/presentation/view_model/court_view_model.dart';

class HeaderSection extends StatelessWidget {
  final CourtViewModel vm;

  const HeaderSection({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          vm.image,
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(vm.name, style: Style.textStyle20Bold),
              Text(
                vm.location,
                style: Style.textStyle16.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
