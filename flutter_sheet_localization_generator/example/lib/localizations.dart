import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';
import 'package:intl/intl.dart';

part 'localization.g.dart';

Plural plural(int count) {
  if (count == 0) return Plural.zero;
  if (count == 1) return Plural.one;
  return Plural.multiple;
}

@SheetLocalization("1jVak4IbIzj-K7D_PIQ-gjmWNGStEau62C9e8_jzAX_Y", "0")
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.languages.containsKey(locale);
  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
