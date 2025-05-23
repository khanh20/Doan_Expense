import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

String formatNumber(dynamic value) {
  double doubleValue;

  if (value is Decimal) {
    doubleValue = value.toDouble();
  } else if (value is int || value is double) {
    doubleValue = value.toDouble();
  } else {
    throw ArgumentError('Unsupported value type: ${value.runtimeType}');
  }

  final formattedNumber = NumberFormat.currency(
    customPattern: "#,###",
    locale: "vi-VN",
    decimalDigits: 0,
    symbol: "đ",
  ).format(doubleValue);

  return formattedNumber;
}
