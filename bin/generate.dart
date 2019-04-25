import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:args/args.dart';
import 'package:flutter_csv_localization/flutter_csv_localization.dart';

void main(List<String> args) async {
  final parser = new ArgParser();
  parser.addOption('output', abbr: 'o');
  parser.addOption('encoding', abbr: 'e');
  parser.addFlag('google', abbr: 'g');

  final results = parser.parse(args);

  final google = results["google"];
  final input = results.rest.length > 0 ? results.rest.first : null;
  final output = results["output"] ?? "localizations.g.dart";
  final encoding = results["encoding"] ?? "utf8";
  if (google) {
    await _generateGoogleSheet(input, output, encoding);
  } else {
    await _generateLocalFile(input, output, encoding);
  }
}

Future _generateGoogleSheet(String slug, String output, String encoding) async {
  final parts = slug.split("/");
  if (parts.length != 2)
    throw Exception(
        "input google sheet id must be in the form '{document_uid}/{sheet_name}'");
  final documentId = parts[0];
  final sheetName = parts[1];
  
  final url =
      "https://docs.google.com/spreadsheets/d/$documentId/export?format=csv&id=$documentId&gid=$sheetName";

  print('Downloading csv from Google sheet url "$url" ...');

  var response =
      await http.get(url, headers: {"accept": "text/csv;charset=UTF-8"});

  print('Google sheet csv:');
  print(response.body);
  print('');

  final bytes = response.bodyBytes.toList();
  final csv = Stream<List<int>>.fromIterable([bytes]);
  await _generate(csv, output, encoding);
}

Future _generateLocalFile(String file, String output, String encoding) async {
  final inputFile = File(file ?? "localizations.csv");
  print('Reading file "$inputFile" ...');
  if (!await inputFile.exists()) throw Exception("input file doesn't exist");
  await _generate(inputFile.openRead(), output, encoding);
}

Future _generate(Stream<List<int>> csv, String output, String encoding) async {
  final outputFile = File(output);
  print('Parsing csv with "$encoding" encoding');
  final parser = CsvParser(decoder: _getDecoder(encoding));
  final localizations = await parser.parse(csv);
  final builder = DartBuilder();
  final code = builder.build(localizations);
  await outputFile.writeAsString(code);
}

StreamTransformer<List<int>, String> _getDecoder(String encoding) {
  switch (encoding) {
    case "ascii":
      return ascii.decoder;
    case "latin1":
      return latin1.decoder;
    default:
      return utf8.decoder;
  }
}
