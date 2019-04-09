import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) =>
      AppLocalizations._languages.containsKey(locale.languageCode);
  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class AppLocalizations {
  AppLocalizations(Locale this.locale)
      : this.labels = _languages[locale.languageCode];

  final Locale locale;

  static final Map<String, Labels> _languages = {
    "fr": Labels(
      dates: Dates(
        weekday: Weekday(
          monday: "lundi",
          tuesday: "mardi",
          wednesday: "mercredi",
          thursday: "jeudi",
          friday: "vendredi",
          saturday: "samedi",
          sunday: "dimanche",
        ),
        month: Month(
          january: "janvier",
          february: "février",
          march: "mars",
          april: "avril",
          may: "mai",
          june: "juin",
          july: "juillet",
          august: "août",
        ),
      ),
    ),
    "en": Labels(
      dates: Dates(
        weekday: Weekday(
          monday: "monday",
          tuesday: "tuesday",
          wednesday: "wednesday",
          thursday: "thursday",
          friday: "friday",
          saturday: "saturday",
          sunday: "sunday",
        ),
        month: Month(
          january: "january",
          february: "february",
          march: "march",
          april: "april",
          may: "may",
          june: "june",
          july: "july",
          august: "august",
        ),
      ),
    ),
  };

  final Labels labels;

  Labels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations).labels;
}

class Weekday {
  Weekday(
      {String this.monday,
      String this.tuesday,
      String this.wednesday,
      String this.thursday,
      String this.friday,
      String this.saturday,
      String this.sunday});

  final String monday;

  final String tuesday;

  final String wednesday;

  final String thursday;

  final String friday;

  final String saturday;

  final String sunday;
}

class Month {
  Month(
      {String this.january,
      String this.february,
      String this.march,
      String this.april,
      String this.may,
      String this.june,
      String this.july,
      String this.august});

  final String january;

  final String february;

  final String march;

  final String april;

  final String may;

  final String june;

  final String july;

  final String august;
}

class Dates {
  Dates({Weekday this.weekday, Month this.month});

  final Weekday weekday;

  final Month month;
}

class Labels {
  Labels({Dates this.dates});

  final Dates dates;
}
