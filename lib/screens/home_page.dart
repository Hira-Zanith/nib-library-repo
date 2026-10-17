import 'package:flutter/material.dart';
import '../data/books_data.dart';
import '../data/categories_data.dart';
import '../models/book.dart';
import '../utils/constants.dart';
import '../widgets/book_card.dart';
import '../widgets/empty_state.dart';
import 'book_detail_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchText = '';
  String _selectedCategory = 'All';

  List<Book> get _filteredBooks {
    final text = _searchText.toLowerCase();

    return books.where((book) {
      final matchSearch = book.title.toLowerCase().contains(text) ||
          book.author.toLowerCase().contains(text);
      final matchCategory =
          _selectedCategory == 'All' || book.category == _selectedCategory;
      return matchSearch && matchCategory;
    }).toList();
  }

  Future<void> _openDetail(Book book) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BookDetailPage(book: book)),
    );
    setState(() {});
  }

  

  @override
  Widget build(BuildContext context) {
    final results = _filteredBooks;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appNameKh)
      ),

      body: Column(
        children: [
          _buildSearchBox(),
          _buildCategoryChips(),
          Expanded(
            child: results.isEmpty
                ? const EmptyState(
                    icon: Icons.search_off,
                    message: 'រកមិនឃើញសៀវភៅ',
                  )
                : _buildBookList(results),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.paddingM,
        AppConstants.paddingM,
        AppConstants.paddingM,
        AppConstants.paddingS,
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchText = value;
          });
        },
        decoration: const InputDecoration(
          hintText: 'ស្វែងរកឈ្មោះសៀវភៅ ឬអ្នកនិពន្ធ...',
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
        children: [
          _chip(value: 'All', label: 'ទាំងអស់'),
          ...categories.map((c) => _chip(value: c.name, label: c.name)),
        ],
      ),
    );
  }

  Widget _chip({required String value, required String label}) {
    return Padding(
      padding: const EdgeInsets.only(right: AppConstants.paddingS),
      child: ChoiceChip(
        label: Text(label),
        selected: _selectedCategory == value,
        onSelected: (_) {
          setState(() {
            _selectedCategory = value;
          });
        },
      ),
    );
  }

  Widget _buildBookList(List<Book> results) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final book = results[index];
        return BookCard(book: book, onTap: () => _openDetail(book));
      },
    );
  }
}