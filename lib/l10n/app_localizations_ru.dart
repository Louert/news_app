// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Новости';

  @override
  String get openInBrowser => 'Открыть в браузере';

  @override
  String get categories => 'Категории';

  @override
  String get topNews => 'Главные новости';

  @override
  String get switchToDark => 'Темная тема';

  @override
  String get switchToLight => 'Светлая тема';

  @override
  String get categoryBusiness => 'Бизнес';

  @override
  String get categoryTechnology => 'Технологии';

  @override
  String get categorySports => 'Спорт';

  @override
  String get categoryHealth => 'Здоровье';

  @override
  String get categoryScience => 'Наука';

  @override
  String get noFavorites => 'Нет избранных статей.';
}
