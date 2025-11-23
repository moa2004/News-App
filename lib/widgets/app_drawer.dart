import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_settings.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback? onNavigateHome;

  const AppDrawer({super.key, this.onNavigateHome});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();
    final theme = Theme.of(context);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'News App',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Fresh headlines, curated for you.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.home_outlined),
                title: const Text('Go To Home'),
                onTap: () {
                  Navigator.of(context).maybePop();
                  onNavigateHome?.call();
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Theme',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<ThemeMode>(
                initialValue: settings.themeMode,
                dropdownColor: theme.colorScheme.surface,
                decoration: _inputDecoration(theme),
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light'),
                  ),
                  DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('System'),
                  ),
                ],
                onChanged: (mode) => settings.setTheme(mode ?? ThemeMode.dark),
              ),
              const SizedBox(height: 16),
              Text(
                'Language',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: settings.language,
                dropdownColor: theme.colorScheme.surface,
                decoration: _inputDecoration(theme),
                items: const [
                  DropdownMenuItem(value: 'English', child: Text('English')),
                  DropdownMenuItem(value: 'Arabic', child: Text('Arabic')),
                ],
                onChanged: (value) => settings.setLanguage(value ?? 'English'),
              ),
              const Spacer(),
              Text(
                'Stay curious *',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.7,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(ThemeData theme) {
    return InputDecoration(
      filled: true,
      fillColor: theme.colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
