import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/article.dart';
import '../models/category.dart';
import '../providers/app_settings.dart';
import '../services/news_api_service.dart';
import '../widgets/news_card.dart';
import 'article_detail_screen.dart';
import 'search_screen.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryInfo category;
  final String languageCode;

  const CategoryScreen({
    super.key,
    required this.category,
    required this.languageCode,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final NewsApiService _service = NewsApiService();
  late Future<List<Article>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.fetchTopHeadlines(
      category: widget.category.id,
      languageCode: widget.languageCode,
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _service.fetchTopHeadlines(
        category: widget.category.id,
        languageCode: context.read<AppSettings>().languageCode,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = context.watch<AppSettings>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const SearchScreen())),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => settings.toggleTheme(),
            icon: Icon(
              settings.isDark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Article>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    'Could not load ${widget.category.title} news.',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _refresh,
                    child: const Text('Retry'),
                  ),
                ],
              );
            }
            final articles = snapshot.data ?? [];
            if (articles.isEmpty) {
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    'No news found for now.',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try refreshing or changing the language.',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return NewsCard(
                  article: article,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ArticleDetailScreen(article: article),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
