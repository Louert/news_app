// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/app.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/models/article.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NewsApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Favorites tab shows favorite articles', (WidgetTester tester) async {
    final provider = NewsProvider();
    final article = Article(title: 'Fav', description: 'desc', url: 'url', urlToImage: '');
    provider.articles.add(article.copyWith(isFavorite: true));
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(
          home: DefaultTabController(
            length: 3,
            child: Builder(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Top'),
                      Tab(text: 'Cat'),
                      Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Container(),
                    Container(),
                    Consumer<NewsProvider>(
                      builder: (context, provider, _) {
                        final favorites = provider.favoriteArticles;
                        return ListView.builder(
                          itemCount: favorites.length,
                          itemBuilder: (context, index) => Text(favorites[index].title),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pumpAndSettle();
    expect(find.text('Fav'), findsOneWidget);
  });
}
