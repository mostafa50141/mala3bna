class PaymentModel {
  final String id;
  final String courtName;
  final String courtImage;
  final String date;
  final String time;
  final double amount;
  final String status; // 'Paid' or 'Pending'

  const PaymentModel({
    required this.id,
    required this.courtName,
    required this.courtImage,
    required this.date,
    required this.time,
    required this.amount,
    required this.status,
  });
}
