import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/form_widgets.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key, required this.addressController});
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AddCourtSectionHeader(
          icon: Icons.location_on_outlined,
          title: 'Location',
        ),
        const SizedBox(height: 12),
        AddCourtTextField(
          controller: addressController,
          hintText: "Enter your court's address",
          prefixIcon: Icons.map_outlined,
          validator: (v) =>
              (v == null || v.isEmpty) ? 'Address is required' : null,
        ),
        const SizedBox(height: 14),

        // Map placeholder
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.colorBtnAndCard,
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.25),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              children: [
                // Subtle grid lines to simulate a map
                CustomPaint(
                  size: const Size(double.infinity, 150),
                  painter: _MapGridPainter(),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.15),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryColor.withOpacity(0.5),
                          ),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: AppColors.primaryColor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to pin location',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1;

    const step = 24.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
