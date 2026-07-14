import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String value;
  final bool isDropdown;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  const CustomDropdown({super.key, required this.label, required this.value, this.isDropdown = false, this.onTap, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: isDropdown ? onTap : null,
        child: AbsorbPointer(
          absorbing: isDropdown,
          child: TextField(
            controller: controller ?? TextEditingController(text: value),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Colors.grey.shade600),
              suffixIcon: isDropdown ? Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade500) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF2B88D8)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}