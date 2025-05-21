
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinanceWidget extends StatelessWidget {
  final Decimal income;
  final Decimal expense;
  final Decimal remaining;

  const FinanceWidget({
    super.key,
    required this.income,
    required this.expense,
    required this.remaining,
  });

  String formatCurrency(Decimal amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(amount.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Chi tiêu', style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(
                    "-${formatCurrency(expense)}",
                    style: const TextStyle(fontSize: 18, color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Thu nhập', style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(
                    "+${formatCurrency(income)}",
                    style: const TextStyle(fontSize: 18, color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 32),
          Center(
            child: Column(
              children: [
                const Text('Chênh lệch', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 4),
                Text(
                  formatCurrency(remaining),
                  style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
