import 'package:flutter/material.dart';
import '../models/book.dart';
import '../theme/app_colors.dart';
import '../utils/constants.dart';
import 'status_badge.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookCard({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingM),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.menu_book, color: AppColors.primary),
              ),
              const SizedBox(width: AppConstants.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.category,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              StatusBadge(isAvailable: book.isAvailable),
            ],
          ),
        ),
      ),
    );
  }
}