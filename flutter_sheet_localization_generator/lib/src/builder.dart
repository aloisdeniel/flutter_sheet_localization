import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

import 'localizations.dart';

class DartBuilder {
  LibraryBuilder _library;

  String build(Localizations localizations) {
    _library = LibraryBuilder();

    _library.body.add(Code('// ignore_for_file: camel_case_types\n\n'));
    _library.body.add(_createLocalization(localizations));
    localizations.categories.forEach((c) => _addCategoryDefinition(c));
    _addSectionDefinition(localizations);

    // Code generation
    final emitter = DartEmitter();
    final source = '${_library.build().accept(emitter)}';
    return DartFormatter().format(source);
  }

  Class _createLocalization(Localizations localizations) {
    final result = ClassBuilder()..name = localizations.name;

    var constructor = ConstructorBuilder();

    result.fields.add(
      Field(
        (b) => b
          ..name = 'locale'
          ..modifier = FieldModifier.final$
          ..type = refer('Locale'),
      ),
    );

    constructor.requiredParameters.add(
      Parameter(
        (p) => p
          ..name = 'locale'
          ..toThis = true,
      ),
    );

    constructor.initializers.add(
      Code('labels = languages[locale]'),
    );

    result.fields.add(
      Field(
        (b) => b
          ..name = 'languages'
          ..static = true
          ..assignment = _createLanguageMap(localizations)
          ..modifier = FieldModifier.final$
          ..type = refer(
            'Map<Locale,' + localizations.normalizedName + '>',
          ),
      ),
    );

    result.fields.add(
      Field(
        (b) => b
          ..name = 'labels'
          ..modifier = FieldModifier.final$
          ..type = refer(localizations.normalizedName),
      ),
    );

    result.methods.add(
      Method(
        (b) => b
          ..name = 'of'
          ..lambda = true
          ..static = true
          ..returns = refer(localizations.normalizedName)
          ..body = Code(
            'Localizations.of<${localizations.name}>(context, ${localizations.name})?.labels',
          )
          ..requiredParameters.add(
            Parameter(
              (b) => b
                ..name = 'context'
                ..type = refer('BuildContext'),
            ),
          ),
      ),
    );

    result.constructors.add(constructor.build());

    return result.build();
  }

  Code _createLanguageMap(Localizations localizations) {
    final result = StringBuffer();

    result.write('{');

    for (var languageCode in localizations.supportedLanguageCodes) {
      final code = _createSectionInstance(languageCode, localizations);

      final splits = languageCode.split('-');

      var key = 'Locale.fromSubtags(languageCode: \'${splits.first}\'';
      if (splits.length > 2) {
        key += ', scriptCode: \'${splits[1]}\'';
        key += ', countryCode: \'${splits[2]}\'';
      } else if (splits.length > 1) {
        key += ', countryCode: \'${splits[1]}\'';
      }
      key += ')';
      result.write(key + ' : ' + code + ',');
    }

    result.write('}');

    return Code(result.toString());
  }

