// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizations.dart';

// **************************************************************************
// SheetLocalizationGenerator
// **************************************************************************

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
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstName}) => "Bonjour ${firstName}!",
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
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstName}) => "Hello ${firstName}!",
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
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstName}) => "你好${firstName}!",
      ),
    ),
  };

  final AppLocalizations_Labels labels;

  static AppLocalizations_Labels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)?.labels;
}

class AppLocalizations_Labels_Dates_Weekday {
  const AppLocalizations_Labels_Dates_Weekday(
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
  const AppLocalizations_Labels_Dates_Month(
      {this.january, this.february, this.march, this.april});

  final String january;

  final String february;

  final String march;

  final String april;
}

class AppLocalizations_Labels_Dates {
  const AppLocalizations_Labels_Dates({this.weekday, this.month});

  final AppLocalizations_Labels_Dates_Weekday weekday;

  final AppLocalizations_Labels_Dates_Month month;
}

typedef String AppLocalizations_Labels_Templated_hello(
    {@required String firstName});

class AppLocalizations_Labels_Templated {
  const AppLocalizations_Labels_Templated(
      {AppLocalizations_Labels_Templated_hello hello})
      : this._hello = hello;

  final AppLocalizations_Labels_Templated_hello _hello;

  String hello({@required String firstName}) => this._hello(
        firstName: firstName,
      );
}

class AppLocalizations_Labels {
  const AppLocalizations_Labels({this.dates, this.templated});

  final AppLocalizations_Labels_Dates dates;

  final AppLocalizations_Labels_Templated templated;
}
