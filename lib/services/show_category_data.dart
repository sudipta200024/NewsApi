import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/show_category_model.dart';
class ShowCategoryData {


  Future<List<ShowCategoryModel>> getCategoryShow(String category) async {
    String url ="https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=5e378a98386d4555becabaa246fec501";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        final List<dynamic> articles = jsonData['articles'];

        return articles
            .where((e) => e['urlToImage'] != null && e['description'] != null)
            .map<ShowCategoryModel>(
              (e) => ShowCategoryModel(
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
