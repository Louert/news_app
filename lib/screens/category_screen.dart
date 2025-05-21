import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Добавляем импорт
import 'package:provider/provider.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/widgets/article_card.dart';
import 'package:news_app/screens/detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Article> _articles = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  final ScrollController _controller = ScrollController();

  // Метод для получения переведенного названия категории
  String _getLocalizedCategoryTitle(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (widget.category) {
      case 'business':
        return localizations.categoryBusiness;
      case 'technology':
        return localizations.categoryTechnology;
      case 'sports':
        return localizations.categorySports;
      case 'health':
        return localizations.categoryHealth;
      case 'science':
        return localizations.categoryScience;
      default:
        return widget.category.toUpperCase();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchArticles();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_controller.position.pixels >= _controller.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _fetchArticles();
    }
  }

  Future<void> _fetchArticles() async {
    setState(() => _isLoading = true);
    final provider = Provider.of<NewsProvider>(context, listen: false);
    final fetched = await provider.fetchArticlesByCategory(widget.category, page: _page);
    setState(() {
      _articles.addAll(fetched);
      _isLoading = false;
      _page++;
      if (fetched.length < 10) _hasMore = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getLocalizedCategoryTitle(context)), // Используем локализованный заголовок
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: _articles.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _articles.length) {
            return ArticleCard(
              article: _articles[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(article: _articles[index]),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ));
          }
        },
      ),
    );
  }
}
