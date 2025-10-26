import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/news_service.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService _newsService = NewsService();
  List<Article> _articles = [];
  bool _isLoading = true;
  String _query = "";

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  void _fetchNews([String query = ""]) async {
    setState(() => _isLoading = true);
    final articles = await _newsService.fetchNews(query);
    setState(() {
      _articles = articles;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Jonathan News",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🔍 Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari berita...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSubmitted: (value) {
                  _query = value;
                  _fetchNews(_query);
                },
              ),
            ),

            // 🔽 Daftar berita
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _articles.length,
                      itemBuilder: (context, index) {
                        final article = _articles[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(article: article),
                            ),
                          ),
                          child: Card(
                            margin: const EdgeInsets.all(8),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 🖼️ Gambar berita
                                article.urlToImage.isNotEmpty &&
                                        article.urlToImage.startsWith("https")
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        child: Image.network(
                                          article.urlToImage,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                            height: 200,
                                            color: Colors.grey[300],
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.broken_image,
                                                    size: 48,
                                                    color: Colors.grey),
                                                SizedBox(height: 8),
                                                Text(
                                                  "Gambar tidak tersedia",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 200,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: Icon(
                                            Icons.image_not_supported,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),

                                // 📰 Judul berita
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    article.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                                // 📄 Deskripsi berita
                                if (article.description.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    child: Text(
                                      article.description,
                                      style: const TextStyle(
                                          color: Colors.black54),
                                    ),
                                  ),

                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
