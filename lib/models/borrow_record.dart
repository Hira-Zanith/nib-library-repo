import 'book.dart';

class BorrowRecord {
  final Book book;
  final DateTime borrowDate;
  final DateTime dueDate;
  DateTime? returnDate;

  BorrowRecord({
    required this.book,
    required this.borrowDate,
    required this.dueDate,
    this.returnDate,
  });

  bool get isReturned => returnDate != null;
}