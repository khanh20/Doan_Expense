import 'package:decimal/decimal.dart';

class Statistic {
  final Decimal dayIncome;
  final Decimal dayExpense;
  final Decimal dayRemaining;
  final Decimal monthIncome;
  final Decimal monthExpense;
  final Decimal monthRemaining;
  final Decimal yearIncome;
  final Decimal yearExpense;
  final Decimal yearRemaining;

  Statistic({
    required this.dayIncome,
    required this.dayExpense,
    required this.dayRemaining,
    required this.monthIncome,
    required this.monthExpense,
    required this.monthRemaining,
    required this.yearIncome,
    required this.yearExpense,
    required this.yearRemaining,
  });
}