  String _createSectionInstance(String languageCode, Section section) {
    final result = StringBuffer();

    final templatedString = (String value, List<TemplatedValue> templatedValues,
        [String condition]) {
      if (templatedValues.isNotEmpty) {
        for (var templatedValue in templatedValues) {
          if (templatedValue.type == 'DateTime') {
            if (templatedValue.formatting != null) {
              value = value.replaceFirst(
                templatedValue.value,
                "\$\{DateFormat('${templatedValue.formatting}', '$languageCode').format(${templatedValue.normalizedKey})\}",
              );
            } else {
              value = value.replaceFirst(
                templatedValue.value,
                '\$\{${templatedValue.normalizedKey}.toIso8601String()\}',
              );
            }
          } else if (const [
            'double',
            'int',
            'num',
          ].contains(templatedValue.type)) {
            if (templatedValue.formatting != null) {
              if ([
                'decimalPercentPattern',
                'currency',
                'simpleCurrency',
                'compact',
                'compactLong',
                'compactSimpleCurrency',
                'compactCurrency'
              ].contains(templatedValue.formatting)) {
                value = value.replaceFirst(templatedValue.value,
                    "\$\{NumberFormat.${templatedValue.formatting}(locale: '$languageCode').format(${templatedValue.normalizedKey})\}");
              } else if ([
                'decimalPattern',
                'percentPattern',
                'scientificPattern'
              ].contains(templatedValue.formatting)) {
                value = value.replaceFirst(templatedValue.value,
                    "\$\{NumberFormat.${templatedValue.formatting}('$languageCode').format(${templatedValue.normalizedKey})\}");
              } else if (templatedValue.formatting == 'format') {
                value = value.replaceFirst(templatedValue.value,
                    "\$\{NumberFormat.${templatedValue.formatting}('$languageCode').format(${templatedValue.normalizedKey})\}");
              }
            } else {
              value = value.replaceFirst(
                templatedValue.value,
                "\$\{NumberFormat(null, '$languageCode').format(${templatedValue.normalizedKey})\}",
              );
            }
          } else {
            value = value.replaceFirst(
                templatedValue.value, '\$\{${templatedValue.normalizedKey}\}');
          }
        }
      }
      return '\'\'\'' + value + '\'\'\'';
    };

    result.write(section.normalizedName);
    result.write('(');

    section.labels.forEach((x) {
      result.write(x.normalizedKey);
      result.write(':');

      if (x.cases.length == 1 && x.cases.first.condition is DefaultCondition) {
        // Single case
        final translation = x.cases.first.translations.firstWhere(
            (x) => x.languageCode == languageCode,
            orElse: () => Translation(languageCode, '<?' + x.key + '?>'));

        if (x.templatedValues.isEmpty) {
          result.write('\'' + _excapeString(translation.value) + '\'');
        } else {
          final functionArgs =
              x.templatedValues.map((x) => x.normalizedKey).join(', ');

          // We replace all occurences of `{{original_key}}` by `$originalKey`
          result.write('(\{$functionArgs\}) => ' +
              templatedString(translation.value, x.templatedValues));
        }
      } else {
        // Multiple cases
        var functionArgs = 'condition';

        if (x.templatedValues.isNotEmpty) {
          functionArgs += ', {' +
              x.templatedValues.map((x) => x.normalizedKey).join(', ') +
              '}';
        }

        result.write('($functionArgs) {');

        final categoryConditions =
            x.cases.where((x) => x.condition is CategoryCondition).toList();
        if (categoryConditions.isNotEmpty) {
          for (var oneCase in categoryConditions) {
            final condition = oneCase.condition as CategoryCondition;
            result.write(
                'if(condition == ${condition.category.normalizedKey}.${condition.value})');

            final translation = oneCase.translations.firstWhere(
                (x) => x.languageCode == languageCode,
                orElse: () => Translation(languageCode, '<?' + x.key + '?>'));

            result.write(
              'return ' +
                  templatedString(
                      translation.value, x.templatedValues, condition.value) +
                  ';',
            );
          }
        }

        final defaultCase = x.cases.firstWhere(
            (x) => x.condition is DefaultCondition,
            orElse: () => null);

        if (defaultCase != null) {
          final translation = defaultCase.translations.firstWhere(
              (x) => x.languageCode == languageCode,
              orElse: () => Translation(languageCode, '<?' + x.key + '?>'));

          result.write('return ' +
              templatedString(translation.value, x.templatedValues) +
              ';');
        } else {
          result.write('throw Exception();');
        }

        result.write('}');
      }

      result.write(',');
    });

    section.children.forEach((child) {
      result.write(child.normalizedKey);
      result.write(':');
      result.write(_createSectionInstance(languageCode, child));
      result.write(',');
    });

    result.write(')');

    return result.toString();
  }

  String _excapeString(String value) =>
      value.replaceAll('\'', '\\\'').replaceAll('\n', '\\n');

