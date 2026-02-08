import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrogrow/core/theme/colors.dart';

class AlertMessage extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String message;

  const AlertMessage({
    super.key,
    required this.icon,
    required this.color,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(icon, color: AppColors.titleText, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: AppColors.titleText, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
