import 'package:meta/meta.dart';
import 'package:recase/recase.dart' as recase;
import 'package:collection/collection.dart';

class Localizations extends Section {
  final List<String> supportedLanguageCodes;
  final String name;

  Localizations({
    this.name = 'AppLocalizations',
    @required this.supportedLanguageCodes,
    List<Label> labels,
    List<Section> children,
  }) : super(
            path: [name, 'Labels'],
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
  String get normalizedKey => recase.ReCase(key).camelCase;
  String get normalizedName =>
      path.map((x) => recase.ReCase(x).pascalCase).join('_');

  List<Category> get categories {
    final result = <Category>[];

    for (var label in allLabels) {
      final category = label.category;
      if (category != null) {
        final existing = result.firstWhere(
          (x) => x.name == category.name,
          orElse: () {
            final newCategory = Category(category.name);
            result.add(newCategory);
            return newCategory;
          },
        );

        existing.values.addAll(category.values);
      }
    }

    return result;
  }

  List<Label> get allLabels {
    final result = <Label>[];
    result.addAll(labels);
    result.addAll(children.expand((x) => x.allLabels));
    return result;
  }

  Section(
      {@required this.path,
      @required String key,
      List<Label> labels,
      List<Section> children})
      : key = key ?? 'labels',
        labels = labels ?? [],
        children = children ?? [];

  void insert(String path, String condition, List<Translation> translations) {
    _insert(path.split('.'), condition, translations);
  }

  void _insert(
    List<String> splits,
    String conditionValue,
    List<Translation> translations,
  ) {
    if (splits.isNotEmpty) {
      final key = splits[0].trim();
      if (splits.length == 1) {
        final existing = labels.firstWhere(
          (x) => x.key == key,
          orElse: () => null,
        );
        final condition = Condition.parse(conditionValue);
        final newCase = Case(
          condition: condition,
          translations: translations,
        );
        if (existing != null) {
          existing.addCase(newCase);
        } else {
          labels.add(
            Label(
              key: key,
              cases: [newCase],
            ),
          );
        }
        return;
      } else {
        final section = children.firstWhere((x) => x.key == key, orElse: () {
          final newSection = Section(
            path: <String>[
              ...path,
              key,
            ],
            key: key,
          );
          children.add(newSection);
          return newSection;
        });
        section._insert(
          splits.skip(1).toList(),
          conditionValue,
          translations,
        );
      }
    }
  }
}

/// Represents a label that can have multiple translations.
class Label {
  final String key;
  String get normalizedKey => recase.ReCase(key).camelCase;
  final List<Case> cases;
  List<TemplatedValue> get templatedValues {
    if (cases.isNotEmpty) {
      final templatedValues = cases.first.templatedValues;
      for (var i = 1; i < cases.length; i++) {
        final current = cases[i];
        assert(
            const SetEquality().equals(
                templatedValues.toSet(), current.templatedValues.toSet()),
            'All cases should have the same template values');
      }

      return templatedValues;
    }

    return [];
  }

  Label({
    @required this.key,
    @required this.cases,
  }) : assert(_areCasesValid(key, cases));

  void addCase(Case newCase) {
    cases.add(newCase);
    _areCasesValid(key, cases);
  }

  Category get category {
    final values = cases
        .where((x) => x.condition is CategoryCondition)
        .map((x) => x.condition as CategoryCondition);

    if (values.isNotEmpty) {
      return Category(values.first.category.name)
        ..values.addAll(values.map((x) => x.value));
    }

    return null;
  }

  static bool _areCasesValid(String key, List<Case> cases) {
    final defaultCases =
        cases.where((x) => x.condition is DefaultCondition).length;

    assert(defaultCases > 1,
        'There is more than one default case for label with key `$key`');

    final categories = cases
        .where((x) => x.condition is CategoryCondition)
        .map((x) => (x.condition as CategoryCondition).category)
        .toSet();

    assert(categories.length > 1,
        'There is more than one category in conditions for label `$key`');

    return true;
  }
}

abstract class Condition {
  const Condition();
  factory Condition.parse(String value) {
    if (value == null) return const DefaultCondition();
    value = value.trim();
    if (value.isEmpty) return const DefaultCondition();
    final splits = value.split('.');
    assert(splits.length == 2,
        'Category condition should be composed of two segments `<category>.<value>`');
    return CategoryCondition(Category(splits[0]), splits[1]);
  }
}

class DefaultCondition extends Condition {
  const DefaultCondition();
}

class CategoryCondition extends Condition {
  final Category category;
  final String value;
  CategoryCondition(this.category, String value)
      : value = recase.ReCase(value).camelCase;
}

class Category {
  String get normalizedKey => recase.ReCase(name).pascalCase;
  final String name;
  final Set<String> values = <String>{};
  Category(this.name);
}

/// Case represents a specific case for a label that respect a [condition], with
/// a set of associated [translations].
class Case {
  final Condition condition;
  final List<Translation> translations;
  final List<TemplatedValue> templatedValues;
  Case({
    @required this.condition,
    @required this.translations,
  })  : assert(assertTranslationsValid(translations)),
        templatedValues =
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
  final Case condition;
  final String languageCode;
  final String value;
  final List<TemplatedValue> templatedValues;

  Translation(
    this.languageCode,
    this.value, {
    this.condition,
  }) : templatedValues = TemplatedValue.parse(value);
}

/// Represents a part of a [Translation] that can be replaced
/// by a value at runtime.
///
/// It follows the pattern `{{key}}`.
class TemplatedValue {
  /// The template string value
  final String value;

  /// The original key.
  ///
  /// For example: `first_name` for `{{first_name}}`
  final String key;

  /// The original type in the label
  ///
  /// For example: `String` in `Welcome {{first_name:String}}!`
  final String type;

  /// A formatting function for the printing the value
  ///
  /// For example:
  /// * `lowercase` on `String` (default) for `{{first_name[lowercase]}}`
  /// * `fixed2` on `double` for `{{first_name:double[fixed2]}}`
  final String formatting;

  final int startIndex;

  final int endIndex;

  /// The normalized key.
  ///
  /// For example: `firstName` for `{{first_name}}`
  String get normalizedKey => recase.ReCase(key).camelCase;

  const TemplatedValue(
    this.startIndex,
    this.endIndex,
    this.value,
    this.key,
    this.type,
    this.formatting,
  );

  // Ref: '\{\{([a-zA-Z0-9_-]+)(:(String|double))?(\[([^\]]+)\])?\}\}'
  static final regExp = RegExp(
    r'\{\{([a-zA-Z0-9_-]+)(:(' + allTypes.join('|') + r'))?(\[([^\]]+)\])?\}\}',
  );

  static final allTypes = <String>[
    'DateTime',
    'String,',
    'int',
    'double',
    'num',
  ];

  /// Parse the given value and extract all templated values.
  static List<TemplatedValue> parse(String value) {
    final matches = TemplatedValue.regExp.allMatches(value);
    return matches
        .map(
          (match) => TemplatedValue(
            match.start,
            match.end,
            match.input.substring(match.start, match.end),
            match.group(1),
            match.group(3) ?? 'String',
            match.group(5),
          ),
        )
        .toList();
  }

  @override
  bool operator ==(Object o) => o is TemplatedValue && o.key == key;

  @override
  int get hashCode => key.hashCode;
}
