import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/l10n/l10n.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/theme/themes.dart';
import 'package:get_it/get_it.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString('themeMode');
    final lang = prefs.getString('languageCode');
    setState(() {
      _themeMode = _parseThemeMode(mode);
      _locale = lang != null ? Locale(lang) : null;
    });
  }

  ThemeMode _parseThemeMode(String? mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void _toggleTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.name);
    setState(() => _themeMode = mode);
  }

  void _changeLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GetIt.instance<NewsProvider>()..fetchArticles(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NewsApp',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeMode,
        locale: _locale,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: HomeScreen(
          onThemeChanged: _toggleTheme,
          onLocaleChanged: _changeLanguage,
        ),
      ),
    );
  }
}
