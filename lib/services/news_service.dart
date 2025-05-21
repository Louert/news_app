import 'package:dio/dio.dart';
import 'package:news_app/models/article.dart';

class NewsService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://newsapi.org/v2';
  final String _apiKey = '5213288826764f399289b7805d3e3560'; // замените на ваш API ключ

  Future<List<Article>> fetchArticles({int page = 1, String? category}) async {
    final response = await _dio.get('$_baseUrl/top-headlines', queryParameters: {
      'country': 'us',
      'apiKey': _apiKey,
      'page': page,
      'pageSize': 10,
      if (category != null) 'category': category,
    });

    return (response.data['articles'] as List)
        .map((json) => Article.fromJson(json))
        .toList();
  }
}
