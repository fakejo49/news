import 'package:flutter/material.dart';

class AccountListScreen extends StatelessWidget {
  final List<Map<String, String>> accounts;

  const AccountListScreen({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registered Accounts'),
        backgroundColor: Colors.blueAccent,
      ),
      body: accounts.isEmpty
          ? const Center(child: Text('No registered accounts yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final account = accounts[index];
                return Card(
                  color: const Color(0xFFEEF3FA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      account['name'] ?? 'No Name',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${account['email'] ?? '-'}'),
                        Text('Password: ${'*' * (account['password']?.length ?? 0)}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
