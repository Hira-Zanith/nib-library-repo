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

  Map<String, dynamic> toJson() {
    return {
      'bookId': book.id,
      'borrowDate': borrowDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'returnDate': returnDate?.toIso8601String(),
    };
  }

  static BorrowRecord? fromJson(
    Map<String, dynamic> json,
    List<Book> allBooks,
  ) {
    final bookId = json['bookId'] as int;
    final matches = allBooks.where((b) => b.id == bookId);
    if (matches.isEmpty) return null;

    final returnText = json['returnDate'] as String?;

    return BorrowRecord(
      book: matches.first,
      borrowDate: DateTime.parse(json['borrowDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      returnDate: returnText == null ? null : DateTime.parse(returnText),
    );
  }
}