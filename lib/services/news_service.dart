import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String _apiKey = 'c809a7eef9f7424da77b1563bd1586c6'; // Replace with your API key from NewsAPI
  final String _baseUrl = 'https://newsapi.org/v2';

  Future<List<String>> fetchHeadlines() async {
    final response = await http.get(Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List articles = data['articles'];
      return articles.map<String>((article) => article['title'] as String).toList();
    } else {
      throw Exception('Failed to load headlines');
    }
  }
}
