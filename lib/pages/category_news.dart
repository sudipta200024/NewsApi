import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapi/models/show_category_model.dart';
import 'package:newsapi/pages/article_view_page.dart';

import '../services/show_category_data.dart';

class CategoryNews extends StatefulWidget {
  String name;

  CategoryNews({required this.name, super.key});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategoryShow();
  }

  Future<void> getCategoryShow() async {
    final data = await ShowCategoryData().getCategoryShow(
      widget.name.toLowerCase(),
    );
    setState(() {
      categories = data;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
      body:_loading?Center(child: CircularProgressIndicator()):Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: categories.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ShowCategory(
              image: categories[index].urlToImage!,
              desc: categories[index].description!,
              title: categories[index].title!,
              url: categories[index].url!,
            );
          },
        ),
      ),
    );
  }
}

class ShowCategory extends StatefulWidget {
  String image, desc, title,url;

  ShowCategory({
    required this.image,
    required this.desc,
    required this.title,
    required this.url,
    super.key,
  });

  @override
  State<ShowCategory> createState() => _ShowCategoryState();
}

class _ShowCategoryState extends State<ShowCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleViewPage(articleUrl: widget.url),
          ),
        );
      },
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: widget.image,
            width: MediaQuery.of(context).size.width,
            height: 200,
            fit: BoxFit.cover,
            placeholder:
                (context, url) =>
                    const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(height: 10),
          Text(
            widget.title,
            maxLines: 2,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(widget.desc,maxLines: 3,),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
