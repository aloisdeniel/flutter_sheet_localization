import 'dart:ui';
import 'package:template_string/template_string.dart';

final localizedLabels = <Locale, Example>{
  Locale.fromSubtags(languageCode: 'fr'): const Example(
    multiline: 'C\'est\n\nune\n\nexemple multiligne.',
    plurals: const ExamplePlurals(
      manMultiple: 'hommes',
      manOne: 'homme',
      manZero: 'hommes',
    ),
    templated: const ExampleTemplated(
      pattern: 'Aujourd\'hui : {{date:DateTime[EEE, M/d/y]}}',
      simple: 'Aujourd\'hui : {{date:DateTime}}',
      formatted: 'Le prix est de {{price:double[compactCurrency]}}',
      count: 'Il y a {{count:int}} éléments.',
      contactFemale: 'Mme {{last_name}}',
      contactMale: 'M. {{last_name}}',
      hello: 'Bonjour {{first_name}}!',
      date: const ExampleTemplatedDate(
        pattern: 'Aujourd\'hui : {{date:DateTime[EEE, M/d/y]}}',
        simple: 'Aujourd\'hui : {{date:DateTime}}',
      ),
      numbers: const ExampleTemplatedNumbers(
        formatted: 'Le prix est de {{price:double[compactCurrency]}}',
        simple: 'Le prix est de {{price:double}}€',
        count: 'Il y a {{count:int}} éléments.',
      ),
    ),
    dates: const ExampleDates(
      april: 'avril',
      march: 'février',
      february: 'février',
      january: 'janvier',
      sunday: 'dimanche',
      saturday: 'samedi',
      friday: 'Vendredi',
      thursday: 'jeudi',
      wednesday: 'Mercredi',
      tuesday: 'Mardi',
      monday: 'LUNDI',
      month: const ExampleDatesMonth(
        april: 'avril',
        march: 'février',
        february: 'février',
        january: 'janvier',
      ),
      weekday: const ExampleDatesWeekday(
        sunday: 'dimanche',
        saturday: 'samedi',
        friday: 'Vendredi',
        thursday: 'jeudi',
        wednesday: 'Mercredi',
        tuesday: 'Mardi',
        monday: 'LUNDI',
      ),
    ),
  ),
  Locale.fromSubtags(languageCode: 'en'): const Example(
    multiline: 'This is\n\na\n\nmultiline example.',
    plurals: const ExamplePlurals(
      manMultiple: 'men',
      manOne: 'man',
      manZero: 'man',
    ),
    templated: const ExampleTemplated(
      pattern: 'Today : {{date:DateTime[EEE, M/d/y]}}',
      simple: 'Today : {{date:DateTime}}',
      formatted: 'The price is {{price:double[compactCurrency]}}',
      count: 'There are {{count:int}}\ items.',
      contactFemale: 'Mrs {{last_name}}!',
      contactMale: 'Mr {{last_name}}!',
      hello: 'Hello {{first_name}}!',
      date: const ExampleTemplatedDate(
        pattern: 'Today : {{date:DateTime[EEE, M/d/y]}}',
        simple: 'Today : {{date:DateTime}}',
      ),
      numbers: const ExampleTemplatedNumbers(
        formatted: 'The price is {{price:double[compactCurrency]}}',
        simple: 'The price is {{price:double}}\$',
        count: 'There are {{count:int}}\ items.',
      ),
    ),
    dates: const ExampleDates(
      april: 'april',
      march: 'march',
      february: 'february',
      january: 'january',
      sunday: 'sunday',
      saturday: 'saturday',
      friday: 'friday',
      thursday: 'thursday',
      wednesday: 'wednesday',
      tuesday: 'tuesday',
      monday: 'MONDAY',
      month: const ExampleDatesMonth(
        april: 'april',
        march: 'march',
        february: 'february',
        january: 'january',
      ),
      weekday: const ExampleDatesWeekday(
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
      const Example(
    multiline: '这是\n\n一种\n\n多例子。',
    plurals: const ExamplePlurals(
      manMultiple: '男人',
      manOne: '男人',
      manZero: '男人',
    ),
    templated: const ExampleTemplated(
      pattern: '今日 : {{date:DateTime[EEE, M/d/y]}}',
      simple: '今日 : {{date:DateTime}}',
      formatted: '価格は{{price:double[compactCurrency]}}です',
      count: '{{count:int}}個のアイテムがあります',
      contactFemale: '夫人{{last_name}}',
      contactMale: '先生{{last_name}}',
      hello: '你好{{first_name}}!',
      date: const ExampleTemplatedDate(
        pattern: '今日 : {{date:DateTime[EEE, M/d/y]}}',
        simple: '今日 : {{date:DateTime}}',
      ),
      numbers: const ExampleTemplatedNumbers(
        formatted: '価格は{{price:double[compactCurrency]}}です',
        simple: '価格は{{price:double}}¥です',
        count: '{{count:int}}個のアイテムがあります',
      ),
    ),
    dates: const ExampleDates(
      april: '四月',
      march: '游行',
      february: '二月',
      january: '一月',
      sunday: '星期日',
      saturday: '星期六',
      friday: '星期五',
      thursday: '星期四',
      wednesday: '星期三',
      tuesday: '星期二',
      monday: '星期一',
      month: const ExampleDatesMonth(
        april: '四月',
        march: '游行',
        february: '二月',
        january: '一月',
      ),
      weekday: const ExampleDatesWeekday(
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

class Example {
  const Example({
    required this.plurals,
    required this.templated,
    required this.dates,
    required this.multiline,
  });

  final ExamplePlurals plurals;
  final ExampleTemplated templated;
  final ExampleDates dates;
  final String multiline;
  factory Example.fromJson(Map<String, Object?> map) => Example(
        plurals:
            ExamplePlurals.fromJson(map['plurals']! as Map<String, Object?>),
        templated: ExampleTemplated.fromJson(
            map['templated']! as Map<String, Object?>),
        dates: ExampleDates.fromJson(map['dates']! as Map<String, Object?>),
        multiline: map['multiline']! as String,
      );

  Example copyWith({
    ExamplePlurals? plurals,
    ExampleTemplated? templated,
    ExampleDates? dates,
    String? multiline,
  }) =>
      Example(
        plurals: plurals ?? this.plurals,
        templated: templated ?? this.templated,
        dates: dates ?? this.dates,
        multiline: multiline ?? this.multiline,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Example &&
          plurals == other.plurals &&
          templated == other.templated &&
          dates == other.dates &&
          multiline == other.multiline);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      plurals.hashCode ^
      templated.hashCode ^
      dates.hashCode ^
      multiline.hashCode;
}

class ExamplePlurals {
  const ExamplePlurals({
    required String manMultiple,
    required String manOne,
    required String manZero,
  })   : _manMultiple = manMultiple,
        _manOne = manOne,
        _manZero = manZero;

  final String _manMultiple;
  final String _manOne;
  final String _manZero;

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

  factory ExamplePlurals.fromJson(Map<String, Object?> map) => ExamplePlurals(
        manMultiple: map['manMultiple']! as String,
        manOne: map['manOne']! as String,
        manZero: map['manZero']! as String,
      );

  ExamplePlurals copyWith({
    String? manMultiple,
    String? manOne,
    String? manZero,
  }) =>
      ExamplePlurals(
        manMultiple: manMultiple ?? _manMultiple,
        manOne: manOne ?? _manOne,
        manZero: manZero ?? _manZero,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamplePlurals &&
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

class ExampleTemplated {
  const ExampleTemplated({
    required this.date,
    required this.numbers,
    required String pattern,
    required String simple,
    required String formatted,
    required String count,
    required String contactFemale,
    required String contactMale,
    required String hello,
  })   : _pattern = pattern,
        _simple = simple,
        _formatted = formatted,
        _count = count,
        _contactFemale = contactFemale,
        _contactMale = contactMale,
        _hello = hello;

  final ExampleTemplatedDate date;
  final ExampleTemplatedNumbers numbers;
  final String _pattern;
  final String _simple;
  final String _formatted;
  final String _count;
  final String _contactFemale;
  final String _contactMale;
  final String _hello;

  String pattern({
    required DateTime date,
    String? locale,
  }) {
    return _pattern.insertTemplateValues(
      {'date': date},
      locale: locale,
    );
  }

  String simple({
    required DateTime date,
    String? locale,
  }) {
    return _simple.insertTemplateValues(
      {'date': date},
      locale: locale,
    );
  }

  String formatted({
    required double price,
    String? locale,
  }) {
    return _formatted.insertTemplateValues(
      {'price': price},
      locale: locale,
    );
  }

  String count({
    required int count,
    String? locale,
  }) {
    return _count.insertTemplateValues(
      {'count': count},
      locale: locale,
    );
  }

  String contact({
    required Gender gender,
    required String lastName,
    String? locale,
  }) {
    if (gender == Gender.female) {
      return _contactFemale.insertTemplateValues(
        {'last_name': lastName},
        locale: locale,
      );
    }
    if (gender == Gender.male) {
      return _contactMale.insertTemplateValues(
        {'last_name': lastName},
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
      {'first_name': firstName},
      locale: locale,
    );
  }

  factory ExampleTemplated.fromJson(Map<String, Object?> map) =>
      ExampleTemplated(
        date:
            ExampleTemplatedDate.fromJson(map['date']! as Map<String, Object?>),
        numbers: ExampleTemplatedNumbers.fromJson(
            map['numbers']! as Map<String, Object?>),
        pattern: map['pattern']! as String,
        simple: map['simple']! as String,
        formatted: map['formatted']! as String,
        count: map['count']! as String,
        contactFemale: map['contactFemale']! as String,
        contactMale: map['contactMale']! as String,
        hello: map['hello']! as String,
      );

  ExampleTemplated copyWith({
    ExampleTemplatedDate? date,
    ExampleTemplatedNumbers? numbers,
    String? pattern,
    String? simple,
    String? formatted,
    String? count,
    String? contactFemale,
    String? contactMale,
    String? hello,
  }) =>
      ExampleTemplated(
        date: date ?? this.date,
        numbers: numbers ?? this.numbers,
        pattern: pattern ?? _pattern,
        simple: simple ?? _simple,
        formatted: formatted ?? _formatted,
        count: count ?? _count,
        contactFemale: contactFemale ?? _contactFemale,
        contactMale: contactMale ?? _contactMale,
        hello: hello ?? _hello,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleTemplated &&
          date == other.date &&
          numbers == other.numbers &&
          _pattern == other._pattern &&
          _simple == other._simple &&
          _formatted == other._formatted &&
          _count == other._count &&
          _contactFemale == other._contactFemale &&
          _contactMale == other._contactMale &&
          _hello == other._hello);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      date.hashCode ^
      numbers.hashCode ^
      _pattern.hashCode ^
      _simple.hashCode ^
      _formatted.hashCode ^
      _count.hashCode ^
      _contactFemale.hashCode ^
      _contactMale.hashCode ^
      _hello.hashCode;
}

class ExampleTemplatedDate {
  const ExampleTemplatedDate({
    required String pattern,
    required String simple,
  })   : _pattern = pattern,
        _simple = simple;

  final String _pattern;
  final String _simple;

  String pattern({
    required DateTime date,
    String? locale,
  }) {
    return _pattern.insertTemplateValues(
      {'date': date},
      locale: locale,
    );
  }

  String simple({
    required DateTime date,
    String? locale,
  }) {
    return _simple.insertTemplateValues(
      {'date': date},
      locale: locale,
    );
  }

  factory ExampleTemplatedDate.fromJson(Map<String, Object?> map) =>
      ExampleTemplatedDate(
        pattern: map['pattern']! as String,
        simple: map['simple']! as String,
      );

  ExampleTemplatedDate copyWith({
    String? pattern,
    String? simple,
  }) =>
      ExampleTemplatedDate(
        pattern: pattern ?? _pattern,
        simple: simple ?? _simple,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleTemplatedDate &&
          _pattern == other._pattern &&
          _simple == other._simple);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ _pattern.hashCode ^ _simple.hashCode;
}

class ExampleTemplatedNumbers {
  const ExampleTemplatedNumbers({
    required String formatted,
    required String simple,
    required String count,
  })   : _formatted = formatted,
        _simple = simple,
        _count = count;

  final String _formatted;
  final String _simple;
  final String _count;

  String formatted({
    required double price,
    String? locale,
  }) {
    return _formatted.insertTemplateValues(
      {'price': price},
      locale: locale,
    );
  }

  String simple({
    required double price,
    String? locale,
  }) {
    return _simple.insertTemplateValues(
      {'price': price},
      locale: locale,
    );
  }

  String count({
    required int count,
    String? locale,
  }) {
    return _count.insertTemplateValues(
      {'count': count},
      locale: locale,
    );
  }

  factory ExampleTemplatedNumbers.fromJson(Map<String, Object?> map) =>
      ExampleTemplatedNumbers(
        formatted: map['formatted']! as String,
        simple: map['simple']! as String,
        count: map['count']! as String,
      );

  ExampleTemplatedNumbers copyWith({
    String? formatted,
    String? simple,
    String? count,
  }) =>
      ExampleTemplatedNumbers(
        formatted: formatted ?? _formatted,
        simple: simple ?? _simple,
        count: count ?? _count,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleTemplatedNumbers &&
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

class ExampleDates {
  const ExampleDates({
    required this.month,
    required this.weekday,
    required this.april,
    required this.march,
    required this.february,
    required this.january,
    required this.sunday,
    required this.saturday,
    required this.friday,
    required this.thursday,
    required this.wednesday,
    required this.tuesday,
    required this.monday,
  });

  final ExampleDatesMonth month;
  final ExampleDatesWeekday weekday;
  final String april;
  final String march;
  final String february;
  final String january;
  final String sunday;
  final String saturday;
  final String friday;
  final String thursday;
  final String wednesday;
  final String tuesday;
  final String monday;
  factory ExampleDates.fromJson(Map<String, Object?> map) => ExampleDates(
        month:
            ExampleDatesMonth.fromJson(map['month']! as Map<String, Object?>),
        weekday: ExampleDatesWeekday.fromJson(
            map['weekday']! as Map<String, Object?>),
        april: map['april']! as String,
        march: map['march']! as String,
        february: map['february']! as String,
        january: map['january']! as String,
        sunday: map['sunday']! as String,
        saturday: map['saturday']! as String,
        friday: map['friday']! as String,
        thursday: map['thursday']! as String,
        wednesday: map['wednesday']! as String,
        tuesday: map['tuesday']! as String,
        monday: map['monday']! as String,
      );

  ExampleDates copyWith({
    ExampleDatesMonth? month,
    ExampleDatesWeekday? weekday,
    String? april,
    String? march,
    String? february,
    String? january,
    String? sunday,
    String? saturday,
    String? friday,
    String? thursday,
    String? wednesday,
    String? tuesday,
    String? monday,
  }) =>
      ExampleDates(
        month: month ?? this.month,
        weekday: weekday ?? this.weekday,
        april: april ?? this.april,
        march: march ?? this.march,
        february: february ?? this.february,
        january: january ?? this.january,
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
      (other is ExampleDates &&
          month == other.month &&
          weekday == other.weekday &&
          april == other.april &&
          march == other.march &&
          february == other.february &&
          january == other.january &&
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
      month.hashCode ^
      weekday.hashCode ^
      april.hashCode ^
      march.hashCode ^
      february.hashCode ^
      january.hashCode ^
      sunday.hashCode ^
      saturday.hashCode ^
      friday.hashCode ^
      thursday.hashCode ^
      wednesday.hashCode ^
      tuesday.hashCode ^
      monday.hashCode;
}

class ExampleDatesMonth {
  const ExampleDatesMonth({
    required this.april,
    required this.march,
    required this.february,
    required this.january,
  });

  final String april;
  final String march;
  final String february;
  final String january;
  factory ExampleDatesMonth.fromJson(Map<String, Object?> map) =>
      ExampleDatesMonth(
        april: map['april']! as String,
        march: map['march']! as String,
        february: map['february']! as String,
        january: map['january']! as String,
      );

  ExampleDatesMonth copyWith({
    String? april,
    String? march,
    String? february,
    String? january,
  }) =>
      ExampleDatesMonth(
        april: april ?? this.april,
        march: march ?? this.march,
        february: february ?? this.february,
        january: january ?? this.january,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleDatesMonth &&
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

class ExampleDatesWeekday {
  const ExampleDatesWeekday({
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
  factory ExampleDatesWeekday.fromJson(Map<String, Object?> map) =>
      ExampleDatesWeekday(
        sunday: map['sunday']! as String,
        saturday: map['saturday']! as String,
        friday: map['friday']! as String,
        thursday: map['thursday']! as String,
        wednesday: map['wednesday']! as String,
        tuesday: map['tuesday']! as String,
        monday: map['monday']! as String,
      );

  ExampleDatesWeekday copyWith({
    String? sunday,
    String? saturday,
    String? friday,
    String? thursday,
    String? wednesday,
    String? tuesday,
    String? monday,
  }) =>
      ExampleDatesWeekday(
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
      (other is ExampleDatesWeekday &&
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
