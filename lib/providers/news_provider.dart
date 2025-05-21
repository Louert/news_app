import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/news_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _service = NewsService();
  final List<Article> _articles = [];
  int _page = 1;
  bool _isLoading = false;

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

  Future<List<Article>> fetchArticlesByCategory(String category, {int page = 1}) async {
    return await _service.fetchArticles(category: category, page: page);
  }

  void reset() {
    _articles.clear();
    _page = 1;
    notifyListeners();
  }
}
