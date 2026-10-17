import 'package:flutter_test/flutter_test.dart';
import 'package:nib_library/data/books_data.dart';
import 'package:nib_library/services/borrow_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('ខ្ចី និងសងសៀវភៅ', () {
    final book = books[0];

    expect(BorrowService.borrow(book), isNull);
    expect(book.isAvailable, isFalse);
    expect(BorrowService.currentBorrows.length, 1);

    BorrowService.returnBook(book);
    expect(book.isAvailable, isTrue);
    expect(BorrowService.currentBorrows, isEmpty);
    expect(BorrowService.history.length, 1);
  });

  test('ខ្ចីសៀវភៅដែលខ្ចីរួចមិនបាន', () {
    final book = books[0];

    expect(BorrowService.borrow(book), isNull);
    expect(BorrowService.borrow(book), isNotNull);

    BorrowService.returnBook(book);
  });

  test('ខ្ចីលើសចំនួនកំណត់ត្រូវមានសារកំហុស', () {
    for (var i = 0; i < BorrowService.maxBorrowLimit; i++) {
      expect(BorrowService.borrow(books[i]), isNull);
    }

    final extraBook = books[BorrowService.maxBorrowLimit];
    expect(BorrowService.borrow(extraBook), isNotNull);
    expect(extraBook.isAvailable, isTrue);

    for (var i = 0; i < BorrowService.maxBorrowLimit; i++) {
      BorrowService.returnBook(books[i]);
    }
  });
}