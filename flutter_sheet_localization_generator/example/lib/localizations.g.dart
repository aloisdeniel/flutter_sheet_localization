// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizations.dart';

// **************************************************************************
// SheetLocalizationGenerator
// **************************************************************************

final localizedLabels = <Locale, AppLocalizationsData>{
  Locale.fromSubtags(languageCode: 'fr'): const AppLocalizationsData(
    multiline: 'C\'est\n\nune\n\nExemple multiligne.',
    plurals: const AppLocalizationsDataPlurals(
      manMultiple: 'hommes',
      manOne: 'homme',
      manZero: 'hommes',
    ),
    templated: const AppLocalizationsDataTemplated(
      contactFemale: 'Mme {{last_name}}',
      contactMale: 'M. {{last_name}}',
      hello: 'Bonjour {{first_name}}!',
      date: const AppLocalizationsDataTemplatedDate(
        pattern: 'Aujourd\'hui : {{date:DateTime[EEE, M/d/y]}}',
        simple: 'Aujourd\'hui : {{date:DateTime}}',
      ),
      numbers: const AppLocalizationsDataTemplatedNumbers(
        formatted: 'Le prix est de {{price:double[compactCurrency]}}',
        simple: 'Le prix est de {{price:double}}€',
        count: 'Il y a {{count:int}} éléments.',
      ),
    ),
    dates: const AppLocalizationsDataDates(
      month: const AppLocalizationsDataDatesMonth(
        april: 'avril',
        march: 'février',
        february: 'février',
        january: 'janvier',
      ),
      weekday: const AppLocalizationsDataDatesWeekday(
        sunday: 'dimanche',
        saturday: 'samedi',
        friday: 'vendredi',
        thursday: 'jeudi',
        wednesday: 'Mercredi',
        tuesday: 'Mardi',
        monday: 'LUNDI',
      ),
    ),
  ),
  Locale.fromSubtags(languageCode: 'en'): const AppLocalizationsData(
    multiline: 'This is\n\na\n\nmultiline example.',
    plurals: const AppLocalizationsDataPlurals(
      manMultiple: 'men',
      manOne: 'man',
      manZero: 'man',
    ),
    templated: const AppLocalizationsDataTemplated(
      contactFemale: 'Mrs {{last_name}}!',
      contactMale: 'Mr {{last_name}}!',
      hello: 'Hello {{first_name}}!',
      date: const AppLocalizationsDataTemplatedDate(
        pattern: 'Today : {{date:DateTime[EEE, M/d/y]}}',
        simple: 'Today : {{date:DateTime}}',
      ),
      numbers: const AppLocalizationsDataTemplatedNumbers(
        formatted: 'The price is {{price:double[compactCurrency]}}',
        simple: 'The price is {{price:double}}\$',
        count: 'There are {{count:int}}\ items.',
      ),
    ),
    dates: const AppLocalizationsDataDates(
      month: const AppLocalizationsDataDatesMonth(
        april: 'april',
        march: 'march',
        february: 'february',
        january: 'january',
      ),
      weekday: const AppLocalizationsDataDatesWeekday(
        sunday: 'sunday',
        saturday: 'saturday',
        friday: 'friday',
        thursday: 'thursday',
        wednesday: 'wednesday',
        tuesday: 'tuesday',
        monday: 'MONDAY',
      ),
    ),
  ),
  Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'):
      const AppLocalizationsData(
    multiline: '这是\n\n一种\n\n多行示例。',
    plurals: const AppLocalizationsDataPlurals(
      manMultiple: '男人',
      manOne: '男人',
      manZero: '男人',
    ),
    templated: const AppLocalizationsDataTemplated(
      contactFemale: '夫人{{last_name}}',
      contactMale: '先生{{last_name}}',
      hello: '你好{{first_name}}!',
      date: const AppLocalizationsDataTemplatedDate(
        pattern: '今日 : {{date:DateTime[EEE, M/d/y]}}',
        simple: '今日 : {{date:DateTime}}',
      ),
      numbers: const AppLocalizationsDataTemplatedNumbers(
        formatted: '価格は{{price:double[compactCurrency]}}です',
        simple: '価格は{{price:double}}¥です',
        count: '{{count:int}}個のアイテムがあります',
      ),
    ),
    dates: const AppLocalizationsDataDates(
      month: const AppLocalizationsDataDatesMonth(
        april: '四月',
        march: '游行',
        february: '二月',
        january: '一月',
      ),
      weekday: const AppLocalizationsDataDatesWeekday(
        sunday: '星期日',
        saturday: '星期六',
        friday: '星期五',
        thursday: '星期四',
        wednesday: '星期三',
        tuesday: '星期二',
        monday: '星期一',
      ),
    ),
  ),
};
enum Plural {
  multiple,
  one,
  zero,
}
enum Gender {
  female,
  male,
}

