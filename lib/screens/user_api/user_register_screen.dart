import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'user_login_screen.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool loading = false;
  final api = ApiService();

  void _register() async {
    setState(() => loading = true);
    bool success = await api.registerUser(_name.text, _email.text, _password.text);
    setState(() => loading = false);

    if (success && mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserLoginScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal register. Email mungkin sudah terdaftar.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Register User",
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              for (var field in [
                {'controller': _name, 'hint': 'Nama'},
                {'controller': _email, 'hint': 'Email'},
                {'controller': _password, 'hint': 'Password', 'obscure': true},
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    controller: field['controller'] as TextEditingController,
                    obscureText: field['obscure'] == true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: field['hint'] as String,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: loading ? null : _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade900,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: loading ? const CircularProgressIndicator() : const Text("Register"),
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserLoginScreen())),
                child: const Text("Sudah punya akun? Login", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
