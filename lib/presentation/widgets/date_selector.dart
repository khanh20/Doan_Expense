import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  String getFormattedDate(DateTime date) {
    final weekdayNames = [
      'Chủ nhật',
      'Th 2',
      'Th 3',
      'Th 4',
      'Th 5',
      'Th 6',
      'Th 7',
    ];
    final day = DateFormat('dd/MM/yyyy').format(date);
    final weekday = weekdayNames[date.weekday % 7];
    return '$day ($weekday)';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Ngày',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                locale: const Locale('vi', 'VN'),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.dark(), // Giao diện nền tối
                    child: child!,
                  );
                },
              );
              if (pickedDate != null) {
                onDateSelected(pickedDate);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade700),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[850], // Nền tối
              ),
              child: Text(
                getFormattedDate(selectedDate),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
