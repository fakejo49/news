import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {
  final String apiKey = '7671dd4995c94c3489dd2952664ff55a';

  Future<List<Article>> fetchNews(String query) async {
  final String url = query.isEmpty
      ? 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'
      : 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

  print("DEBUG: Fetching news from: $url"); // <-- Tambahkan ini

  final response = await http.get(Uri.parse(url));
  print("DEBUG: Response status: ${response.statusCode}"); // <-- Tambahkan ini

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List articles = data['articles'];
    print("DEBUG: Jumlah artikel: ${articles.length}"); // <-- Tambahkan ini
    return articles.map((e) => Article.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load news');
  }
}


}