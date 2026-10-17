import 'package:flutter/material.dart';
import 'screens/main_page.dart';
import 'theme/app_theme.dart';
import 'utils/constants.dart';

class NibLibraryApp extends StatelessWidget {
  const NibLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.light,
      home: const MainPage(),
    );
  }
}