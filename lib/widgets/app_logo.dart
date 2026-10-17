import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool inverted;

  const AppLogo({super.key, this.size = 100, this.inverted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: inverted ? Colors.white : AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.local_library,
        size: size * 0.55,
        color: inverted ? AppColors.primary : Colors.white,
      ),
    );
  }
}