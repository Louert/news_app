class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  bool isFavorite;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    this.isFavorite = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    url: json['url'] ?? '',
    urlToImage: json['urlToImage'] ?? '',
  );

  Article copyWith({bool? isFavorite}) {
    return Article(
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
