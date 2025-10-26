import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/show_category_model.dart';
import '../services/show_category_data.dart';
import 'article_view_page.dart';
import 'category_news.dart';

class AllNews extends StatefulWidget {
  final String name;

  const AllNews({required this.name, super.key});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {

  List<ShowCategoryModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    AllCategoryShow();
  }

  Future<void> AllCategoryShow() async {
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
      body:Container(
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

class ShowCategoryForAll extends StatefulWidget {
  final String image, desc, title, url;

  const ShowCategoryForAll(
      {super.key, required this.image, required this.desc, required this.title, required this.url});

  @override
  State<ShowCategoryForAll> createState() => _ShowCategoryForAllState();
}

class _ShowCategoryForAllState extends State<ShowCategoryForAll> {
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
