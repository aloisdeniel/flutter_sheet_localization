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
      amount: (condition, {amount}) {
        if (condition == NumberFormatter.compactCurrency)
          return "${NumberFormat.compactCurrency(locale: 'fr').format(amount)}";
        if (condition == NumberFormatter.decimalPattern)
          return "${NumberFormat.decimalPattern('fr').format(amount)}";
        if (condition == NumberFormatter.currency)
          return "${NumberFormat.currency(locale: 'fr').format(amount)}";
        return "${NumberFormat(null, 'fr').format(amount)}";
      },
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "Lundi",
          tuesday: "Mardi",
          wednesday: "Mercredi",
          thursday: "Jeudi",
          friday: "Vendredi",
          saturday: "samedi",
          sunday: "dimanche",
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: "janvier",
          february: "février",
          march: "février",
          april: "avril",
        ),
      ),
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstName}) => "Bonjour ${firstName}!",
        datetime: (condition, {now}) {
          if (condition == DateFormatter.yMd)
            return "Aujourd'hui nous sommes le ${DateFormat('yMd', 'fr').format(now)}";
          throw Exception();
        },
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "M. ${lastName}";
          if (condition == Gender.female) return "Mme ${lastName}";
          throw Exception();
        },
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.zero) return "hommes";
          if (condition == Plural.one) return "homme";
          if (condition == Plural.multiple) return "hommes";
          throw Exception();
        },
      ),
    ),
    Locale.fromSubtags(languageCode: "en"): AppLocalizations_Labels(
      amount: (condition, {amount}) {
        if (condition == NumberFormatter.compactCurrency)
          return "${NumberFormat.compactCurrency(locale: 'en').format(amount)}";
        if (condition == NumberFormatter.decimalPattern)
          return "${NumberFormat.decimalPattern('en').format(amount)}";
        if (condition == NumberFormatter.currency)
          return "${NumberFormat.currency(locale: 'en').format(amount)}";
        return "${NumberFormat(null, 'en').format(amount)}";
      },
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
        datetime: (condition, {now}) {
          if (condition == DateFormatter.yMd)
            return "Today it's ${DateFormat('yMd', 'en').format(now)}";
          throw Exception();
        },
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "Mr ${lastName}!";
          if (condition == Gender.female) return "Mrs ${lastName}!";
          throw Exception();
        },
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.zero) return "man";
          if (condition == Plural.one) return "man";
          if (condition == Plural.multiple) return "men";
          throw Exception();
        },
      ),
    ),
    Locale.fromSubtags(
        languageCode: "zh",
        scriptCode: "Hans",
        countryCode: "CN"): AppLocalizations_Labels(
      amount: (condition, {amount}) {
        if (condition == NumberFormatter.compactCurrency)
          return "${NumberFormat.compactCurrency(locale: 'zh-Hans-CN').format(amount)}";
        if (condition == NumberFormatter.decimalPattern)
          return "${NumberFormat.decimalPattern('zh-Hans-CN').format(amount)}";
        if (condition == NumberFormatter.currency)
          return "${NumberFormat.currency(locale: 'zh-Hans-CN').format(amount)}";
        return "${NumberFormat(null, 'zh-Hans-CN').format(amount)}";
      },
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
        datetime: (condition, {now}) {
          if (condition == DateFormatter.yMd)
            return "${DateFormat('yMd', 'zh-Hans-CN').format(now)}";
          throw Exception();
        },
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "先生${lastName}";
          if (condition == Gender.female) return "夫人${lastName}";
          throw Exception();
        },
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.zero) return "男人";
          if (condition == Plural.one) return "男人";
          if (condition == Plural.multiple) return "男人";
          throw Exception();
        },
      ),
    ),
  };

  final AppLocalizations_Labels labels;

  static AppLocalizations_Labels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)?.labels;
}

enum NumberFormatter {
  compactCurrency,
  decimalPattern,
  currency,
}
enum DateFormatter {
  yMd,
}
enum Gender {
  male,
  female,
}
enum Plural {
  zero,
  one,
  multiple,
}
typedef String AppLocalizations_Labels_amount(NumberFormatter condition,
    {@required double amount});

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
typedef String AppLocalizations_Labels_Templated_datetime(
    DateFormatter condition,
    {@required DateTime now});
typedef String AppLocalizations_Labels_Templated_contact(Gender condition,
    {@required String lastName});

class AppLocalizations_Labels_Templated {
  const AppLocalizations_Labels_Templated(
      {AppLocalizations_Labels_Templated_hello hello,
      AppLocalizations_Labels_Templated_datetime datetime,
      AppLocalizations_Labels_Templated_contact contact})
      : this._hello = hello,
        this._datetime = datetime,
        this._contact = contact;

  final AppLocalizations_Labels_Templated_hello _hello;

  final AppLocalizations_Labels_Templated_datetime _datetime;

  final AppLocalizations_Labels_Templated_contact _contact;

  String hello({@required String firstName}) => this._hello(
        firstName: firstName,
      );
  String datetime(DateFormatter condition, {@required DateTime now}) =>
      this._datetime(
        condition,
        now: now,
      );
  String contact(Gender condition, {@required String lastName}) =>
      this._contact(
        condition,
        lastName: lastName,
      );
}

typedef String AppLocalizations_Labels_Plurals_man(Plural condition);

class AppLocalizations_Labels_Plurals {
  const AppLocalizations_Labels_Plurals(
      {AppLocalizations_Labels_Plurals_man man})
      : this._man = man;

  final AppLocalizations_Labels_Plurals_man _man;

  String man(Plural condition) => this._man(
        condition,
      );
}

class AppLocalizations_Labels {
  const AppLocalizations_Labels(
      {AppLocalizations_Labels_amount amount,
      this.dates,
      this.templated,
      this.plurals})
      : this._amount = amount;

  final AppLocalizations_Labels_amount _amount;

  final AppLocalizations_Labels_Dates dates;

  final AppLocalizations_Labels_Templated templated;

  final AppLocalizations_Labels_Plurals plurals;

  String amount(NumberFormatter condition, {@required double amount}) =>
      this._amount(
        condition,
        amount: amount,
      );
}
