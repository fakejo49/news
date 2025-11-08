import 'package:flutter/material.dart';
import '../models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final Article article;
  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(article.urlToImage, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              article.title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),
            ),
            const SizedBox(height: 10),
            Text(article.description),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (await canLaunchUrl(Uri.parse(article.url))) {
                  await launchUrl(Uri.parse(article.url));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 110, 165, 228)),
              child: const Text('Read Full Article'),
            ),
          ],
        ),
      ),
    );
  }
}
