import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/borrow_service.dart';
import '../theme/app_colors.dart';
import '../utils/constants.dart';
import '../utils/date_helper.dart';
import '../widgets/status_badge.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  Book get book => widget.book;

  Future<bool> _confirm(String title, String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('បោះបង់'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('បញ្ជាក់'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.borrowed : AppColors.available,
      ),
    );
  }

  Future<void> _onBorrow() async {
    final ok = await _confirm(
      'ខ្ចីសៀវភៅ',
      'ខ្ចី "${book.title}" រយៈពេល ${BorrowService.borrowDays} ថ្ងៃ?',
    );
    if (!ok || !mounted) return;

    final error = BorrowService.borrow(book);
    if (error != null) {
      _showMessage(error, isError: true);
      return;
    }
    setState(() {});
    _showMessage('ខ្ចីសៀវភៅបានជោគជ័យ');
  }

  Future<void> _onReturn() async {
    final ok = await _confirm('សងសៀវភៅ', 'សង "${book.title}" ឥឡូវនេះ?');
    if (!ok || !mounted) return;

    BorrowService.returnBook(book);
    setState(() {});
    _showMessage('សងសៀវភៅរួចរាល់');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final record = BorrowService.findActive(book);

    return Scaffold(
      appBar: AppBar(title: const Text('ព័ត៌មានសៀវភៅ')),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        children: [
          Center(
            child: Container(
              width: 140,
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.menu_book,
                size: 72,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: AppConstants.paddingL),
          Text(
            book.title,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingS),
          Align(
            alignment: Alignment.centerLeft,
            child: StatusBadge(isAvailable: book.isAvailable),
          ),
          if (record != null) ...[
            const SizedBox(height: AppConstants.paddingM),
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              decoration: BoxDecoration(
                color: AppColors.warning.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.event, color: AppColors.warning),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'អ្នកកំពុងខ្ចីសៀវភៅនេះ ត្រូវសងមុន ${DateHelper.format(record.dueDate)}',
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppConstants.paddingM),
          _InfoRow(
            icon: Icons.person_outline,
            label: 'អ្នកនិពន្ធ',
            value: book.author,
          ),
          _InfoRow(
            icon: Icons.category_outlined,
            label: 'ប្រភេទ',
            value: book.category,
          ),
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'ឆ្នាំបោះពុម្ព',
            value: '${book.year}',
          ),
          const Divider(height: 32),
          Text(
            'អំពីសៀវភៅ',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.paddingS),
          Text(
            book.description,
            style: textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingM),
          child: SizedBox(
            width: double.infinity,
            child: _buildActionButton(record != null),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(bool isBorrowedByMe) {
    if (book.isAvailable) {
      return ElevatedButton.icon(
        onPressed: _onBorrow,
        icon: const Icon(Icons.bookmark_add_outlined),
        label: const Text('ខ្ចីសៀវភៅ'),
      );
    }
    if (isBorrowedByMe) {
      return ElevatedButton.icon(
        onPressed: _onReturn,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.borrowed,
          foregroundColor: Colors.white,
        ),
        icon: const Icon(Icons.assignment_return_outlined),
        label: const Text('សងសៀវភៅ'),
      );
    }
    return const ElevatedButton(
      onPressed: null,
      child: Text('សៀវភៅនេះត្រូវបានខ្ចីហើយ'),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}