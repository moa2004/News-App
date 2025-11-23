import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/article.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;
  final bool emphasizeButton;

  const NewsCard({
    super.key,
    required this.article,
    required this.onTap,
    this.emphasizeButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.dividerColor.withValues(alpha: 0.4);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.35 : 0.08,
            ),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NewsImage(url: article.imageUrl),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      article.source,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const _Dot(),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat(
                        'MMM d, h:mm a',
                      ).format(article.publishedAt.toLocal()),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ],
                ),
                if (article.description.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    article.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: emphasizeButton
                      ? ElevatedButton(
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('View Full Article'),
                        )
                      : TextButton.icon(
                          onPressed: onTap,
                          icon: const Icon(Icons.read_more_rounded),
                          label: const Text('Open'),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const NewsTile({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _NewsImage(url: article.imageUrl, width: 100, height: 90),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        article.source,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const _Dot(),
                      const SizedBox(width: 6),
                      Text(
                        DateFormat('MMM d').format(article.publishedAt),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;

  const _NewsImage({required this.url, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: width ?? double.infinity,
      height: height ?? 190,
      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.2),
      child: const Icon(Icons.image_not_supported_outlined, size: 48),
    );
    if (url.isEmpty) return placeholder;
    return CachedNetworkImage(
      imageUrl: url,
      width: width ?? double.infinity,
      height: height ?? 190,
      fit: BoxFit.cover,
      placeholder: (_, __) => placeholder,
      errorWidget: (_, __, ___) => placeholder,
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
        shape: BoxShape.circle,
      ),
    );
  }
}
