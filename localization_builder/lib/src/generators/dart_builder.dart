import 'package:dart_style/dart_style.dart';
import 'package:localization_builder/src/definitions/category.dart';
import 'package:localization_builder/src/definitions/condition.dart';
import 'package:localization_builder/src/definitions/label.dart';
import 'package:localization_builder/src/definitions/localizations.dart';
import 'package:localization_builder/src/definitions/section.dart';
import 'package:localization_builder/src/definitions/translation.dart';
import 'package:localization_builder/src/generators/builders/base.dart';
import 'package:localization_builder/src/generators/builders/property.dart';

import 'builders/argument.dart';
import 'builders/data_class.dart';

class DartLocalizationBuilder {
  DartLocalizationBuilder({
    this.nullSafety = true,
    this.jsonParser = true,
  });

  StringBuffer _buffer = StringBuffer();
  final bool nullSafety;
  final bool jsonParser;

  String buildImports() {
    return '''
import 'dart:ui';
import 'package:template_string/template_string.dart';
    ''';
  }

  String build(Localizations localizations) {
    _buffer = StringBuffer();

    _createLocalization(
      [
        localizations.name,
      ],
      localizations,
    );
    localizations.categories.forEach((c) => _addCategoryDefinition(c));
    _addSectionDefinition(
      [
        localizations.name,
      ],
      localizations,
    );
    return DartFormatter().format(_buffer.toString());
  }

  void _createLocalization(List<String> path, Localizations localizations) {
    _buffer.writeln(
        'final localizedLabels = ${_createLanguageMap(path, localizations)};');
  }

  String _createLanguageMap(List<String> path, Localizations localizations) {
    final result = StringBuffer();

    result.write(' <Locale, ${_buildClassNameFromPath(path)}>{');

    for (var languageCode in localizations.supportedLanguageCodes) {
      final instance =
          _createSectionInstance(path, languageCode, localizations);

      final splits = languageCode.split(RegExp(r'[-_]'));

      var key = 'Locale.fromSubtags(languageCode: \'${splits.first}\'';
      if (splits.length > 2) {
        key += ', scriptCode: \'${splits[1]}\'';
        key += ', countryCode: \'${splits[2]}\'';
      } else if (splits.length > 1) {
        key += ', countryCode: \'${splits[1]}\'';
      }
      key += ')';
      result.write(key + ' : ' + instance + ',');
    }

    result.write('}');

    return result.toString();
  }

  String _createSectionInstance(
    List<String> path,
    String languageCode,
    Section section,
  ) {
    path = [
      ...path,
      section.normalizedKey,
    ];

    final result = StringBuffer();
    result.writeln('const ${_buildClassNameFromPath(path)}(');

    for (var label in section.labels) {
      for (var caze in label.cases) {
        if (caze.condition is CategoryCondition) {
          final condition = caze.condition as CategoryCondition;
          final fieldName =
              '${label.normalizedKey}${createClassdName(condition.value)}';
          result.write(fieldName);
        } else {
          final fieldName = '${label.normalizedKey}';
          result.write(fieldName);
        }
        final translation = caze.translations.firstWhere(
          (x) => x.languageCode == languageCode,
          orElse: () => Translation(languageCode, '?'),
        );
        result.write(':');
        result.write('\'${_escapeString(translation.value)}\',');
      }
    }

    for (var child in section.children) {
      result.write(child.normalizedKey);
      result.write(':');
      result.write(_createSectionInstance(
        path,
        languageCode,
        child,
      ));
      result.write(',');
    }

    result.writeln(')');

    return result.toString();
  }

  void _addCategoryDefinition(Category category) {
    final values = category.values.map((x) => x + ',').join();
    _buffer.writeln('enum ${category.normalizedName} { $values }');
  }

  String _getByKeyBody(List<Label> labels) {
    final results = StringBuffer('{\n');
    results.write('switch (key) {');
    for (var label in labels) {
      if (label.templatedValues.isEmpty &&
          label.cases.length == 1 &&
          label.cases.first.condition is DefaultCondition) {
        results.write("case '");
        results.write(label.normalizedKey);
        results.write("'");
        results.write(':');
        results.write('return ');
        results.write(label.normalizedKey);
        results.write(';\n');
      }
    }
    results.write("default: return '';");
    results.write('}');
    results.write('}');
    return results.toString();
  }

