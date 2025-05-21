import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_app/models/article.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title, maxLines: 1)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (article.urlToImage.isNotEmpty)
              Image.network(article.urlToImage, errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, size: 100);
              },),
            const SizedBox(height: 12),
            Text(article.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(article.description),
            const Spacer(),
            ElevatedButton(
              onPressed: () => launchUrl(Uri.parse(article.url)),
              child: const Text('Open in Browser'),
            )
          ],
        ),
      ),
    );
  }
}
