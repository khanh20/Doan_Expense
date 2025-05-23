import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_application_1/constants/color_base.dart';

class ChartWidget extends StatelessWidget {
  final Decimal income;
  final Decimal expense;

  const ChartWidget({Key? key, required this.income, required this.expense})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = (income + expense);
    final incomeDouble = income.toDouble();
    final expenseDouble = expense.toDouble();

    final incomePercent =
        total == Decimal.zero ? 0.0 : incomeDouble / total.toDouble() * 100;
    final expensePercent =
        total == Decimal.zero ? 0.0 : expenseDouble / total.toDouble() * 100;

    return Expanded(child: PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            color: ColorBase.primaryColor,
            value: incomePercent,
            title: '${incomePercent.toStringAsFixed(1)}%',
            radius: 60,
            titleStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          PieChartSectionData(
            color: ColorBase.secondaryColor,
            value: expensePercent,
            title: '${expensePercent.toStringAsFixed(1)}%',
            radius: 60,
            titleStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),);
  }
}
