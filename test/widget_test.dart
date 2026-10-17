import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nib_library/app.dart';

Future<void> _passSplash(WidgetTester tester) async {
  await tester.pumpWidget(const NibLibraryApp());
  await tester.pump(const Duration(seconds: 3));
  await tester.pumpAndSettle();
}

Future<void> _login(WidgetTester tester) async {
  await _passSplash(tester);

  await tester.enterText(find.byType(TextFormField).at(0), 'student01');
  await tester.enterText(find.byType(TextFormField).at(1), '123456');
  await tester.tap(find.text('ចូលគណនី'));
  await tester.pump();
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Splash បង្ហាញឈ្មោះ App', (WidgetTester tester) async {
    await tester.pumpWidget(const NibLibraryApp());

    expect(find.text('NIB Library'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });

  testWidgets('Splash ទៅទំព័រ Login', (WidgetTester tester) async {
    await _passSplash(tester);

    expect(find.text('សូមស្វាគមន៍'), findsOneWidget);
  });

  testWidgets('Login ខុស បង្ហាញសារកំហុស', (WidgetTester tester) async {
    await _passSplash(tester);

    await tester.tap(find.text('ចូលគណនី'));
    await tester.pump();

    expect(find.text('សូមបញ្ចូលអ៊ីមែល ឬលេខសម្គាល់'), findsOneWidget);
    expect(find.text('សូមបញ្ចូលពាក្យសម្ងាត់'), findsOneWidget);
  });

  testWidgets('Login ត្រូវ ចូលទំព័រដើម', (WidgetTester tester) async {
    await _login(tester);

    expect(find.text('NIB Library'), findsOneWidget);
  });

  testWidgets('ស្វែងរកសៀវភៅតាមឈ្មោះ', (WidgetTester tester) async {
    await _login(tester);

    await tester.enterText(find.byType(TextField), 'Clean');
    await tester.pump();

    expect(find.text('Clean Code'), findsOneWidget);
    expect(find.text('Atomic Habits'), findsNothing);
  });

  testWidgets('បើកម៉ឺនុយខាងឆ្វេង ហើយចាកចេញ', (WidgetTester tester) async {
    await _login(tester);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text('ចាកចេញ'), findsOneWidget);

    await tester.tap(find.text('ចាកចេញ'));
    await tester.pumpAndSettle();

    expect(find.text('សូមស្វាគមន៍'), findsOneWidget);
  });
}