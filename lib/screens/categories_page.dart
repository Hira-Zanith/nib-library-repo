import 'package:flutter/material.dart';
import '../data/books_data.dart';
import '../data/categories_data.dart';
import '../models/category.dart';
import '../theme/app_colors.dart';
import '../utils/constants.dart';
import 'category_books_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  int _countBooks(String category) {
    return books.where((book) => book.category == category).length;
  }

  void _openCategory(BuildContext context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryBooksPage(category: category.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ប្រភេទសៀវភៅ')),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppConstants.paddingM,
          mainAxisSpacing: AppConstants.paddingM,
          childAspectRatio: 1.1,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _CategoryTile(
            category: category,
            count: _countBooks(category.name),
            onTap: () => _openCategory(context, category),
          );
        },
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final Category category;
  final int count;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.category,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category.icon, size: 40, color: AppColors.primary),
              const SizedBox(height: AppConstants.paddingS),
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$count ក្បាល',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}