import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/borrow_record.dart';
import '../services/borrow_service.dart';
import '../utils/constants.dart';
import '../widgets/borrow_record_card.dart';
import '../widgets/empty_state.dart';
import 'book_detail_page.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  State<MyBooksPage> createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  Future<void> _openDetail(Book book) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BookDetailPage(book: book)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('សៀវភៅរបស់ខ្ញុំ'),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'កំពុងខ្ចី'),
              Tab(text: 'ប្រវត្តិ'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(
              BorrowService.currentBorrows,
              'អ្នកមិនទាន់មានសៀវភៅកំពុងខ្ចីទេ',
            ),
            _buildList(
              BorrowService.history,
              'មិនទាន់មានប្រវត្តិខ្ចី',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<BorrowRecord> records, String emptyMessage) {
    if (records.isEmpty) {
      return EmptyState(icon: Icons.bookmark_border, message: emptyMessage);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return BorrowRecordCard(
          record: record,
          onTap: () => _openDetail(record.book),
        );
      },
    );
  }
}