class AppLocalizationsData {
  const AppLocalizationsData({
    required this.multiline,
    required this.plurals,
    required this.templated,
    required this.dates,
  });

  final String multiline;
  final AppLocalizationsDataPlurals plurals;
  final AppLocalizationsDataTemplated templated;
  final AppLocalizationsDataDates dates;

  String getByKey({
    required String key,
  }) {
    switch (key) {
      case 'multiline':
        return multiline;
      default:
        return '';
    }
  }

  factory AppLocalizationsData.fromJson(Map<String, Object?> map) =>
      AppLocalizationsData(
        multiline: map['multiline']! as String,
        plurals: AppLocalizationsDataPlurals.fromJson(
            map['plurals']! as Map<String, Object?>),
        templated: AppLocalizationsDataTemplated.fromJson(
            map['templated']! as Map<String, Object?>),
        dates: AppLocalizationsDataDates.fromJson(
            map['dates']! as Map<String, Object?>),
      );

  AppLocalizationsData copyWith({
    String? multiline,
    AppLocalizationsDataPlurals? plurals,
    AppLocalizationsDataTemplated? templated,
    AppLocalizationsDataDates? dates,
  }) =>
      AppLocalizationsData(
        multiline: multiline ?? this.multiline,
        plurals: plurals ?? this.plurals,
        templated: templated ?? this.templated,
        dates: dates ?? this.dates,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsData &&
          multiline == other.multiline &&
          plurals == other.plurals &&
          templated == other.templated &&
          dates == other.dates);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      multiline.hashCode ^
      plurals.hashCode ^
      templated.hashCode ^
      dates.hashCode;
}

class AppLocalizationsDataPlurals {
  const AppLocalizationsDataPlurals({
    required String manMultiple,
    required String manOne,
    required String manZero,
  })  : _manMultiple = manMultiple,
        _manOne = manOne,
        _manZero = manZero;

  final String _manMultiple;
  final String _manOne;
  final String _manZero;

  String getByKey({
    required String key,
  }) {
    switch (key) {
      default:
        return '';
    }
  }

  String man({
    required Plural plural,
  }) {
    if (plural == Plural.multiple) {
      return _manMultiple;
    }
    if (plural == Plural.one) {
      return _manOne;
    }
    if (plural == Plural.zero) {
      return _manZero;
    }
    throw Exception();
  }

  factory AppLocalizationsDataPlurals.fromJson(Map<String, Object?> map) =>
      AppLocalizationsDataPlurals(
        manMultiple: map['manMultiple']! as String,
        manOne: map['manOne']! as String,
        manZero: map['manZero']! as String,
      );

  AppLocalizationsDataPlurals copyWith({
    String? manMultiple,
    String? manOne,
    String? manZero,
  }) =>
      AppLocalizationsDataPlurals(
        manMultiple: manMultiple ?? _manMultiple,
        manOne: manOne ?? _manOne,
        manZero: manZero ?? _manZero,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataPlurals &&
          _manMultiple == other._manMultiple &&
          _manOne == other._manOne &&
          _manZero == other._manZero);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      _manMultiple.hashCode ^
      _manOne.hashCode ^
      _manZero.hashCode;
}

class AppLocalizationsDataTemplated {
  const AppLocalizationsDataTemplated({
    required String contactFemale,
    required String contactMale,
    required String hello,
    required this.date,
    required this.numbers,
  })  : _contactFemale = contactFemale,
        _contactMale = contactMale,
        _hello = hello;

  final String _contactFemale;
  final String _contactMale;
  final String _hello;
  final AppLocalizationsDataTemplatedDate date;
  final AppLocalizationsDataTemplatedNumbers numbers;

  String getByKey({
    required String key,
  }) {
    switch (key) {
      default:
        return '';
    }
  }

  String contact({
    required Gender gender,
    required String lastName,
    String? locale,
  }) {
    if (gender == Gender.female) {
      return _contactFemale.insertTemplateValues(
        {
          'last_name': lastName,
        },
        locale: locale,
      );
    }
    if (gender == Gender.male) {
      return _contactMale.insertTemplateValues(
        {
          'last_name': lastName,
        },
        locale: locale,
      );
    }
    throw Exception();
  }

  String hello({
    required String firstName,
    String? locale,
  }) {
    return _hello.insertTemplateValues(
      {
        'first_name': firstName,
      },
      locale: locale,
    );
  }

