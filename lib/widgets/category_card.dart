import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final CategoryInfo category;
  final bool isDark;
  final VoidCallback onView;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isDark,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFEDEDED);
    final borderColor = isDark ? Colors.white10 : Colors.black12;
    return Container(
      height: 170,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.35)
                : Colors.grey.withValues(alpha: 0.2),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              isDark ? category.darkAsset : category.asset,
              width: 140,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? const Color(0xFFF5F5F5)
                          : Colors.black,
                      foregroundColor: isDark ? Colors.black : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                    ),
                    onPressed: onView,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('View All'),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, size: 18),
                      ],
                    ),
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
