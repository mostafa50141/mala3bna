import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCard extends StatelessWidget {
  const QrCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: const Color(0xFF0F1419),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking ID',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    '#EGY120724',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Date & Time',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    'July 12, 2024 - 18:00',
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Court',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    'Zamalek SC,\nFootball Pitch A',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Gap(20),
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1F24),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Placeholder for QR code
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.white,
                  child: Center(
                    child: QrImageView(data: '#EGY120724', size: 90),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Scan for Check-in',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
