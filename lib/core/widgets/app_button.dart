
import 'package:flutter/material.dart';

import '../app_color.dart' ;

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: AppColors.btnShadow,
          foregroundColor: AppColors.lightBg,
          backgroundColor: AppColors.primary,
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        child: Text(label),
      ),
    );
  }
}

