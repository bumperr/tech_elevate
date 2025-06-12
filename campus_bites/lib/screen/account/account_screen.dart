import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campus_bites/screen/component/app_bar.dart';
import 'package:campus_bites/screen/component/nav_bar.dart';

Widget _buildSectionHeader(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  );
}

Widget _buildSettingItem({
  required String title,
  required String value,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                const SizedBox(height: 4.0),
                Text(
                  value,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey),
        ],
      ),
    ),
  );
}

Widget _buildToggleSettingItem({
  required String title,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.black,
          inactiveThumbColor: Colors.grey[400],
          inactiveTrackColor: Colors.grey[200],
        ),
      ],
    ),
  );
}

final pushNotificationsProvider = StateProvider<bool>((ref) => true);
final emailNotificationsProvider = StateProvider<bool>((ref) => true);

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pushNotificationsEnabled = ref.watch(pushNotificationsProvider);
    final emailNotificationsEnabled = ref.watch(emailNotificationsProvider);

    return Scaffold(
      appBar: buildCustomAppBarAccount(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          children: [
            // Personal Section
            _buildSectionHeader('Personal'),
            const SizedBox(height: 16.0),
            _buildSettingItem(
              title: 'Name',
              value: 'Ethan Harper',
              onTap: () {
                // Handle tap for Name voidcallback
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('User Name'),
                      content: const Text("Ethan Harper"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            _buildSettingItem(
              title: 'Email',
              value: 'ethan.harper@email.com',
              onTap: () {
                // Handle tap for Email
                showDialog(
                  context: context, // Ensure 'context' is available here
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Email'), // Optional title
                      content: const Text("ethan.harper@email.com"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Closes the dialog
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            _buildSettingItem(
              title: 'School',
              value: 'University of Technology Petronas',
              onTap: () {
                // Handle tap for School
                showDialog(
                  context: context, // Ensure 'context' is available here
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Universities'), // Optional title
                      content: const Text("UTP"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Closes the dialog
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 32.0),

            // Payment Section
            _buildSectionHeader('Payment'),
            const SizedBox(height: 16.0),
            _buildSettingItem(
              title: 'Payment Method',
              value: 'Visa ... 4567',
              onTap: () {
                // Handle tap for Payment Method
              },
            ),
            const SizedBox(height: 32.0),

            // Notifications Section
            _buildSectionHeader('Notifications'),
            const SizedBox(height: 16.0),
            _buildToggleSettingItem(
              title: 'Push Notifications',
              value: pushNotificationsEnabled,
              onChanged: (bool newValue) {
                // 5. Update the provider's state using ref.read
                ref.read(pushNotificationsProvider.notifier).state = newValue;
              },
            ),
            _buildToggleSettingItem(
              title: 'Email Notifications',
              value: emailNotificationsEnabled,
              onChanged: (bool newValue) {
                // 5. Update the provider's state using ref.read
                ref.read(emailNotificationsProvider.notifier).state = newValue;
              },
            ),
            const SizedBox(height: 64.0),

            // Log Out Button
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    debugPrint('Log Out Tapped');
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.red[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
