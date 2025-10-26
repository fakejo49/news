import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';

class DetailScreen extends StatelessWidget {
  final Article article;
  const DetailScreen({super.key, required this.article});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Tidak dapat membuka URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(article.urlToImage, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                article.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _launchUrl(article.url),
                icon: const Icon(Icons.open_in_browser),
                label: const Text("Baca Selengkapnya"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
