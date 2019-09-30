import 'dart:async';
import 'dart:convert';
import 'package:csv/csv.dart';

import 'localizations.dart';

class CsvParser {
  final StreamTransformer<List<int>, String> decoder;

  CsvParser({StreamTransformer<List<int>, String> decoder})
      : this.decoder = decoder ?? utf8.decoder;

  Future<Localizations> parse(Stream<List<int>> input) async {
    final fields = await input
        .transform(decoder)
        .transform(CsvToListConverter(
          shouldParseNumbers: false,
        ))
        .toList();

    final index = fields[0];

    final result = Localizations(
        supportedLanguageCodes: index
            .skip(1)
            .cast<String>()
            .map((x) => x.trimRight().replaceAll("\n", ""))
            .takeWhile((x) => x != null && x.isNotEmpty)
            .toList());

    for (var i = 1; i < fields.length; i++) {
      final row = fields[i];
      if (row.length > 1) {
        final path = row[0].toString().trim();
        if (path.length > 0) {
          final translations = row
              .asMap()
              .entries
              .skip(1)
              .take(result.supportedLanguageCodes.length)
              .map((e) => Translation(index[e.key], e.value))
              .toList();
          result.insert(path, translations);
        }
      }
    }

    return result;
  }
}
