import 'package:flutter/material.dart';
import 'package:newsapi_jonathan/services/api_service.dart';
import 'package:newsapi_jonathan/models/user_model.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    user = await ApiService().getProfile();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Profile")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : user == null
              ? const Center(child: Text("Gagal memuat data profil"))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email: ${user!.email}"),
                      Text("ID: ${user!.id}"),
                    ],
                  ),
                ),
    );
  }
}
