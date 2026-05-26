import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/courts_category.dart';

class ListViewOfCourtsCategory extends StatelessWidget {
  final List<CourtModel> courts;

  const ListViewOfCourtsCategory({
    super.key,
    required this.courts,
  });

  @override
  Widget build(BuildContext context) {
    if (courts.isEmpty) {
      return SizedBox(
        height: 220,
        child: Center(
          child: Text(
            "No courts found",
            style: Style.textStyle16.copyWith(color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        itemCount: courts.length,
        itemBuilder: (context, index) {
          final court = courts[index];
          return CourtsCategory(
            court: court,
          );
        },
      ),
    );
  }
}