  factory AppLocalizationsDataTemplated.fromJson(Map<String, Object?> map) =>
      AppLocalizationsDataTemplated(
        contactFemale: map['contactFemale']! as String,
        contactMale: map['contactMale']! as String,
        hello: map['hello']! as String,
        date: AppLocalizationsDataTemplatedDate.fromJson(
            map['date']! as Map<String, Object?>),
        numbers: AppLocalizationsDataTemplatedNumbers.fromJson(
            map['numbers']! as Map<String, Object?>),
      );

  AppLocalizationsDataTemplated copyWith({
    String? contactFemale,
    String? contactMale,
    String? hello,
    AppLocalizationsDataTemplatedDate? date,
    AppLocalizationsDataTemplatedNumbers? numbers,
  }) =>
      AppLocalizationsDataTemplated(
        contactFemale: contactFemale ?? _contactFemale,
        contactMale: contactMale ?? _contactMale,
        hello: hello ?? _hello,
        date: date ?? this.date,
        numbers: numbers ?? this.numbers,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataTemplated &&
          _contactFemale == other._contactFemale &&
          _contactMale == other._contactMale &&
          _hello == other._hello &&
          date == other.date &&
          numbers == other.numbers);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      _contactFemale.hashCode ^
      _contactMale.hashCode ^
      _hello.hashCode ^
      date.hashCode ^
      numbers.hashCode;
}

class AppLocalizationsDataTemplatedDate {
  const AppLocalizationsDataTemplatedDate({
    required String pattern,
    required String simple,
  })  : _pattern = pattern,
        _simple = simple;

  final String _pattern;
  final String _simple;

  String getByKey({
    required String key,
  }) {
    switch (key) {
      default:
        return '';
    }
  }

  String pattern({
    required DateTime date,
    String? locale,
  }) {
    return _pattern.insertTemplateValues(
      {
        'date': date,
      },
      locale: locale,
    );
  }

  String simple({
    required DateTime date,
    String? locale,
  }) {
    return _simple.insertTemplateValues(
      {
        'date': date,
      },
      locale: locale,
    );
  }

  factory AppLocalizationsDataTemplatedDate.fromJson(
          Map<String, Object?> map) =>
      AppLocalizationsDataTemplatedDate(
        pattern: map['pattern']! as String,
        simple: map['simple']! as String,
      );

  AppLocalizationsDataTemplatedDate copyWith({
    String? pattern,
    String? simple,
  }) =>
      AppLocalizationsDataTemplatedDate(
        pattern: pattern ?? _pattern,
        simple: simple ?? _simple,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataTemplatedDate &&
          _pattern == other._pattern &&
          _simple == other._simple);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ _pattern.hashCode ^ _simple.hashCode;
}

class AppLocalizationsDataTemplatedNumbers {
  const AppLocalizationsDataTemplatedNumbers({
    required String formatted,
    required String simple,
    required String count,
  })  : _formatted = formatted,
        _simple = simple,
        _count = count;

  final String _formatted;
  final String _simple;
  final String _count;

  String getByKey({
    required String key,
  }) {
    switch (key) {
      default:
        return '';
    }
  }

  String formatted({
    required double price,
    String? locale,
  }) {
    return _formatted.insertTemplateValues(
      {
        'price': price,
      },
      locale: locale,
    );
  }

  String simple({
    required double price,
    String? locale,
  }) {
    return _simple.insertTemplateValues(
      {
        'price': price,
      },
      locale: locale,
    );
  }

  String count({
    required int count,
    String? locale,
  }) {
    return _count.insertTemplateValues(
      {
        'count': count,
      },
      locale: locale,
    );
  }

  factory AppLocalizationsDataTemplatedNumbers.fromJson(
          Map<String, Object?> map) =>
      AppLocalizationsDataTemplatedNumbers(
        formatted: map['formatted']! as String,
        simple: map['simple']! as String,
        count: map['count']! as String,
      );

  AppLocalizationsDataTemplatedNumbers copyWith({
    String? formatted,
    String? simple,
    String? count,
  }) =>
      AppLocalizationsDataTemplatedNumbers(
        formatted: formatted ?? _formatted,
        simple: simple ?? _simple,
        count: count ?? _count,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataTemplatedNumbers &&
          _formatted == other._formatted &&
          _simple == other._simple &&
          _count == other._count);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      _formatted.hashCode ^
      _simple.hashCode ^
      _count.hashCode;
}

class AppLocalizationsDataDates {
  const AppLocalizationsDataDates({
    required this.month,
    required this.weekday,
  });

