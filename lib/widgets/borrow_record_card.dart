import 'package:flutter/material.dart';
import '../models/borrow_record.dart';
import '../theme/app_colors.dart';
import '../utils/constants.dart';
import '../utils/date_helper.dart';

class BorrowRecordCard extends StatelessWidget {
  final BorrowRecord record;
  final VoidCallback onTap;

  const BorrowRecordCard({
    super.key,
    required this.record,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                record.book.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                record.book.author,
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: AppConstants.paddingS),
              Text('ថ្ងៃខ្ចី: ${DateHelper.format(record.borrowDate)}'),
              if (record.isReturned)
                Text('ថ្ងៃសង: ${DateHelper.format(record.returnDate!)}')
              else
                Text('ត្រូវសងមុន: ${DateHelper.format(record.dueDate)}'),
              const SizedBox(height: AppConstants.paddingS),
              _buildStatus(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatus() {
    final String text;
    final Color color;

    if (record.isReturned) {
      text = 'សងរួចរាល់';
      color = AppColors.available;
    } else {
      final days = DateHelper.daysLeft(record.dueDate);
      if (days < 0) {
        text = 'ហួសកំណត់ ${-days} ថ្ងៃ';
        color = AppColors.borrowed;
      } else if (days == 0) {
        text = 'ត្រូវសងថ្ងៃនេះ';
        color = AppColors.warning;
      } else {
        text = 'នៅសល់ $days ថ្ងៃ';
        color = days <= 2 ? AppColors.warning : AppColors.available;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}