  void _addCategoryDefinition(Category category) {
    final values = category.values.map((x) => x + ',').join();
    final code = Code('enum ${category.normalizedKey} { $values }');
    _library.body.add(code);
  }

  String _getLabelsCase(List<Label> labels) {
    final results = StringBuffer('switch (key) {');
    labels.forEach((label) {
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
    });
    results.write("default: return '';");
    results.write('}');
    return results.toString();
  }

  void _addSectionDefinition(Section section) {
    final result = ClassBuilder()..name = section.normalizedName;

    var constructor = ConstructorBuilder()..constant = true;

    var addField = (String type, String name) {
      result.fields.add(Field((b) => b
        ..name = name
        ..modifier = FieldModifier.final$
        ..type = refer(type)));

      if (name.startsWith('_')) {
        final argName = name.replaceFirst('_', '');
        constructor.optionalParameters.add(Parameter((p) => p
          ..name = argName
          ..type = refer(type)
          ..named = true));
        constructor.initializers.add(Code('$name = $argName'));
      } else {
        constructor.optionalParameters.add(Parameter((p) => p
          ..name = name
          ..named = true
          ..toThis = true));
      }
    };

    result.methods.add(
      Method((b) => b
        ..name = 'getByKey'
        ..returns = refer('String')
        ..body = Code(_getLabelsCase(section.labels))
        ..requiredParameters.addAll([
          Parameter(
            (b) => b
              ..type = refer('String')
              ..name = 'key',
          )
        ])),
    );

    section.labels.forEach((label) {
      if (label.templatedValues.isEmpty &&
          label.cases.length == 1 &&
          label.cases.first.condition is DefaultCondition) {
        addField('String', label.normalizedKey);
      } else {
        // If we have templated values, a function is generated
        final functionTypeName =
            section.normalizedName + '_' + label.normalizedKey;
        var functionArguments = '';

        final categories =
            label.cases.where((x) => x.condition is CategoryCondition);
        Category category;
        if (categories.isNotEmpty) {
          category = (categories.first.condition as CategoryCondition).category;
          functionArguments += '${category.normalizedKey} condition';
        }

        if (label.templatedValues.isNotEmpty) {
          if (functionArguments.isNotEmpty) functionArguments += ',';
          functionArguments += '{' +
              label.templatedValues
                  .map((x) => '@required ${x.type} ${x.normalizedKey}')
                  .join(', ') +
              '}';
        }

        _library.body.add(
          Code(
              'typedef $functionTypeName = String Function($functionArguments);'),
        );
        addField(functionTypeName, '_' + label.normalizedKey);

        final templatedCallArgs = label.templatedValues.isNotEmpty
            ? label.templatedValues
                .map((x) => '${x.normalizedKey}: ${x.normalizedKey},')
                .join()
            : '';
        final conditionCallArgs = categories.isNotEmpty ? 'condition, ' : '';

        // A method proxy is needed for @required arguments
        result.methods.add(
          Method(
            (b) => b
              ..name = label.normalizedKey
              ..returns = refer('String')
              ..lambda = true
              ..body = Code(
                '_${label.normalizedKey}($conditionCallArgs$templatedCallArgs)',
              )
              ..requiredParameters.addAll(categories.isNotEmpty
                  ? [
                      Parameter(
                        (b) => b
                          ..type = refer(category.normalizedKey)
                          ..name = 'condition',
                      )
                    ]
                  : [])
              ..optionalParameters.addAll(
                label.templatedValues.map(
                  (x) => Parameter(
                    (b) => b
                      ..name = x.normalizedKey
                      ..named = true
                      ..type = refer(x.type)
                      ..annotations.add(
                        refer('required'),
                      ),
                  ),
                ),
              ),
          ),
        );
      }
    });

    section.children.forEach((child) {
      _addSectionDefinition(child);
      addField(child.normalizedName, child.normalizedKey);
    });

    result.constructors.add(constructor.build());

    _library.body.add(result.build());
  }
}
