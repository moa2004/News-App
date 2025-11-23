import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/article.dart';
import '../providers/app_settings.dart';
import '../services/news_api_service.dart';
import '../widgets/news_card.dart';
import 'article_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final NewsApiService _service = NewsApiService();
  Future<List<Article>>? _results;
  String _lastQuery = '';

  void _onSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty || trimmed == _lastQuery) return;
    setState(() {
      _lastQuery = trimmed;
      _results = _service.searchNews(
        trimmed,
        languageCode: context.read<AppSettings>().languageCode,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.6),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Search any news...',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: _onSearch,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _controller.clear();
                      setState(() {
                        _results = null;
                        _lastQuery = '';
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _results == null
                ? Center(
                    child: Text(
                      'Search anything...',
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                : FutureBuilder<List<Article>>(
                    future: _results,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Could not fetch results. ${snapshot.error}',
                              style: theme.textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                      final results = snapshot.data ?? [];
                      if (results.isEmpty) {
                        return Center(
                          child: Text(
                            'No articles found.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                        itemCount: results.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final article = results[index];
                          return NewsTile(
                            article: article,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    ArticleDetailScreen(article: article),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
