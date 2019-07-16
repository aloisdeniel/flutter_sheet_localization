import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.languages.containsKey(locale);
  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class AppLocalizations {
  AppLocalizations(this.locale) : this.labels = languages[locale];

  final Locale locale;

  static final Map<Locale, AppLocalizations_Labels> languages = {
    Locale.fromSubtags(languageCode: "fr"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "lundi",
          tuesday: "mardia",
          wednesday: "mercredi",
          thursday: "jeudi",
          friday: "vendredi",
          saturday: "samedi",
          sunday: "dimanche",
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: "janvier",
          february: "février",
          march: "mars",
          april: "avril",
        ),
      ),
    ),
    Locale.fromSubtags(languageCode: "en"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "monday",
          tuesday: "tuesday",
          wednesday: "wednesday",
          thursday: "thursday",
          friday: "friday",
          saturday: "saturday",
          sunday: "sunday",
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: "january",
          february: "february",
          march: "march",
          april: "april",
        ),
      ),
    ),
    Locale.fromSubtags(
        languageCode: "zh",
        scriptCode: "Hans",
        countryCode: "CN"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "星期一",
          tuesday: "星期二",
          wednesday: "星期三",
          thursday: "星期四",
          friday: "星期五",
          saturday: "星期六",
          sunday: "星期日",
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: "一月",
          february: "二月",
          march: "游行",
          april: "四月",
        ),
      ),
    ),
  };

  final AppLocalizations_Labels labels;

  static AppLocalizations_Labels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations).labels;
}

class AppLocalizations_Labels_Dates_Weekday {
  AppLocalizations_Labels_Dates_Weekday(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  final String monday;

  final String tuesday;

  final String wednesday;

  final String thursday;

  final String friday;

  final String saturday;

  final String sunday;
}

class AppLocalizations_Labels_Dates_Month {
  AppLocalizations_Labels_Dates_Month(
      {this.january, this.february, this.march, this.april});

  final String january;

  final String february;

  final String march;

  final String april;
}

class AppLocalizations_Labels_Dates {
  AppLocalizations_Labels_Dates({this.weekday, this.month});

  final AppLocalizations_Labels_Dates_Weekday weekday;

  final AppLocalizations_Labels_Dates_Month month;
}

class AppLocalizations_Labels {
  AppLocalizations_Labels({this.dates});

  final AppLocalizations_Labels_Dates dates;
}