  final AppLocalizationsDataDatesMonth month;
  final AppLocalizationsDataDatesWeekday weekday;

  String getByKey({
    required String key,
  }) {
    switch (key) {
      default:
        return '';
    }
  }

  factory AppLocalizationsDataDates.fromJson(Map<String, Object?> map) =>
      AppLocalizationsDataDates(
        month: AppLocalizationsDataDatesMonth.fromJson(
            map['month']! as Map<String, Object?>),
        weekday: AppLocalizationsDataDatesWeekday.fromJson(
            map['weekday']! as Map<String, Object?>),
      );

  AppLocalizationsDataDates copyWith({
    AppLocalizationsDataDatesMonth? month,
    AppLocalizationsDataDatesWeekday? weekday,
  }) =>
      AppLocalizationsDataDates(
        month: month ?? this.month,
        weekday: weekday ?? this.weekday,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataDates &&
          month == other.month &&
          weekday == other.weekday);
  @override
  int get hashCode => runtimeType.hashCode ^ month.hashCode ^ weekday.hashCode;
}

class AppLocalizationsDataDatesMonth {
  const AppLocalizationsDataDatesMonth({
    required this.april,
    required this.march,
    required this.february,
    required this.january,
  });

  final String april;
  final String march;
  final String february;
  final String january;

  String getByKey({
    required String key,
  }) {
    switch (key) {
      case 'april':
        return april;
      case 'march':
        return march;
      case 'february':
        return february;
      case 'january':
        return january;
      default:
        return '';
    }
  }

  factory AppLocalizationsDataDatesMonth.fromJson(Map<String, Object?> map) =>
      AppLocalizationsDataDatesMonth(
        april: map['april']! as String,
        march: map['march']! as String,
        february: map['february']! as String,
        january: map['january']! as String,
      );

  AppLocalizationsDataDatesMonth copyWith({
    String? april,
    String? march,
    String? february,
    String? january,
  }) =>
      AppLocalizationsDataDatesMonth(
        april: april ?? this.april,
        march: march ?? this.march,
        february: february ?? this.february,
        january: january ?? this.january,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataDatesMonth &&
          april == other.april &&
          march == other.march &&
          february == other.february &&
          january == other.january);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      april.hashCode ^
      march.hashCode ^
      february.hashCode ^
      january.hashCode;
}

class AppLocalizationsDataDatesWeekday {
  const AppLocalizationsDataDatesWeekday({
    required this.sunday,
    required this.saturday,
    required this.friday,
    required this.thursday,
    required this.wednesday,
    required this.tuesday,
    required this.monday,
  });

  final String sunday;
  final String saturday;
  final String friday;
  final String thursday;
  final String wednesday;
  final String tuesday;
  final String monday;

  String getByKey({
    required String key,
  }) {
    switch (key) {
      case 'sunday':
        return sunday;
      case 'saturday':
        return saturday;
      case 'friday':
        return friday;
      case 'thursday':
        return thursday;
      case 'wednesday':
        return wednesday;
      case 'tuesday':
        return tuesday;
      case 'monday':
        return monday;
      default:
        return '';
    }
  }

  factory AppLocalizationsDataDatesWeekday.fromJson(Map<String, Object?> map) =>
      AppLocalizationsDataDatesWeekday(
        sunday: map['sunday']! as String,
        saturday: map['saturday']! as String,
        friday: map['friday']! as String,
        thursday: map['thursday']! as String,
        wednesday: map['wednesday']! as String,
        tuesday: map['tuesday']! as String,
        monday: map['monday']! as String,
      );

  AppLocalizationsDataDatesWeekday copyWith({
    String? sunday,
    String? saturday,
    String? friday,
    String? thursday,
    String? wednesday,
    String? tuesday,
    String? monday,
  }) =>
      AppLocalizationsDataDatesWeekday(
        sunday: sunday ?? this.sunday,
        saturday: saturday ?? this.saturday,
        friday: friday ?? this.friday,
        thursday: thursday ?? this.thursday,
        wednesday: wednesday ?? this.wednesday,
        tuesday: tuesday ?? this.tuesday,
        monday: monday ?? this.monday,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataDatesWeekday &&
          sunday == other.sunday &&
          saturday == other.saturday &&
          friday == other.friday &&
          thursday == other.thursday &&
          wednesday == other.wednesday &&
          tuesday == other.tuesday &&
          monday == other.monday);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      sunday.hashCode ^
      saturday.hashCode ^
      friday.hashCode ^
      thursday.hashCode ^
      wednesday.hashCode ^
      tuesday.hashCode ^
      monday.hashCode;
}
