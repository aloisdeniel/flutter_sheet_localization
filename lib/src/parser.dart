import 'dart:convert';
import 'package:csv/csv.dart';

import 'localizations.dart';

class CsvParser {

  Future<Localizations> parse(Stream<List<int>> input) async {

      final fields = await input.transform(utf8.decoder).transform(CsvToListConverter(
        shouldParseNumbers: false,
        eol: "\n",
      )).toList();

      final index = fields[0];

      final result = Localizations(supportedLanguageCodes: index.skip(1).cast<String>().toList());

      for (var i = 1; i < fields.length; i++) {
        final row = fields[i];
        if(row.length > 1) {
          final path = row[0].toString().trim();
          if(path.length > 0) {
            final translations = row.asMap().entries.skip(1).map((e) => Translation(index[e.key], e.value)).toList();
            result.insert(path, translations);
          }
        }
        
      }

      return result;
  }
}
