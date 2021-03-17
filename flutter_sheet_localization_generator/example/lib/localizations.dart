import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';
import 'package:intl/intl.dart';

part 'localizations.g.dart';

enum Plural {
  zero,
  one,
  multiple,
}

extension PluralExtension on int {
  Plural plural() {
    if (this == 0) return Plural.zero;
    if (this == 1) return Plural.one;
    return Plural.multiple;
  }
}

@SheetLocalization('10-53L67TkSS-4XXI7KBNm8odYbgudjOsR99MvY49BCs', '0', 1)
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
