import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {
  final String apiKey = '7671dd4995c94c3489dd2952664ff55a';

  Future<List<Article>> fetchNews(String query) async {
    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=$query&language=en&apiKey=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'];
      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
