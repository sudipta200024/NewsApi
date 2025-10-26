import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/slider_model.dart';

class SliderApiService {
  static const String baseUrl = "https://newsapi.org/v2";
  static const String apiKey = "5e378a98386d4555becabaa246fec501";

  Future<List<SliderModel>> getSlider() async {
    String url ="https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=5e378a98386d4555becabaa246fec501";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        final List<dynamic> articles = jsonData['articles'];

        return articles
            .where((e) => e['urlToImage'] != null && e['description'] != null)
            .map<SliderModel>(
              (e) => SliderModel(
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



//
// import '../models/slider_model.dart';
//
// List<SliderModel> getSlider(){
//   List<SliderModel> slider = [];
//   SliderModel sliderModel = SliderModel();
//
//   sliderModel.name = "Business";
//   sliderModel.image = "images/business.png";
//   slider.add(sliderModel);
//   sliderModel = SliderModel();
//
//   sliderModel.name = "Entertainment";
//   sliderModel.image = "images/entertainment.png";
//   slider.add(sliderModel);
//   sliderModel = SliderModel();
//
//   sliderModel.name = "General";
//   sliderModel.image = "images/general.png";
//   slider.add(sliderModel);
//   sliderModel = SliderModel();
//
//   sliderModel.name = "Health";
//   sliderModel.image = "images/health.png";
//   slider.add(sliderModel);
//   sliderModel = SliderModel();
//
//   sliderModel.name = "Science";
//   sliderModel.image = "images/science.png";
//   slider.add(sliderModel);
//   sliderModel = SliderModel();
//
//   sliderModel.name = "Sports";
//   sliderModel.image = "images/sports.png";
//   slider.add(sliderModel);
//   sliderModel = SliderModel();
//
//
//
//   return slider;
// }