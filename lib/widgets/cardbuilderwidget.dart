import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapi/models/article_model.dart';

class CardBuilderWidget extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback? onTap;

  const CardBuilderWidget.cardBuilderWidget({super.key, required this.article, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? "",
                  height: 100,
                  width: 120,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SizedBox(
                    width: 24, // adjust size
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                      strokeWidth: 2,
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),
      
                    errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Text(
                    article.title ?? "no title",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Text(
                    article.description ?? "no description",
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
