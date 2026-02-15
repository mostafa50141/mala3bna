import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/amenities_item.dart';

class AmenitiesItemBuilder extends StatelessWidget {
  const AmenitiesItemBuilder({super.key});
  Map<String, IconData> get amenities => {
    "Wi-Fi": Icons.wifi,
    "Parking": Icons.local_parking,
    "Locker": Icons.lock,
    "Cafe": Icons.local_cafe,
    "Restrooms": Icons.wc,
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
