import 'dart:async';
import 'dart:convert';
import 'package:csv/csv.dart';

import 'localizations.dart';

class CsvParser {
  final StreamTransformer<List<int>, String> decoder;

  CsvParser({StreamTransformer<List<int>, String> decoder})
      : decoder = decoder ?? utf8.decoder;

  static const conditionKey = 'condition';
  static const keyKey = 'key';
  static const reservedIndexKeys = [
    conditionKey,
    keyKey,
  ];

  String _uniformizeKey(String key) {
    key = key.trim().replaceAll('\n', '');
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

  Future<Localizations> parse(Stream<List<int>> input) async {
    final fields = await input
        .transform(decoder)
        .transform(CsvToListConverter(
          shouldParseNumbers: false,
        ))
        .toList();

    final index = fields[0]
        .cast<String>()
        .map(_uniformizeKey)
        .takeWhile((x) => x != null && x.isNotEmpty)
        .toList();

    // Getting language codes
    final result = Localizations(
      supportedLanguageCodes: index.where(_isLanguageKey).toList(),
    );

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

          result.insert(path, condition, translations);
        }
      }
    }

    return result;
  }
}
