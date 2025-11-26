import 'package:flutter/material.dart';
import 'user_profile_screen.dart';
import 'user_change_password_screen.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Dashboard")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UserProfileScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Ganti Password"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UserChangePasswordScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
