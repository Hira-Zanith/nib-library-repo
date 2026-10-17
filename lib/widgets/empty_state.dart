import 'package:flutter/material.dart';
import '../utils/constants.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const EmptyState({super.key, required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: Colors.black38),
          const SizedBox(height: AppConstants.paddingM),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}