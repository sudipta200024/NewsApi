import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapi/models/article_model.dart';
import 'package:newsapi/models/category_model.dart';
import 'package:newsapi/services/category_data.dart';
import 'package:newsapi/services/news_API_service.dart';
import 'package:newsapi/widgets/cardbuilderwidget.dart';
import '../models/slider_model.dart';
import '../services/slider_data.dart';
import '../widgets/customIndicator.dart';
import '../widgets/buildimage.dart';
import '../widgets/categoryTile.dart';
import 'article_view_page.dart';

class Home extends StatefulWidget {
  final NewsApiService apiService = NewsApiService();
  late Future<List<ArticleModel>> trendingNews;
  late Future<List<SliderModel>> sliderNews;

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<SliderModel> slider = [];
  int activeIndex = 0;

  @override

  void initState() {
    super.initState();
    categories = getCategories();
    widget.trendingNews = widget.apiService.getNews();
    widget.sliderNews = SliderApiService().getSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "News",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            Text(
              'Feed',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
              margin: const EdgeInsets.only(left: 16),
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    image: categories[index].image,
                    categoryName: categories[index].categoryName,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Breaking News!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "View All",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            FutureBuilder<List<SliderModel>>(
              future: widget.sliderNews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No slider news found"));
                } else {
                  List<SliderModel> sliders = snapshot.data!;

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleViewPage(
                                articleUrl: sliders[activeIndex].url ?? "",
                              ),
                            ),
                          );
                        },
                        child: CarouselSlider.builder(
                          itemCount: sliders.length,
                          options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() => activeIndex = index);
                            },
                          ),
                          itemBuilder: (BuildContext context, int index, int realIndex) {
                            final item = sliders[index];
                            return buildImage(context, item.urlToImage, item.title);
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomIndicator(activeIndex: activeIndex, count: sliders.length),
                    ],
                  );

                }
              },
            ),
            SizedBox(height: 16),
            CustomIndicator(activeIndex: activeIndex, count: slider.length),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trending News!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "View All",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<ArticleModel>>(
              future: widget.trendingNews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No news found"));
                } else {
                  List<ArticleModel> articles = snapshot.data!;
                  return ListView.builder(
                    physics:  NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CardBuilderWidget.cardBuilderWidget(
                          article: articles[index],
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticleViewPage(
                                  articleUrl: articles[index].url ?? "",
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),


          ],
        ),
      ),
    );
  }
}
