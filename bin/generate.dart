import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:flutter_csv_localization/flutter_csv_localization.dart';

void main(List<String> args) async {
  final parser = new ArgParser();
  parser.addOption('output', abbr: 'o');

  final results = parser.parse(args);

  final input =
      results.rest.length > 0 ? results.rest.first : "localizations.csv";
  final output = results["output"] ?? "localizations.g.dart";

  await _generate(input, output);
}

Future _generate(String input, String output) async {
  final inputFile = File(input);
  if (!await inputFile.exists()) throw Exception("input file doesn't exist");

  final outputFile = File(output);
  final parser = CsvParser();
  final localizations = await parser.parse(inputFile.openRead());
  final builder = DartBuilder();
  final code = builder.build(localizations);
  await outputFile.writeAsString(code);
}