  void _addSectionDefinition(List<String> path, Section section) {
    path = [
      ...path,
      section.normalizedKey,
    ];

    final result = DataClassBuilder(
      _buildClassNameFromPath(path),
      isConst: true,
    );

    result.addMethod(
      returnType: 'String',
      name: 'getByKey',
      body: _getByKeyBody(section.labels),
      arguments: <ArgumentBuilder>[
        ArgumentBuilder(
          name: 'key',
          type: 'String',
        ),
      ],
    );

    for (var label in section.labels) {
      if (label.templatedValues.isEmpty &&
          label.cases.length == 1 &&
          label.cases.first.condition is DefaultCondition) {
        result.addProperty('String', label.normalizedKey);
      } else {
        final methodArguments = <ArgumentBuilder>[];

        /// Adding an argument for each category
        final categoryCases =
            label.cases.where((x) => x.condition is CategoryCondition);
        for (var categoryCase in categoryCases) {
          final condition = categoryCase.condition as CategoryCondition;
          final fieldName =
              '_${label.normalizedKey}${createClassdName(condition.value)}';
          result.addProperty('String', fieldName);
        }

        /// Adding an argument for each category
        final categories = categoryCases
            .map((e) => e.condition)
            .cast<CategoryCondition>()
            .map((x) => x.name)
            .toSet();
        for (var categoryName in categories) {
          final categoryClassName = createClassdName(categoryName);
          methodArguments.add(
            ArgumentBuilder(
              name: createFieldName(categoryName),
              type: categoryClassName,
            ),
          );
        }

        /// Default value
        final defaultCase =
            label.cases.map((x) => x.condition).whereType<DefaultCondition>();

        if (defaultCase.isNotEmpty) {
          result.addProperty('String', '_${label.normalizedKey}');
        }

        /// Adding an argument for each templated value
        for (var templatedValue in label.templatedValues) {
          methodArguments.add(
            ArgumentBuilder(
              name: createFieldName(templatedValue.key),
              type: templatedValue.type,
            ),
          );
        }
        if (label.templatedValues.isNotEmpty) {
          methodArguments.add(
            ArgumentBuilder(
              name: 'locale',
              type: 'String?',
              isRequired: false,
            ),
          );
        }

        /// Creating method body
        final body = StringBuffer('{\n');

        for (var c
            in label.cases.where((x) => x.condition is CategoryCondition)) {
          final condition = c.condition as CategoryCondition;
          final categoryField = createFieldName(condition.name);
          final categoryClassName = createClassdName(condition.name);
          final categoryValue =
              '$categoryClassName.${createFieldName(condition.value)}';
          body.writeln('if($categoryField == $categoryValue) { ');

          body.write(
              'return _${label.normalizedKey}${createClassdName(condition.value)}');
          if (label.templatedValues.isNotEmpty) {
            body.write('.insertTemplateValues({');
            for (var templatedValue in label.templatedValues) {
              body.write(
                  '\'${templatedValue.key}\' : ${createFieldName(templatedValue.key)},');
            }
            body.write('}, locale : locale,)');
          }
          body.writeln(';');

          body.writeln('}');
        }

        if (defaultCase.isNotEmpty) {
          body.write('return _${label.normalizedKey}');
          if (label.templatedValues.isNotEmpty) {
            body.write('.insertTemplateValues({');
            for (var templatedValue in label.templatedValues) {
              body.write(
                  '\'${templatedValue.key}\' : ${createFieldName(templatedValue.key)},');
            }
            body.write('}, locale: locale,)');
          }
          body.writeln(';');
        } else {
          body.write('throw Exception();');
        }

        body.writeln('}');

        result.addMethod(
          returnType: 'String',
          name: label.normalizedKey,
          body: body.toString(),
          arguments: methodArguments,
        );
      }
    }

    for (var child in section.children) {
      final childPath = [
        ...path,
        child.normalizedKey,
      ];
      result.addProperty(
        _buildClassNameFromPath(childPath),
        createFieldName(child.key),
        jsonConverter: fromJsonPropertyBuilderJsonConverter,
      );
    }

    _buffer.writeln(
      result.build(
        nullSafety: nullSafety,
        jsonParser: jsonParser,
      ),
    );

    for (var child in section.children) {
      _addSectionDefinition(path, child);
    }
  }
}

String _buildClassNameFromPath(List<String> path) {
  return path.map((name) => createClassdName(name)).join();
}

String _escapeString(String value) => value
    .replaceAll('\n', '\\n')
    .replaceAll('\'', '\\\'')
    .replaceAll('\$', '\\\$');
