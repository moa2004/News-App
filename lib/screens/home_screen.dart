import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/app_settings.dart';
import '../widgets/app_drawer.dart';
import '../widgets/category_card.dart';
import 'category_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<CategoryInfo> _categories() {
    return const [
      CategoryInfo(
        id: 'general',
        title: 'General',
        asset: 'assets/general.png',
        darkAsset: 'assets/general_dark.png',
      ),
      CategoryInfo(
        id: 'business',
        title: 'Business',
        asset: 'assets/busniess.png',
        darkAsset: 'assets/busniess_dark.png',
      ),
      CategoryInfo(
        id: 'sports',
        title: 'Sports',
        asset: 'assets/sport.png',
        darkAsset: 'assets/sport_dark.png',
      ),
      CategoryInfo(
        id: 'technology',
        title: 'Technology',
        asset: 'assets/technology.png',
        darkAsset: 'assets/technology_dark.png',
      ),
      CategoryInfo(
        id: 'health',
        title: 'Health',
        asset: 'assets/helth.png',
        darkAsset: 'assets/helth_dark.png',
      ),
      CategoryInfo(
        id: 'science',
        title: 'Science',
        asset: 'assets/science.png',
        darkAsset: 'assets/science_dark.png',
      ),
      CategoryInfo(
        id: 'entertainment',
        title: 'Entertainment',
        asset: 'assets/entertainment.png',
        darkAsset: 'assets/entertainment_dark.png',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();
    final theme = Theme.of(context);
    final categories = _categories();

    return Scaffold(
      drawer: AppDrawer(
        onNavigateHome: () =>
            Navigator.of(context).popUntil((route) => route.isFirst),
      ),
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Here is Some News For You',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              ...categories.map(
                (c) => CategoryCard(
                  category: c,
                  isDark: settings.isDark,
                  onView: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(
                        category: c,
                        languageCode: settings.languageCode,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
