import 'package:flutter/material.dart';
import 'package:newsapi_jonathan/services/api_service.dart';

class UserChangePasswordScreen extends StatefulWidget {
  const UserChangePasswordScreen({super.key});

  @override
  State<UserChangePasswordScreen> createState() =>
      _UserChangePasswordScreenState();
}

class _UserChangePasswordScreenState extends State<UserChangePasswordScreen> {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  bool loading = false;

  Future<void> updatePassword() async {
    setState(() => loading = true);
    final success =
        await ApiService().updatePassword(oldPassword.text, newPassword.text);
    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text(success ? "Password berhasil diubah" : "Gagal mengubah password"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ganti Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: oldPassword,
              decoration: const InputDecoration(labelText: "Password Lama"),
              obscureText: true,
            ),
            TextField(
              controller: newPassword,
              decoration: const InputDecoration(labelText: "Password Baru"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: updatePassword,
                    child: const Text("Ubah Password"),
                  ),
          ],
        ),
      ),
    );
  }
}
