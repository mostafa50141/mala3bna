import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mala3bna/features/courts/views/widgets/amenities_item.dart';

class AmenitiesItemBuilder extends StatelessWidget {
  const AmenitiesItemBuilder({super.key});
  Map<String, IconData> get amenities => {
    "Free Wi-Fi": Icons.wifi,
    "Parking": Icons.local_parking,
    "Restrooms": Icons.wc,
    "Locker Rooms": Icons.lock,
    "Cafeteria": Icons.local_cafe,
  };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, index) {
        final amenity = amenities.keys.toList()[index];
        final icon = amenities[amenity]!;
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: AmenitiesItem(icon: icon, label: amenity),
        );
      },
      itemCount: amenities.length,
    );
  }
}
