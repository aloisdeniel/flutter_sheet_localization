import 'package:flutter_csv_localization/src/localizations.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

class DartBuilder {
  LibraryBuilder _library;

  String build(Localizations localizations) {
    _library = LibraryBuilder();

    _library.directives.addAll([
      Directive.import("package:flutter/foundation.dart"),
      Directive.import("package:flutter/widgets.dart"),
    ]);

    _library.body.add(_createDelegate(localizations));
    _library.body.add(_createLocalization(localizations));
    _addSectionDefinition(localizations);

    // Code generation
    final emitter = DartEmitter();
    final source = '${_library.build().accept(emitter)}';
    print(source);
    return DartFormatter().format(source);
  }

  Class _createDelegate(Localizations localizations) {
    final delegateName = localizations.name + "Delegate";
    final result = ClassBuilder()
      ..name = delegateName
      ..extend = refer("LocalizationsDelegate<${localizations.name}>");

    result.methods.add(Method((b) => b
      ..name = "isSupported"
      ..returns = refer("bool")
      ..lambda = true
      ..annotations.add(CodeExpression(Code("override")))
      ..body = Code(
          "${localizations.name}._languages.containsKey(locale.languageCode)")
      ..requiredParameters.add(Parameter((b) => b
        ..name = "locale"
        ..type = refer("Locale")))));

    result.methods.add(Method((b) => b
      ..name = "load"
      ..returns = refer("Future<${localizations.name}>")
      ..lambda = true
      ..annotations.add(CodeExpression(Code("override")))
      ..body = Code(
          "SynchronousFuture<${localizations.name}>(${localizations.name}(locale))")
      ..requiredParameters.add(Parameter((b) => b
        ..name = "locale"
        ..type = refer("Locale")))));

    result.methods.add(Method((b) => b
      ..name = "shouldReload"
      ..returns = refer("bool")
      ..lambda = true
      ..annotations.add(CodeExpression(Code("override")))
      ..body = Code("false")
      ..requiredParameters.add(Parameter((b) => b
        ..name = "old"
        ..type = refer(delegateName)))));

    return result.build();
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
      ..toThis = true
      ..type = refer("Locale")));

    constructor.initializers
        .add(Code("this.labels = _languages[locale.languageCode]"));

    result.fields.add(Field((b) => b
      ..name = "_languages"
      ..static = true
      ..assignment = _createLanguageMap(localizations)
      ..modifier = FieldModifier.final$
      ..type = refer("Map<String," + localizations.normalizedName + ">")));

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
          "Localizations.of<${localizations.name}>(context, ${localizations.name}).labels")
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
      result.write("\"" + languageCode + "\" : " + code + ",");
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
      result.write("\"" + _excapeString(translation.value) + "\"");
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
    final result = ClassBuilder()
      ..name = section.normalizedName;

    var constructor = ConstructorBuilder();

    var addField = (String type, String name) {
      result.fields.add(Field((b) => b
        ..name = name
        ..modifier = FieldModifier.final$
        ..type = refer(type)));
      constructor.optionalParameters.add(Parameter((p) => p
        ..name = name
        ..named = true
        ..toThis = true
        ..type = refer(type)));
    };

    section.labels.forEach((label) => addField("String", label.normalizedKey));

    section.children.forEach((child) {
      _addSectionDefinition(child);
      addField(child.normalizedName, child.normalizedKey);
    });

    result.constructors.add(constructor.build());

    _library.body.add(result.build());
  }
}
