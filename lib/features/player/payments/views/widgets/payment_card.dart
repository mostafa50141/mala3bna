import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/payments/models/payment_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PaymentCard extends StatelessWidget {
  final PaymentModel payment;

  const PaymentCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final bool isPaid = payment.status == 'Paid';
    final Color statusColor = isPaid
        ? AppColors.primaryColor
        : const Color(0XFFEAB308);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: payment.courtImage,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                width: 70,
                height: 70,
                color: Colors.white12,
                child: const Icon(Icons.sports_soccer, color: Colors.white54),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.courtName,
                  style: Style.textStyle16Bold.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${payment.date} â€¢ ${payment.time}',
                  style: Style.textStyle14.copyWith(color: Colors.white54),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${payment.amount} EGP',
                      style: Style.textStyle16Bold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: statusColor, width: 1),
                      ),
                      child: Text(
                        payment.status,
                        style: Style.textStyle12Bold.copyWith(
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
