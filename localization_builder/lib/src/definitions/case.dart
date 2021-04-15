import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:localization_builder/src/definitions/translation.dart';
import 'package:logging/logging.dart';
import 'package:template_string/template_string.dart';

import 'condition.dart';

/// Case represents a specific case for a label can respect a [condition], with
/// a set of associated [translations].
///
/// The condition is generally a [Category] value.
class Case extends Equatable {
  /// Creates a new case.
  const Case({
    required this.condition,
    required this.translations,
  });

  factory Case.merge(Case value, Case other) {
    assert(value.condition == other.condition,
        'Two merge cases should have the same condition');

    final result = Case(
      condition: value.condition,
      translations: [
        ...value.translations,
        ...other.translations.where((o) =>
            !value.translations.any((v) => v.languageCode == o.languageCode))
      ],
    );

    Logger.root.finer(
        '[{CASE} Merging]:\n\n\tITEM1===================================\n$value\n\n\tITEM2===================================\n$other\n\n\tRESULT===================================:\n$result\n\n');

    return result;
  }

  /// The condition of this particular case.
  final Condition condition;

  /// The set of translations.
  final List<Translation> translations;

  /// The templated values that all [translations] contain.
  List<StringTemplate> get templatedValues {
    assert(assertTranslationsValid(translations));
    return translations.isEmpty
        ? const <StringTemplate>[]
        : translations.first.templatedValues;
  }

  @override
  List<Object> get props => [
        condition,
        translations,
        templatedValues,
      ];

  /// Verifies that all translation have the same templated values (if so).
  static bool assertTranslationsValid(List<Translation> translations) {
    if (translations.length > 1) {
      final templatedValues = translations.first.templatedValues;
      for (var i = 1; i < translations.length; i++) {
        final current = translations[i];
        if (!const SetEquality()
            .equals(templatedValues.toSet(), current.templatedValues.toSet())) {
          return false;
        }
      }
    }

    return true;
  }
}
