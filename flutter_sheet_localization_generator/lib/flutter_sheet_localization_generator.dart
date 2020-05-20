import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:http/http.dart' as http;

import 'src/builder.dart';
import 'src/localizations.dart';
import 'src/parser.dart';

class SheetLocalizationGenerator
    extends GeneratorForAnnotation<SheetLocalization> {
  const SheetLocalizationGenerator();

  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (element is! ClassElement) {
      final name = element.name;
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the SheetLocalization annotation from `$name`.',
          element: element);
    }

    if (!element.name.endsWith('Delegate')) {
      final name = element.name;
      throw InvalidGenerationSourceError(
          'Generator for target `$name` should have a name that ends with `Delegate`.',
          todo:
              'Refactor the class name `$name` for a name ending with `Delegate` (example: `${name}Delegate`).',
          element: element);
    }

    final classElement = element as ClassElement;

    final localizationDelegateSupertype = classElement.allSupertypes
        .firstWhere((x) => x.name == 'LocalizationsDelegate');
    if (localizationDelegateSupertype != null) {
      final docId = annotation.objectValue.getField('docId').toStringValue();
      final sheetId =
          annotation.objectValue.getField('sheetId').toStringValue();
      var localizations = await _downloadGoogleSheet(docId, sheetId);

      localizations = localizations.copyWith(
          name: classElement.name.replaceAll('Delegate', ''));

      final builder = DartBuilder();
      return builder.build(localizations);
    }
    throw InvalidGenerationSourceError(
        'Supertype aren\'t valid : [${classElement.allSupertypes.join(', ')}].',
        todo:
            'Define only one supertype of type LocalizationsDelegate<LOCALIZATION_CLASS_NAME>.',
        element: element);
  }

  Future<Localizations> _downloadGoogleSheet(
      String documentId, String sheetId) async {
    final url =
        'https://docs.google.com/spreadsheets/d/$documentId/export?format=csv&id=$documentId&gid=$sheetId';

    log.info('Downloading csv from Google sheet url "$url" ...');

    var response =
        await http.get(url, headers: {'accept': 'text/csv;charset=UTF-8'});

    log.fine('Google sheet csv:\n ${response.body}');

    final bytes = response.bodyBytes.toList();
    final csv = Stream<List<int>>.fromIterable([bytes]);

    final parser = CsvParser(decoder: utf8.decoder);
    return await parser.parse(csv);
  }
}
