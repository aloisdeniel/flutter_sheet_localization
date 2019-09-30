import 'package:meta/meta.dart';
import 'package:recase/recase.dart';
import 'package:collection/collection.dart';

class Localizations extends Section {
  final List<String> supportedLanguageCodes;
  final String name;

  Localizations({
    this.name = "AppLocalizations",
    @required this.supportedLanguageCodes,
    List<Label> labels,
    List<Section> children,
  }) : super(
            path: [name, "Labels"],
            children: children,
            labels: labels,
            key: null);

  Localizations copyWith({
    List<String> supportedLanguageCodes,
    List<Label> labels,
    List<Section> children,
    String name,
  }) {
    return Localizations(
      supportedLanguageCodes:
          supportedLanguageCodes ?? this.supportedLanguageCodes,
      labels: labels ?? this.labels,
      children: children ?? this.children,
      name: name ?? this.name,
    );
  }
}

/// A section is a set of labels, grouped together to to make them
/// easier to find.
class Section {
  final List<String> path;
  final String key;
  final List<Label> labels;
  final List<Section> children;
  String get normalizedKey => ReCase(this.key).camelCase;
  String get normalizedName =>
      this.path.map((x) => ReCase(x).pascalCase).join("_");

  Section(
      {@required this.path,
      @required String key,
      List<Label> labels,
      List<Section> children})
      : this.key = key ?? "labels",
        this.labels = labels ?? [],
        this.children = children ?? [];

  void insert(String path, List<Translation> translations) {
    this._insert(path.trim().split("."), translations);
  }

  void _insert(List<String> splits, List<Translation> translations) {
    if (splits.isNotEmpty) {
      final key = splits[0].trim();
      if (splits.length == 1) {
        this.labels.add(Label(key: key, translations: translations));
        return;
      } else {
        final section =
            this.children.firstWhere((x) => x.key == key, orElse: () {
          final newSection = Section(
              path: <String>[]
                ..addAll(this.path)
                ..add(key),
              key: key);
          this.children.add(newSection);
          return newSection;
        });
        section._insert(splits.skip(1).toList(), translations);
      }
    }
  }
}

/// Represents a label that can have multiple translations.
class Label {
  final String key;
  final List<Translation> translations;
  final List<TemplatedValue> templatedValues;
  String get normalizedKey => ReCase(this.key).camelCase;
  Label({
    @required this.key,
    @required this.translations,
  })  : assert(assertTranslationsValid(translations)),
        this.templatedValues =
            translations.isEmpty ? [] : translations.first.templatedValues;

  /// Verifies that all translation havez the same templated values (if so).
  static bool assertTranslationsValid(List<Translation> translations) {
    if (translations.length > 1) {
      final templatedValues = translations.first.templatedValues;
      for (var i = 1; i < translations.length; i++) {
        final current = translations[i];
        if (!const SetEquality()
            .equals(templatedValues.toSet(), current.templatedValues.toSet())) {
          return false;
        }
      }
    }

    return true;
  }
}

/// Represents a translation of a label in a given language.
class Translation {
  final String languageCode;
  final String value;
  final List<TemplatedValue> templatedValues;

  Translation(
    this.languageCode,
    this.value,
  ) : this.templatedValues = TemplatedValue.parse(value);
}

/// Represents a part of a [Translation] that can be replaced
/// by a value at runtime.
///
/// It follows the pattern `{{key}}`.
class TemplatedValue {
  /// The original template value in the label
  ///
  /// For example: `{{first_name}}` in `Welcome {{first_name}}!`
  final String value;

  /// The original key.
  ///
  /// For example: `first_name` for `{{first_name}}`
  String get key => value.substring(2, value.length - 2);

  final int startIndex;

  final int endIndex;

  /// The normalized key.
  ///
  /// For example: `firstName` for `{{first_name}}`
  String get normalizedKey => ReCase(this.key).camelCase;

  const TemplatedValue(
    this.startIndex,
    this.endIndex,
    this.value,
  );

  static final regExp = RegExp(r"\{\{([a-zA-Z0-9_-]+)\}\}");

  /// Parse the given value and extract all templated values.
  static List<TemplatedValue> parse(String value) {
    final matches = TemplatedValue.regExp.allMatches(value);
    return matches
        .map((match) => TemplatedValue(match.start, match.end,
            match.input.substring(match.start, match.end)))
        .toList();
  }

  bool operator ==(Object o) => o is TemplatedValue && o.key == this.key;

  int get hashCode => this.key.hashCode;
}
