import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/widgets/article_card.dart';
import 'package:news_app/screens/detail_screen.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  final void Function(ThemeMode mode) onThemeChanged;
  final void Function(Locale locale) onLocaleChanged;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.onLocaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);
    final articles = provider.articles;
    final localizations = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final categories = {
      'business': localizations.categoryBusiness,
      'technology': localizations.categoryTechnology,
      'sports': localizations.categorySports,
      'health': localizations.categoryHealth,
      'science': localizations.categoryScience,
    };

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.appTitle),
          actions: [
            IconButton(
              icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
              tooltip: isDark
                  ? localizations.switchToLight
                  : localizations.switchToDark,
              onPressed: () {
                final mode =
                    isDark ? ThemeMode.light : ThemeMode.dark;
                onThemeChanged(mode);
              },
            ),
            PopupMenuButton<Locale>(
              icon: const Icon(Icons.language),
              tooltip: 'Change language',
              onSelected: onLocaleChanged,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                const PopupMenuItem(
                  value: Locale('ru'),
                  child: Text('Русский'),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: localizations.topNews),
              Tab(text: localizations.categories),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Top News
            NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  provider.fetchArticles();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) => ArticleCard(
                  article: articles[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DetailScreen(article: articles[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Categories (localizations)
            ListView(
              padding: const EdgeInsets.all(16),
              children: categories.entries.map((entry) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      entry.value,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryScreen(category: entry.key),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
