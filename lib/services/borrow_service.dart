import '../models/book.dart';
import '../models/borrow_record.dart';

class BorrowService {
  static const int borrowDays = 7;
  static const int maxBorrowLimit = 3;

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
    return null;
  }

  static void returnBook(Book book) {
    final record = findActive(book);
    if (record == null) return;

    record.returnDate = DateTime.now();
    book.isAvailable = true;
  }
}