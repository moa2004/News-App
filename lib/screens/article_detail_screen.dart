import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.source,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CachedNetworkImage(
                imageUrl: article.imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(
                  height: 220,
                  color: theme.colorScheme.surface.withValues(alpha: 0.2),
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    size: 48,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              article.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  article.author,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const _Dot(),
                const SizedBox(width: 8),
                Text(
                  DateFormat(
                    'MMMM d, h:mm a',
                  ).format(article.publishedAt.toLocal()),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(
                      alpha: 0.7,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              article.description.isNotEmpty
                  ? article.description
                  : 'No description available.',
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            if (article.content.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                article.content,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: article.url.isEmpty ? null : () => _openArticle(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.travel_explore_rounded),
              label: const Text('View Full Article'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openArticle() async {
    final uri = Uri.tryParse(article.url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}
