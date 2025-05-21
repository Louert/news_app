import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: article.urlToImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  article.urlToImage,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                ),
              )
            : const Icon(Icons.image),
        title: Text(article.title ?? 'No title'),
        subtitle: Text(article.description ?? 'No description'),
        onTap: onTap,
      ),
    );
  }
}
