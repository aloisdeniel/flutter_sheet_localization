import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:recase/recase.dart' as recase;
import 'package:template_string/template_string.dart';

import 'case.dart';
import 'condition.dart';

/// Represents a label that can have multiple translations.
class Label extends Equatable {
  Label({
    required this.key,
    required this.cases,
  }) : assert(_areCasesValid(key, cases));

  factory Label.merge(Label value, Label other) {
    assert(value.key == other.key,
        'The two merged labels should have the same key');
    final cases = <Case>[];

    for (var otherCase in other.cases) {
      final existingCase = cases.cast<Case?>().firstWhere(
            (x) => x!.condition == otherCase.condition,
            orElse: () => null,
          );
      if (existingCase == null) {
        cases.add(otherCase);
      } else {
        cases.add(Case.merge(existingCase, otherCase));
      }
    }
    final casesOnlyInValue = value.cases.where(
      (x) => !other.cases.any((o) => o.condition == x.condition),
    );
    cases.addAll(casesOnlyInValue);

    final result = Label(
      key: value.key,
      cases: cases,
    );

    Logger.root.finer(
        '[{LABEL} Merging]:\n\n\tITEM1===================================\n$value\n\n\tITEM2===================================\n$other\n\n\tRESULT===================================:\:\n$result\n\n');

    return result;
  }

  final String key;
  String get normalizedKey => recase.ReCase(key).camelCase;
  final List<Case> cases;
  List<StringTemplate> get templatedValues {
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

  /// All conditions related to categories declared in all label cases conditions.
  List<CategoryCondition> get categoryConditions =>
      cases.map((x) => x.condition).whereType<CategoryCondition>().toList();

  @override
  List<Object> get props => [
        key,
        cases,
      ];

  void addCase(Case newCase) {
    cases.add(newCase);
    _areCasesValid(key, cases);
  }

  static bool _areCasesValid(String key, List<Case> cases) {
    final defaultCases =
        cases.where((x) => x.condition is DefaultCondition).length;

    assert(defaultCases <= 1,
        'There is more than one default case for label with key `$key`');

    final categories = cases
        .where((x) => x.condition is CategoryCondition)
        .map((x) => (x.condition as CategoryCondition).name)
        .toSet();

    assert(categories.length <= 1,
        'There is more than one category in conditions for label `$key`');

    return true;
  }
}
