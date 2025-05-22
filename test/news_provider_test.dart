import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/models/article.dart';

void main() {
  group('NewsProvider favorites', () {
    test('toggleFavorite adds and removes favorite', () {
      final provider = NewsProvider();
      final article = Article(title: 't', description: 'd', url: 'u', urlToImage: 'img');
      provider.articles.add(article);
      expect(provider.favoriteArticles.length, 0);
      provider.toggleFavorite(article);
      expect(provider.favoriteArticles.length, 1);
      provider.toggleFavorite(article);
      expect(provider.favoriteArticles.length, 0);
    });
  });
} 