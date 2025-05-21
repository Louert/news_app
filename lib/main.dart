import 'package:flutter/material.dart';
import 'package:news_app/app.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NewsApp());
}

Future<Uint8List?> fetchImageBytes(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'User-Agent': 'Mozilla/5.0',
      'Referer': 'https://lexus-cms-media.s3.us-east-2.amazonaws.com/', // или нужный referer
    },
  );
  if (response.statusCode == 200) {
    return response.bodyBytes;
  }
  return null;
}

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: fetchImageBytes(article.urlToImage),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data != null) {
          return Image.memory(snapshot.data!, height: 200);
        } else {
          return const Icon(Icons.image_not_supported, size: 100);
        }
      },
    );
  }
}

