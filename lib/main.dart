import 'package:flutter/material.dart';
import 'app.dart';
import 'services/borrow_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BorrowService.load();
  runApp(const NibLibraryApp());
}