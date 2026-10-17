import 'package:flutter/material.dart';
import '../screens/login_page.dart';
import '../theme/app_colors.dart';
import '../utils/constants.dart';
import 'app_logo.dart';

class AppDrawer extends StatelessWidget {
  final ValueChanged<int> onSelectTab;

  const AppDrawer({super.key, required this.onSelectTab});

  void _select(BuildContext context, int index) {
    Navigator.pop(context);
    onSelectTab(index);
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const AppLogo(size: 48, inverted: true),
                const SizedBox(height: AppConstants.paddingS),
                const Text(
                  AppConstants.appName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  AppConstants.nibNameKh,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('ទំព័រដើម'),
            onTap: () => _select(context, 0),
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: const Text('ប្រភេទសៀវភៅ'),
            onTap: () => _select(context, 1),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_outline),
            title: const Text('សៀវភៅរបស់ខ្ញុំ'),
            onTap: () => _select(context, 2),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('អំពី NIB'),
            onTap: () => _select(context, 3),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('ចាកចេញ'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}