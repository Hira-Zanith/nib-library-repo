import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../utils/constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _open(BuildContext context, Uri uri) async {
    final messenger = ScaffoldMessenger.of(context);
    bool ok = false;

    try {
      ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      ok = false;
    }

    if (!ok) {
      messenger.showSnackBar(
        const SnackBar(content: Text('មិនអាចបើកតំណនេះបានទេ')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final phoneUri = Uri(
      scheme: 'tel',
      path: AppConstants.nibPhone.replaceAll(' ', ''),
    );
    final emailUri = Uri(scheme: 'mailto', path: AppConstants.nibEmail);
    final websiteUri = Uri.parse(AppConstants.nibWebsite);

    return Scaffold(
      appBar: AppBar(title: const Text('អំពី NIB')),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        children: [
          _buildHeader(),
          const SizedBox(height: AppConstants.paddingM),
          _buildAboutCard(),
          const SizedBox(height: AppConstants.paddingM),
          Card(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.location_on_outlined),
                  title: Text('អាសយដ្ឋាន'),
                  subtitle: Text(AppConstants.nibAddress),
                ),
                ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: const Text('ទូរស័ព្ទ'),
                  subtitle: const Text(AppConstants.nibPhone),
                  onTap: () => _open(context, phoneUri),
                ),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text('អ៊ីមែល'),
                  subtitle: const Text(AppConstants.nibEmail),
                  onTap: () => _open(context, emailUri),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('គេហទំព័រ'),
                  subtitle: const Text(AppConstants.nibWebsite),
                  onTap: () => _open(context, websiteUri),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.paddingL),
          const Center(
            child: Text(
              'NIB Library • ជំនាន់ 1.0.0',
              style: TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.local_library, size: 64, color: Colors.white),
          SizedBox(height: AppConstants.paddingS),
          Text(
            AppConstants.nibNameKh,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            AppConstants.nibNameEn,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(AppConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'អំពីបណ្ណាល័យ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppConstants.paddingS),
            Text(
              'បណ្ណាល័យ NIB ផ្តល់សៀវភៅសម្រាប់និស្សិតស្រាវជ្រាវ និងសិក្សា។ '
              'អ្នកអាចស្វែងរក ខ្ចី និងសងសៀវភៅតាមរយៈកម្មវិធីនេះ។',
              style: TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}