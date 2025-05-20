import 'package:flutter/material.dart';

enum TransactionType { income, expense }

class ExpenseTabSwitch extends StatelessWidget {
  final TransactionType selectedType;
  final ValueChanged<TransactionType> onChanged;

  const ExpenseTabSwitch({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab(context, 'Tiền chi', TransactionType.expense),
        _buildTab(context, 'Tiền thu', TransactionType.income),
      ],
    );
  }

  Widget _buildTab(BuildContext context, String label, TransactionType type) {
    final isSelected = type == selectedType;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey[700] : Colors.grey[850],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
