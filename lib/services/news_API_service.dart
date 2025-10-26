import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsApiService {
  static const String baseUrl = "https://newsapi.org/v2";
  static const String apiKey = "5e378a98386d4555becabaa246fec501";

  Future<List<ArticleModel>> getNews() async {
    String url ="$baseUrl/everything?q=apple&from=2025-09-08&to=2025-09-08&sortBy=popularity&apiKey=$apiKey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        final List<dynamic> articles = jsonData['articles'];

        return articles
            .where((e) => e['urlToImage'] != null && e['description'] != null)
            .map<ArticleModel>(
              (e) => ArticleModel(
                title: e['title'],
                author: e['author'],
                description: e['description'],
                url: e['url'],
                urlToImage: e['urlToImage'],
                content: e['content'],
              ),
            )
            .toList();
      }
    }
    return [];
  }
}
