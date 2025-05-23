import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/device/format.dart';

class IncomeExpenseWidget extends StatelessWidget {
  final String label;
  final int amount;
  final Color color;

  const IncomeExpenseWidget({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        SizedBox(height: 4),
        Text(
          '${formatNumber(amount)} đ',
          style: TextStyle(
            fontSize: 18,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}