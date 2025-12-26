
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/slider_model.dart';
import 'article_view_page.dart';

class AllBreakingNewsPage extends StatelessWidget {
  final List<SliderModel> breakingNews;

  const AllBreakingNewsPage({super.key, required this.breakingNews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Breaking News"),
        centerTitle: true,
        elevation: 0,
      ),
      body: breakingNews.isEmpty
          ? const Center(child: Text("No breaking news available"))
          : Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: breakingNews.length,
          itemBuilder: (context, index) {
            final item = breakingNews[index];
            return ShowBreakingNews(
              image: item.urlToImage ?? "",
              desc: item.description ?? "No description available",
              title: item.title ?? "No title",
              url: item.url ?? "",
            );
          },
        ),
      ),
    );
  }
}

// Reusable widget — almost identical to your ShowCategoryForAll
class ShowBreakingNews extends StatelessWidget {
  final String image, desc, title, url;

  const ShowBreakingNews({
    super.key,
    required this.image,
    required this.desc,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (url.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleViewPage(articleUrl: url),
            ),
          );
        }
      },
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: image,
            width: MediaQuery.of(context).size.width,
            height: 200,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Container(
              height: 200,
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image, size: 50),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 2,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            maxLines: 3,
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 20), // Space between items
        ],
      ),
    );
  }
}