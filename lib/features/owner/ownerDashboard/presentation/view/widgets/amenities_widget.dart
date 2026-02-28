import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/data/amenity_of_add_court.dart';

class AmenitiesWidget extends StatefulWidget {
  final List<Amenity>? amenities;
  final Function(List<Amenity>)? onChanged;

  const AmenitiesWidget({super.key, this.amenities, this.onChanged});

  @override
  State<AmenitiesWidget> createState() => _AmenitiesWidgetState();
}

class _AmenitiesWidgetState extends State<AmenitiesWidget> {
  late List<Amenity> _amenities;

  @override
  void initState() {
    super.initState();
    _amenities =
        widget.amenities ??
        [
          Amenity(id: 'lights', label: 'Lights'),
          Amenity(id: 'showers', label: 'Showers'),
          Amenity(id: 'cafe', label: 'Cafe'),
          Amenity(id: 'equipment', label: 'Equipment'),
          Amenity(id: 'parking', label: 'Parking'),
          Amenity(id: 'wifi', label: 'Wi-Fi'),
        ];
  }

  void _toggle(int index) {
    setState(
      () => _amenities[index].isSelected = !_amenities[index].isSelected,
    );
    widget.onChanged?.call(_amenities);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3.2,
          ),
          itemCount: _amenities.length,
          itemBuilder: (context, index) {
            return _AmenityItem(
              amenity: _amenities[index],
              onTap: () => _toggle(index),
            );
          },
        ),
      ],
    );
  }
}

class _AmenityItem extends StatelessWidget {
  final Amenity amenity;
  final VoidCallback onTap;

  const _AmenityItem({required this.amenity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.colorBtnAndCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: amenity.isSelected
                ? AppColors.primaryColor
                : Colors.transparent,
            width: .5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: amenity.isSelected
                    ? AppColors.primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: amenity.isSelected
                      ? AppColors.primaryColor
                      : Colors.grey,
                  width: 1.5,
                ),
              ),
              child: amenity.isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 10),
            // Label
            Text(
              amenity.label,
              style: TextStyle(
                color: amenity.isSelected
                    ? Colors.white
                    : const Color.fromARGB(124, 255, 255, 255),
                fontSize: 14,
                fontWeight: amenity.isSelected
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
