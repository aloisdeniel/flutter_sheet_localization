import 'dart:convert';
import 'dart:io';

import 'package:localization_builder/localization_builder.dart';
import 'package:logging/logging.dart';
import 'package:yaml/yaml.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  final builder = DartLocalizationBuilder();

  // YAML
  final parser = YamlLocalizationParser();
  final yaml = await File('example.yaml').readAsString();
  final node = loadYaml(yaml);
  final result = parser.parse(
    input: node,
    name: 'Test',
  );
  final dart = builder.buildImports() +
      '\n' +
      builder.build(
        result.result.copyWith(name: 'Example'),
      );
  await File('bin/result_yaml/labels.g.dart').writeAsString(dart);

  /// CSV
  var localizations = await _downloadGoogleSheet(
    '1AcjI1BjmQpjlnPUZ7aVLbrnVR98xtATnSjU4CExM9fs',
    '0',
    'Example',
  );
  final csvDart = builder.buildImports() +
      '\n' +
      builder.build(
        localizations,
      );
  await File('bin/result_csv/labels.g.dart').writeAsString(csvDart);
}

Future<Localizations> _downloadGoogleSheet(
    String documentId, String sheetId, String name) async {
  final url =
      'https://docs.google.com/spreadsheets/d/$documentId/export?format=csv&id=$documentId&gid=$sheetId';

  print('Downloading csv from Google sheet url "$url" ...');

  var response = await http
      .get(Uri.parse(url), headers: {'accept': 'text/csv;charset=UTF-8'});

  print('Google sheet csv:\n ${response.body}');

  final bytes = response.bodyBytes.toList();
  final csv = Stream<List<int>>.fromIterable([bytes]);
  final rows = await csv
      .transform(utf8.decoder)
      .transform(CsvToListConverter(
        shouldParseNumbers: false,
      ))
      .toList();
  final parser = CsvLocalizationParser();
  final result = parser.parse(input: rows, name: name);
  return result.result;
}
