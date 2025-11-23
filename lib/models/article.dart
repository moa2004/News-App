import 'dart:convert';

class Article {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String author;
  final String source;
  final DateTime publishedAt;
  final String content;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.author,
    required this.source,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final sourceMap = json['source'] as Map<String, dynamic>? ?? {};
    final rawDate = json['publishedAt'] as String? ?? '';
    return Article(
      title: json['title'] as String? ?? 'Untitled',
      description: json['description'] as String? ?? '',
      url: json['url'] as String? ?? '',
      imageUrl: json['urlToImage'] as String? ?? '',
      author: json['author'] as String? ?? 'Unknown',
      source: sourceMap['name'] as String? ?? 'Unknown',
      publishedAt: DateTime.tryParse(rawDate) ?? DateTime.now(),
      content: json['content'] as String? ?? '',
    );
  }

  static List<Article> listFromResponse(String body) {
    final decoded = jsonDecode(body) as Map<String, dynamic>;
    final articles = decoded['articles'] as List<dynamic>? ?? [];
    return articles
        .map((item) => Article.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
