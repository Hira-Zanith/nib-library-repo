import 'package:flutter_test/flutter_test.dart';
import 'package:nib_library/app.dart';

void main() {
  testWidgets('បង្ហាញចំណងជើងបណ្ណាល័យ', (WidgetTester tester) async {
    await tester.pumpWidget(const NibLibraryApp());

    expect(find.text('បណ្ណាល័យ NIB'), findsOneWidget);
  });
}