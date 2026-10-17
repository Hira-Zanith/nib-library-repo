import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/books_data.dart';
import '../models/book.dart';
import '../models/borrow_record.dart';

class BorrowService {
  static const int borrowDays = 7;
  static const int maxBorrowLimit = 3;
  static const String _storageKey = 'borrow_records';

  static final List<BorrowRecord> _records = [];

  static List<BorrowRecord> get currentBorrows =>
      _records.where((r) => !r.isReturned).toList();

  static List<BorrowRecord> get history =>
      _records.where((r) => r.isReturned).toList().reversed.toList();

  static BorrowRecord? findActive(Book book) {
    for (final record in _records) {
      if (record.book.id == book.id && !record.isReturned) {
        return record;
      }
    }
    return null;
  }

  /// ត្រឡប់សារកំហុស ឬ null បើខ្ចីបានជោគជ័យ
  static String? borrow(Book book) {
    if (!book.isAvailable) {
      return 'សៀវភៅនេះត្រូវបានខ្ចីហើយ';
    }
    if (currentBorrows.length >= maxBorrowLimit) {
      return 'អ្នកអាចខ្ចីបានអតិបរមា $maxBorrowLimit ក្បាល';
    }

    final now = DateTime.now();
    _records.add(
      BorrowRecord(
        book: book,
        borrowDate: now,
        dueDate: now.add(const Duration(days: borrowDays)),
      ),
    );
    book.isAvailable = false;
    _save();
    return null;
  }

  static void returnBook(Book book) {
    final record = findActive(book);
    if (record == null) return;

    record.returnDate = DateTime.now();
    book.isAvailable = true;
    _save();
  }

  /// ហៅម្តងពេលបើក App ដើម្បីទាញទិន្នន័យដែលបានរក្សាទុក
  static Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final text = prefs.getString(_storageKey);
      if (text == null) return;

      final list = jsonDecode(text) as List<dynamic>;
      _records.clear();

      for (final item in list) {
        final record = BorrowRecord.fromJson(
          item as Map<String, dynamic>,
          books,
        );
        if (record == null) continue;

        _records.add(record);
        if (!record.isReturned) {
          record.book.isAvailable = false;
        }
      }
    } catch (_) {
      // ទិន្នន័យខូច ឬអានមិនបាន ➜ ចាប់ផ្តើមទទេ មិនឱ្យ App គាំង
    }
  }

  static Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final text = jsonEncode(_records.map((r) => r.toJson()).toList());
      await prefs.setString(_storageKey, text);
    } catch (_) {
      // រក្សាមិនបាន ➜ App នៅតែដំណើរការក្នុងមេម៉ូរី
    }
  }
}