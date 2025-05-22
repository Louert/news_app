// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'News App';

  @override
  String get openInBrowser => 'Open in Browser';

  @override
  String get categories => 'Categories';

  @override
  String get topNews => 'Top News';

  @override
  String get switchToDark => 'Switch to Dark Theme';

  @override
  String get switchToLight => 'Switch to Light Theme';

  @override
  String get categoryBusiness => 'Business';

  @override
  String get categoryTechnology => 'Technology';

  @override
  String get categorySports => 'Sports';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryScience => 'Science';

  @override
  String get noFavorites => 'No favorite articles yet.';
}
