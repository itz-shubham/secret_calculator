import 'package:flutter/material.dart';
import 'package:secret_calculator/pages/password_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Change Password"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PasswordPage(
                  isPasswordChanging: true,
                ),
              ),
            ),
          ),
          // ListTile(
          //   title: const Text(""),
          //   onTap: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const CreatePasswordPage(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
