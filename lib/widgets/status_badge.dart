import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final bool isAvailable;

  const StatusBadge({super.key, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final color = isAvailable ? AppColors.available : AppColors.borrowed;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isAvailable ? 'មាន' : 'ខ្ចីហើយ',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}