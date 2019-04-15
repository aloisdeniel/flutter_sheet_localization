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
  AppLocalizations(this.locale) : this.labels = _languages[locale.languageCode];

  final Locale locale;

  static final Map<String, AppLocalizations_Labels> _languages = {
    "fr": AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "lundi",
          tuesday: "mardi",
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
          may: "mai",
          june: "juin",
          july: "juillet",
          august: "août",
        ),
      ),
    ),
    "en": AppLocalizations_Labels(
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
          may: "may",
          june: "june",
          july: "july",
          august: "august",
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
      {this.january,
      this.february,
      this.march,
      this.april,
      this.may,
      this.june,
      this.july,
      this.august});

  final String january;

  final String february;

  final String march;

  final String april;

  final String may;

  final String june;

  final String july;

  final String august;
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
