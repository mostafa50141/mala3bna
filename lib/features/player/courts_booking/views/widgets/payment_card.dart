import 'package:flutter/material.dart';

class PaymentCard extends StatefulWidget {
  const PaymentCard({super.key});

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isSelected ? Colors.black54 : Color.fromARGB(255, 40, 54, 46),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isSelected ? Colors.green : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.add_business_outlined, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Pay At Court',
              style: TextStyle(
                color: _isSelected ? Colors.green : Colors.white,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Icon(
              _isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: _isSelected ? Colors.green : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
