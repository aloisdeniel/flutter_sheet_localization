import 'package:localization_builder/src/definitions/localizations.dart';
import 'package:localization_builder/src/definitions/section.dart';
import 'package:localization_builder/src/definitions/translation.dart';

import '../parser.dart';
import '../result.dart';
import 'token.dart';

class CsvLocalizationParser
    extends LocalizationParser<Iterable<List>, CsvLocalizationToken> {
  const CsvLocalizationParser();

  static const conditionKey = 'condition';
  static const keyKey = 'key';
  static const reservedIndexKeys = [
    conditionKey,
    keyKey,
  ];

  String _uniformizeKey(String key) {
    key = key.trim();
    final lowercase = key.toLowerCase();
    if (reservedIndexKeys.contains(lowercase)) {
      return lowercase;
    }
    return key;
  }

  bool _isReservedKey(String key) => reservedIndexKeys.contains(key);

  bool _isLanguageKey(String key) =>
      !_isReservedKey(key) &&
      !(key.trim().startsWith('(') && key.trim().endsWith(')'));

  @override
  ParsingResult<Iterable<List>, CsvLocalizationToken> parse({
    required Iterable<List> input,
    required String name,
  }) {
    final fields = input.toList();

    final index = fields[0]
        .cast<String>()
        .map(_uniformizeKey)
        .takeWhile((x) => x.isNotEmpty)
        .toList();

    // Getting language codes
    final supportedLanguageCodes = index.where(_isLanguageKey).toList();

    var section = Section(
      key: '',
      children: [],
      labels: [],
    );

    final tokens = const <CsvLocalizationToken>[];

    // Parsing entries
    for (var r = 1; r < fields.length; r++) {
      final rowValues = fields[r];

      /// Creating a map
      final row = Map<String, String>.fromEntries(
        rowValues
            .asMap()
            .entries
            .where(
              (e) => e.key < index.length,
            )
            .map(
              (e) => MapEntry(index[e.key], e.value),
            ),
      );
      final key = row[keyKey];
      var condition = row[conditionKey];
      if (key != null && key.isNotEmpty) {
        var path = key.trim();
        if (path.isNotEmpty) {
          final translations = row.entries
              .where((e) => _isLanguageKey(e.key))
              .map((e) => Translation(e.key, e.value))
              .toList();

          // We can also have a condition at the end of the key in parenthesis
          final startCondition = path.indexOf('(');
          final endCondition = path.indexOf(')');
          if (startCondition >= 0 && endCondition >= 0) {
            condition = path.substring(startCondition + 1, endCondition);
            path = path.substring(0, startCondition);
          }
          section = section.withTranslations(path, condition, translations);
        }
      }
    }

    return ParsingResult(
      input: input,
      result: Localizations.fromSection(
        name: name,
        supportedLanguageCodes: supportedLanguageCodes,
        section: section,
      ),
      tokens: tokens,
    );
  }
}
