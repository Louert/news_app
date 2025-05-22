import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/news_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _service;
  final List<Article> _articles = [];
  int _page = 1;
  bool _isLoading = false;
  final Map<String, List<Article>> _categoryArticles = {};

  NewsProvider([NewsService? service]) : _service = service ?? NewsService();

  List<Article> get articles => _articles;

  Future<void> fetchArticles() async {
    if (_isLoading) return;
    _isLoading = true;

    final newArticles = await _service.fetchArticles(page: _page);
    _articles.addAll(newArticles);
    _page++;
    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _articles.clear();
    _page = 1;
    notifyListeners();
  }

  void toggleFavorite(Article article) {
    final index = _articles.indexWhere((a) => a.url == article.url);
    if (index != -1) {
      _articles[index] = _articles[index].copyWith(isFavorite: !_articles[index].isFavorite);
    } else {
      _articles.add(article.copyWith(isFavorite: true));
    }
    _categoryArticles.forEach((cat, list) {
      for (var i = 0; i < list.length; i++) {
        if (list[i].url == article.url) {
          list[i] = list[i].copyWith(isFavorite: !list[i].isFavorite);
        }
      }
    });
    notifyListeners();
  }

  List<Article> get favoriteArticles => _articles.where((a) => a.isFavorite).toList();

  List<Article> getArticlesByCategory(String category) {
    return _categoryArticles[category] ?? [];
  }

  Future<void> fetchArticlesByCategory(String category, {int page = 1}) async {
    final newArticles = await _service.fetchArticles(category: category, page: page);
    if (_categoryArticles[category] == null) {
      _categoryArticles[category] = [];
    }
    for (var i = 0; i < newArticles.length; i++) {
      final global = _articles.firstWhere(
        (a) => a.url == newArticles[i].url,
        orElse: () => newArticles[i],
      );
      newArticles[i] = newArticles[i].copyWith(isFavorite: global.isFavorite);
    }
    _categoryArticles[category]!.addAll(newArticles);
    notifyListeners();
  }
}
