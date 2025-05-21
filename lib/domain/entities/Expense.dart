import 'package:decimal/decimal.dart';

class Expense{
  final int expenseId;
  final Decimal? amount;
  final String? description;
  final DateTime createdDate;
  final String type;
  final int categoryId;
  final int userId;

  Expense ({
    required this.expenseId,
    required this.categoryId,
    required this.userId,
    required this.amount,
    this.description,
    required this.createdDate,
    required this.type,
  });
}
