import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:mala3bna/features/player/payments/models/payment_model.dart';
import 'package:mala3bna/features/player/payments/views/widgets/payment_card.dart';
import 'package:mala3bna/features/player/payments/views/widgets/payments_summary_card.dart';

class PaymentsBody extends StatelessWidget {
  const PaymentsBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Static dummy data for the purpose of layout construction
    final List<PaymentModel> mockPayments = [
      const PaymentModel(
        id: '1',
        courtName: 'Al Ahly Court 1 - Nasr City',
        courtImage:
            'https://images.unsplash.com/photo-1529900294019-12f8623eb64c?w=500&q=80',
        date: '10 May 2026',
        time: '18:00 - 19:30',
        amount: 250.0,
        status: 'Paid',
      ),
      const PaymentModel(
        id: '2',
        courtName: 'Zamalek Club Court',
        courtImage:
            'https://images.unsplash.com/photo-1574629810360-7efbb6b04322?w=500&q=80',
        date: '12 May 2026',
        time: '20:00 - 21:00',
        amount: 150.0,
        status: 'Pending',
      ),
      const PaymentModel(
        id: '3',
        courtName: 'Maadi Youth Center',
        courtImage:
            'https://images.unsplash.com/photo-1551280336-db2687c42784?w=500&q=80',
        date: '15 May 2026',
        time: '19:00 - 21:00',
        amount: 300.0,
        status: 'Paid',
      ),
    ];

    final double totalSpent = mockPayments
        .where((p) => p.status == 'Paid')
        .fold(0.0, (sum, p) => sum + p.amount);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaymentsSummaryCard(
            totalSpent: totalSpent,
            transactionCount: mockPayments.length,
          ),
          const SizedBox(height: 32),
          const SectionTitle(title: 'Payment History'),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mockPayments.length,
            itemBuilder: (context, index) {
              return PaymentCard(payment: mockPayments[index]);
            },
          ),
        ],
      ),
    );
  }
}
