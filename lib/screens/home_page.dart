import 'package:flutter/material.dart';
import 'package:newsapi_jonathan/screens/fakejo_dino.dart';
import 'package:newsapi_jonathan/screens/finance_tracker/finance_home.dart';
import 'package:newsapi_jonathan/screens/live_ngoding.dart';
import 'package:newsapi_jonathan/screens/music_player_screen.dart';
import 'package:newsapi_jonathan/screens/news_screen.dart';
import 'package:newsapi_jonathan/screens/fakejo_map.dart';
import 'package:newsapi_jonathan/screens/profile.dart';
import 'package:newsapi_jonathan/screens/user_api/user_login_screen.dart';
import '../widgets/task_card.dart';

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
              title: "FakeJo World Map",
              subtitle: "Live World Map",
              icon: Icons.map,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FakeJoMap()),
              ),
            ),
            TaskCard(
              title: "Profile",
              subtitle: "Profil Perancang Daftar Tugas",
              icon: Icons.person,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyProfile()),
              ),
            ),
            TaskCard(
              title: "FakeJo Dino Run",
              subtitle: "Dino Minigame",
              icon: Icons.videogame_asset,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DinoRunPage()),
              ),
            ),
            TaskCard(
              title: "API Login",
              subtitle: "Login dan API",
              icon: Icons.person,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserLoginScreen()),
              ),
            ),
            TaskCard(
              title: "Music Player",
              subtitle: "Online Music Player",
              icon: Icons.music_note,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MusicPlayerScreen()),
              ),
            ),
            TaskCard(
              title: "Live Ngoding",
              subtitle: "Ngoding Live",
              icon: Icons.map,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FakeMap()),
              ),
            ),
            TaskCard(
              title: "Finance Tracker",
              subtitle: "Pemantau keuangan",
              icon: Icons.money,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FinanceHome()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
