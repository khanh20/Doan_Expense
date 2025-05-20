import 'package:flutter/material.dart';

class DescriptionInput extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Ghi chú',
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
