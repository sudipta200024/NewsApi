// class CategoryModel {
//   final String? author;
//   final String? title;
//   final String? description;
//   final String? url;
//   final String? urlToImage;
//   final String? content;
//
//   CategoryModel({
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//     required this.content,
//   });
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     return CategoryModel(
//       author: json['author'],
//       title: json['title'],
//       description: json['description'],
//       url: json['url'],
//       urlToImage: json['urlToImage'],
//       content: json['content'],
//     );
//   }
// }


class CategoryModel {
  String? categoryName;
  String? image;
}