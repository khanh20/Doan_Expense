
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_base.dart';
import 'package:flutter_application_1/utils/device/format.dart';
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


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorBase.thirdColor, width: 1.5),
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
                  const Text('Chi tiêu', style: TextStyle(color: ColorBase.thirdColor)),
                  const SizedBox(height: 4),
                  Text(
                    "-${formatNumber(expense)}đ",
                    style: const TextStyle(fontSize: 18, color: ColorBase.secondaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Thu nhập', style: TextStyle(color: ColorBase.thirdColor)),
                  const SizedBox(height: 4),
                  Text(
                    "+${formatNumber(income)}đ",
                    style: const TextStyle(fontSize: 18, color: ColorBase.primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const Divider(color: Colors.white70, height: 32),
          Center(
            child: Column(
              children: [
                const Text('Tổng chi tiêu', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 4),
                Text(
                  '${formatNumber(remaining)}đ',
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
