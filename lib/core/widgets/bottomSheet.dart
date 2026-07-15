import 'package:flutter/material.dart';

import '../app_color.dart';

void showMessageSheet(BuildContext context, String message, {Color? color, Color? iconColor, required String icon, IconData? errorIcon}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.lightBg,
        boxShadow: [BoxShadow(color: AppColors.btnShadow, blurRadius: 8.0)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 33,
            backgroundColor: color ?? AppColors.primary,
            child: Image(
              image: AssetImage(icon),
              errorBuilder: (_, __, ___) => Icon(
                errorIcon ?? Icons.done,
                size: 40,
                color: iconColor ?? AppColors.lightPrimary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    ),
  );
}
