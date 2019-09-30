import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

import 'localizations.dart';

class DartBuilder {
  LibraryBuilder _library;

  String build(Localizations localizations) {
    _library = LibraryBuilder();

    _library.body.add(_createLocalization(localizations));
    _addSectionDefinition(localizations);

    // Code generation
    final emitter = DartEmitter();
    final source = '${_library.build().accept(emitter)}';
    return DartFormatter().format(source);
  }

  Class _createLocalization(Localizations localizations) {
    final result = ClassBuilder()..name = localizations.name;

    var constructor = ConstructorBuilder();

    result.fields.add(Field((b) => b
      ..name = "locale"
      ..modifier = FieldModifier.final$
      ..type = refer("Locale")));

    constructor.requiredParameters.add(Parameter((p) => p
      ..name = "locale"
      ..toThis = true));

    constructor.initializers.add(Code("this.labels = languages[locale]"));

    result.fields.add(Field((b) => b
      ..name = "languages"
      ..static = true
      ..assignment = _createLanguageMap(localizations)
      ..modifier = FieldModifier.final$
      ..type = refer("Map<Locale," + localizations.normalizedName + ">")));

    result.fields.add(Field((b) => b
      ..name = "labels"
      ..modifier = FieldModifier.final$
      ..type = refer(localizations.normalizedName)));

    result.methods.add(Method((b) => b
      ..name = "of"
      ..lambda = true
      ..static = true
      ..returns = refer(localizations.normalizedName)
      ..body = Code(
          "Localizations.of<${localizations.name}>(context, ${localizations.name})?.labels")
      ..requiredParameters.add(Parameter((b) => b
        ..name = "context"
        ..type = refer("BuildContext")))));

    result.constructors.add(constructor.build());

    return result.build();
  }

  Code _createLanguageMap(Localizations localizations) {
    final result = StringBuffer();

    result.write("{");

    for (var languageCode in localizations.supportedLanguageCodes) {
      final code = _createSectionInstance(languageCode, localizations);

      final splits = languageCode.split("-");

      var key = "Locale.fromSubtags(languageCode: \"${splits.first}\"";
      if (splits.length > 2) {
        key += ", scriptCode: \"${splits[1]}\"";
        key += ", countryCode: \"${splits[2]}\"";
      } else if (splits.length > 1) {
        key += ", countryCode: \"${splits[1]}\"";
      }
      key += ")";
      result.write(key + " : " + code + ",");
    }

    result.write("}");

    return Code(result.toString());
  }

  String _createSectionInstance(String languageCode, Section section) {
    final result = StringBuffer();

    result.write(section.normalizedName);
    result.write("(");

    section.labels.forEach((x) {
      final translation = x.translations.firstWhere(
          (x) => x.languageCode == languageCode,
          orElse: () => Translation(languageCode, "<?" + x.key + "?>"));
      result.write(x.normalizedKey);
      result.write(":");

      if (x.templatedValues.isEmpty) {
        result.write("\"" + _excapeString(translation.value) + "\"");
      } else {
        final functionArgs =
            x.templatedValues.map((x) => x.normalizedKey).join(", ");

        // We replace all occurences of `{{original_key}}` by `$originalKey`
        var value = translation.value;
        for (var templatedValue in x.templatedValues) {
          value = value.replaceFirst(
              templatedValue.value, "\$\{${templatedValue.normalizedKey}\}");
        }
        result.write("(\{$functionArgs\}) => \"" + _excapeString(value) + "\"");
      }
      result.write(",");
    });

    section.children.forEach((child) {
      result.write(child.normalizedKey);
      result.write(":");
      result.write(_createSectionInstance(languageCode, child));
      result.write(",");
    });

    result.write(")");

    return result.toString();
  }

  String _excapeString(String value) => value.replaceAll("\"", "\\\"");

  void _addSectionDefinition(Section section) {
    final result = ClassBuilder()..name = section.normalizedName;

    var constructor = ConstructorBuilder()..constant = true;

    var addField = (String type, String name) {
      result.fields.add(Field((b) => b
        ..name = name
        ..modifier = FieldModifier.final$
        ..type = refer(type)));

      if (name.startsWith("_")) {
        final argName = name.replaceFirst('_', "");
        constructor.optionalParameters.add(Parameter((p) => p
          ..name = argName
          ..type = refer(type)
          ..named = true));
        constructor.initializers.add(Code("this.$name = $argName"));
      } else {
        constructor.optionalParameters.add(Parameter((p) => p
          ..name = name
          ..named = true
          ..toThis = true));
      }
    };

    section.labels.forEach((label) {
      if (label.templatedValues.isEmpty) {
        addField("String", label.normalizedKey);
      } else {
        // If we have templated values, a function is generated
        final functionTypeName =
            section.normalizedName + "_" + label.normalizedKey;
        final functionArguments = label.templatedValues
            .map((x) => "@required String ${x.normalizedKey}")
            .join(", ");
        _library.body.add(
          Code("typedef String $functionTypeName({$functionArguments});"),
        );
        addField(functionTypeName, "_" + label.normalizedKey);

        // A method proxy is needed for @required arguments
        result.methods.add(
          Method(
            (b) => b
              ..name = label.normalizedKey
              ..returns = refer("String")
              ..lambda = true
              ..body = Code(
                "this._${label.normalizedKey}(${label.templatedValues.map((x) => "${x.normalizedKey}: ${x.normalizedKey},").join()})",
              )
              ..optionalParameters.addAll(
                label.templatedValues.map(
                  (x) => Parameter(
                    (b) => b
                      ..name = x.normalizedKey
                      ..named = true
                      ..type = refer("String")
                      ..annotations.add(refer('required')),
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
