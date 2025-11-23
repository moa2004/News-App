import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/article.dart';

class NewsApiService {
  static const _baseUrl = 'https://newsapi.org/v2';

  String get _apiKey => dotenv.env['NEWS_API_KEY'] ?? '';

  Future<List<Article>> fetchTopHeadlines({
    required String category,
    String languageCode = 'en',
  }) async {
    if (_apiKey.isEmpty) {
      throw const HttpException('Missing NEWS_API_KEY in .env');
    }

    final language = languageCode.toLowerCase().startsWith('ar') ? 'ar' : 'en';
    final uri = language == 'ar'
        // Arabic top-headlines are sparse; fallback to everything with Arabic-only results.
        ? Uri.parse(
            '$_baseUrl/everything?q=$category&language=ar&sortBy=publishedAt&pageSize=30&apiKey=$_apiKey',
          )
        : Uri.parse(
            '$_baseUrl/top-headlines?category=$category&language=$language&pageSize=30&apiKey=$_apiKey',
          );

    final response = await http.get(
      uri,
      headers: {HttpHeaders.acceptHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      return Article.listFromResponse(response.body);
    }
    throw HttpException('Failed to load news (${response.statusCode})');
  }

  Future<List<Article>> searchNews(
    String query, {
    String languageCode = 'en',
  }) async {
    if (query.trim().isEmpty) return [];
    final language = languageCode.toLowerCase().startsWith('ar') ? 'ar' : 'en';
    final uri = Uri.parse(
      '$_baseUrl/everything?q=$query&language=$language&sortBy=publishedAt&pageSize=30&apiKey=$_apiKey',
    );
    final response = await http.get(
      uri,
      headers: {HttpHeaders.acceptHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      return Article.listFromResponse(response.body);
    }
    throw HttpException('Failed to search news (${response.statusCode})');
  }
}
