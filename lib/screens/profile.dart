import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Biodata Pembuat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade700,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto profil atau avatar
            CircleAvatar(
              radius: 100,
              backgroundImage: const AssetImage('assets/me.jpg'),
            ),
            const SizedBox(height: 20),

            // Nama
            const Text(
              "Jonathan Abel Hamijaya",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              "Siswa SMK Informatika Kota Serang",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const Divider(height: 40, thickness: 1.2),

            // Detail biodata
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Nama Lengkap"),
                      subtitle: Text("Jonathan Abel Hamijaya"),
                    ),
                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text("Sekolah"),
                      subtitle: Text("SMK Informatika Kota Serang"),
                    ),
                    ListTile(
                      leading: Icon(Icons.cake),
                      title: Text("Tanggal Lahir"),
                      subtitle: Text("11 Juli 2008"),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text("Email"),
                      subtitle: Text("abeljonathan166@gmail.com"),
                    ),
                    ListTile(
                      leading: Icon(Icons.code),
                      title: Text("Keahlian"),
                      subtitle: Text("Flutter, Dart, UI/UX, Web Design, Game Design, dan Animating"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              "“Menjadi lebih baik setiap hari adalah tujuan utamaku.”",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
