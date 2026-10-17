import 'package:flutter/material.dart';
import '../data/books_data.dart';
import '../models/book.dart';
import '../utils/constants.dart';
import '../widgets/book_card.dart';
import '../widgets/empty_state.dart';
import 'book_detail_page.dart';

class CategoryBooksPage extends StatefulWidget {
  final String category;

  const CategoryBooksPage({super.key, required this.category});

  @override
  State<CategoryBooksPage> createState() => _CategoryBooksPageState();
}

class _CategoryBooksPageState extends State<CategoryBooksPage> {
  Future<void> _openDetail(Book book) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BookDetailPage(book: book)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final list =
        books.where((book) => book.category == widget.category).toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: list.isEmpty
          ? const EmptyState(
              icon: Icons.menu_book_outlined,
              message: 'មិនទាន់មានសៀវភៅក្នុងប្រភេទនេះ',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final book = list[index];
                return BookCard(book: book, onTap: () => _openDetail(book));
              },
            ),
    );
  }
}