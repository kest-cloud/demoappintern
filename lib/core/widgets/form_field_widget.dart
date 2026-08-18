import 'package:flutter/material.dart';

import '../app_color.dart';

class AppFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isObscure;
  final TextInputType? textInputType;
  final FormFieldValidator<String> validator;
  final GlobalKey<FormFieldState> fieldKey;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final bool onError;
  final bool filled;

  const AppFormField({
    required this.controller,
    required this.label,
    required this.validator,
    required this.fieldKey,
    this.onChanged,
    this.isObscure = false,
    this.onError = false,
    this.filled = false,
    this.onTap,
    this.textInputType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: onError
              ? AppColors.error
              : filled
              ? AppColors.primary
              : AppColors.greyBorder,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        obscureText: isObscure,
        obscuringCharacter: '*',
        cursorColor: AppColors.primary,
        onChanged: onChanged,
        onTap: onTap,
        decoration: InputDecoration(
          label: Text(label),
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
