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
      multiline: "C'est\n\nune\n\nexemple multiligne.",
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "LUNDI",
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
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "M. ${lastName}";
          if (condition == Gender.female) return "Mme ${lastName}";
          throw Exception();
        },
        numbers: AppLocalizations_Labels_Templated_Numbers(
          count: ({count}) =>
              "Il y a ${NumberFormat(null, 'fr').format(count)} éléments.",
          simple: ({price}) =>
              "Le prix est de ${NumberFormat(null, 'fr').format(price)}€",
          formatted: ({price}) =>
              "Le prix est de ${NumberFormat.compactCurrency(locale: 'fr').format(price)}",
        ),
        date: AppLocalizations_Labels_Templated_Date(
          simple: ({date}) => "Aujourd'hui : ${date.toIso8601String()}",
          pattern: ({date}) =>
              "Aujourd'hui : ${DateFormat('EEE, M/d/y', 'fr').format(date)}",
        ),
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
      multiline: "This is\n\na\n\nmultiline example.",
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "MONDAY",
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
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "Mr ${lastName}!";
          if (condition == Gender.female) return "Mrs ${lastName}!";
          throw Exception();
        },
        numbers: AppLocalizations_Labels_Templated_Numbers(
          count: ({count}) =>
              "There are ${NumberFormat(null, 'en').format(count)}\ items.",
          simple: ({price}) =>
              "The price is ${NumberFormat(null, 'en').format(price)}\$",
          formatted: ({price}) =>
              "The price is ${NumberFormat.compactCurrency(locale: 'en').format(price)}",
        ),
        date: AppLocalizations_Labels_Templated_Date(
          simple: ({date}) => "Today : ${date.toIso8601String()}",
          pattern: ({date}) =>
              "Today : ${DateFormat('EEE, M/d/y', 'en').format(date)}",
        ),
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
      multiline: "这是\n\n一个\n\n多例子。",
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
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "先生${lastName}";
          if (condition == Gender.female) return "夫人${lastName}";
          throw Exception();
        },
        numbers: AppLocalizations_Labels_Templated_Numbers(
          count: ({count}) =>
              "${NumberFormat(null, 'zh-Hans-CN').format(count)}個のアイテムがあります",
          simple: ({price}) =>
              "価格は${NumberFormat(null, 'zh-Hans-CN').format(price)}¥です",
          formatted: ({price}) =>
              "価格は${NumberFormat.compactCurrency(locale: 'zh-Hans-CN').format(price)}です",
        ),
        date: AppLocalizations_Labels_Templated_Date(
          simple: ({date}) => "今日 : ${date.toIso8601String()}",
          pattern: ({date}) =>
              "今日 : ${DateFormat('EEE, M/d/y', 'zh-Hans-CN').format(date)}",
        ),
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

enum Gender {
  male,
  female,
}
enum Plural {
  zero,
  one,
  multiple,
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

  String getByKey(String key) {
    switch (key) {
      case 'monday':
        return monday;
      case 'tuesday':
        return tuesday;
      case 'wednesday':
        return wednesday;
      case 'thursday':
        return thursday;
      case 'friday':
        return friday;
      case 'saturday':
        return saturday;
      case 'sunday':
        return sunday;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Dates_Month {
  const AppLocalizations_Labels_Dates_Month(
      {this.january, this.february, this.march, this.april});

  final String january;

  final String february;

  final String march;

  final String april;

  String getByKey(String key) {
    switch (key) {
      case 'january':
        return january;
      case 'february':
        return february;
      case 'march':
        return march;
      case 'april':
        return april;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Dates {
  const AppLocalizations_Labels_Dates({this.weekday, this.month});

  final AppLocalizations_Labels_Dates_Weekday weekday;

  final AppLocalizations_Labels_Dates_Month month;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }
}

typedef String AppLocalizations_Labels_Templated_hello(
    {@required String firstName});
typedef String AppLocalizations_Labels_Templated_contact(Gender condition,
    {@required String lastName});
typedef String AppLocalizations_Labels_Templated_Numbers_count(
    {@required int count});
typedef String AppLocalizations_Labels_Templated_Numbers_simple(
    {@required double price});
typedef String AppLocalizations_Labels_Templated_Numbers_formatted(
    {@required double price});

class AppLocalizations_Labels_Templated_Numbers {
  const AppLocalizations_Labels_Templated_Numbers(
      {AppLocalizations_Labels_Templated_Numbers_count count,
      AppLocalizations_Labels_Templated_Numbers_simple simple,
      AppLocalizations_Labels_Templated_Numbers_formatted formatted})
      : this._count = count,
        this._simple = simple,
        this._formatted = formatted;

  final AppLocalizations_Labels_Templated_Numbers_count _count;

  final AppLocalizations_Labels_Templated_Numbers_simple _simple;

  final AppLocalizations_Labels_Templated_Numbers_formatted _formatted;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }

  String count({@required int count}) => this._count(
        count: count,
      );
  String simple({@required double price}) => this._simple(
        price: price,
      );
  String formatted({@required double price}) => this._formatted(
        price: price,
      );
}

typedef String AppLocalizations_Labels_Templated_Date_simple(
    {@required DateTime date});
typedef String AppLocalizations_Labels_Templated_Date_pattern(
    {@required DateTime date});

class AppLocalizations_Labels_Templated_Date {
  const AppLocalizations_Labels_Templated_Date(
      {AppLocalizations_Labels_Templated_Date_simple simple,
      AppLocalizations_Labels_Templated_Date_pattern pattern})
      : this._simple = simple,
        this._pattern = pattern;

  final AppLocalizations_Labels_Templated_Date_simple _simple;

  final AppLocalizations_Labels_Templated_Date_pattern _pattern;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }

  String simple({@required DateTime date}) => this._simple(
        date: date,
      );
  String pattern({@required DateTime date}) => this._pattern(
        date: date,
      );
}

class AppLocalizations_Labels_Templated {
  const AppLocalizations_Labels_Templated(
      {AppLocalizations_Labels_Templated_hello hello,
      AppLocalizations_Labels_Templated_contact contact,
      this.numbers,
      this.date})
      : this._hello = hello,
        this._contact = contact;

  final AppLocalizations_Labels_Templated_hello _hello;

  final AppLocalizations_Labels_Templated_contact _contact;

  final AppLocalizations_Labels_Templated_Numbers numbers;

  final AppLocalizations_Labels_Templated_Date date;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }

  String hello({@required String firstName}) => this._hello(
        firstName: firstName,
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

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }

  String man(Plural condition) => this._man(
        condition,
      );
}

class AppLocalizations_Labels {
  const AppLocalizations_Labels(
      {this.multiline, this.dates, this.templated, this.plurals});

  final String multiline;

  final AppLocalizations_Labels_Dates dates;

  final AppLocalizations_Labels_Templated templated;

  final AppLocalizations_Labels_Plurals plurals;

  String getByKey(String key) {
    switch (key) {
      case 'multiline':
        return multiline;
      default:
        return '';
    }
  }
}
