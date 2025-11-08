import 'package:flutter/material.dart';
import 'package:newsapi_jonathan/screens/fakejo_dino.dart';
import '../widgets/task_card.dart';
import 'news_screen.dart';
import 'login_register.dart';
import 'fakejo_map.dart';
import 'profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 133, 156, 194),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 118, 151),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "FakeJo's Task",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TaskCard(
              title: "API News",
              subtitle: "Menampilkan daftar berita dari NewsAPI",
              icon: Icons.article,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsScreen()),
              ),
            ),
            TaskCard(
              title: "Login and Register",
              subtitle: "Masuk ke akun",
              icon: Icons.person,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserScreen()),
              ),
            ),
            TaskCard(
              title: "FakeJo World Map",
              subtitle: "Live World Map",
              icon: Icons.code,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FakeJoMap()),
              ),
            ),
            TaskCard(
              title: "Profile",
              subtitle: "Profil Perancang",
              icon: Icons.build,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyProfile()),
              ),
            ),
            TaskCard(
              title: "FakeJo Dino Run",
              subtitle: "Dino Minigame",
              icon: Icons.build,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DinoRunPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
