import 'package:intl/intl.dart';

abstract class StringTemplateFormatters {
  static List<StringTemplateFormatter> all = <StringTemplateFormatter>[
    const NumFormatter(),
    const DateTimeFormatter(),
    const BoolFormatter(),
    const StringFormatter(),
  ];

  static String format(
      String type, Object value, String? format, String? locale) {
    type = type.toLowerCase();
    final formatter = all.firstWhere(
      (x) => x.type.any((t) => t == type),
      orElse: () => const StringFormatter(),
    );
    return formatter.format(value, format, locale);
  }
}

abstract class StringTemplateFormatter {
  const StringTemplateFormatter(this.type);
  final List<String> type;
  String format(Object value, String? format, String? locale);
}

class NumFormatter extends StringTemplateFormatter {
  const NumFormatter() : super(const <String>['int', 'double', 'num']);

  @override
  String format(Object value, String? format, String? locale) {
    assert(value is num);
    final number = value as num;
    switch (format) {
      case 'scientificPattern':
        return NumberFormat.scientificPattern(locale.toString()).format(number);
      case 'percentPattern':
        return NumberFormat.percentPattern(locale.toString()).format(number);
      case 'decimalPercentPattern':
        return NumberFormat.decimalPattern(locale.toString()).format(number);
      case 'compact':
        return NumberFormat.compact(locale: locale.toString()).format(number);
      default:
        return NumberFormat(format, locale.toString()).format(number);
    }
  }
}

class BoolFormatter extends StringTemplateFormatter {
  const BoolFormatter() : super(const <String>['bool', 'boolean']);

  @override
  String format(Object value, String? format, String? locale) {
    assert(value is bool);
    final number = value as bool;
    if (format != null) {
      final splits = format.split(',');
      return number ? splits[0] : (splits.length > 1 ? splits[1] : '');
    }

    return number ? 'true' : 'false';
  }
}

class DateTimeFormatter extends StringTemplateFormatter {
  const DateTimeFormatter() : super(const <String>['datetime']);

  @override
  String format(Object value, String? format, String? locale) {
    assert(value is DateTime);
    final date = value as DateTime;
    if (format != null) {
      return DateFormat(format, locale).format(date);
    }
    return date.toIso8601String();
  }
}

class StringFormatter extends StringTemplateFormatter {
  const StringFormatter() : super(const <String>['string']);

  @override
  String format(Object value, String? format, String? locale) {
    final s = value.toString();

    switch (s) {
      case 'lowercase':
        return s.toLowerCase();
      case 'uppercase':
        return s.toUpperCase();
      default:
        return s;
    }
  }
}
