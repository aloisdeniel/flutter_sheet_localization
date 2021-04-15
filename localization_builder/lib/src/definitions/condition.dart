import 'package:equatable/equatable.dart';
import 'package:recase/recase.dart' as recase;

/// A condition can define a [Case] when a [Label] have multiple possible
/// values.
abstract class Condition extends Equatable {
  const Condition._();
  factory Condition.parse(String? value) {
    if (value == null) return const DefaultCondition();
    value = value.trim();
    if (value.isEmpty) return const DefaultCondition();
    final splits = value.split('.');
    assert(splits.length == 2,
        'Category condition should be composed of two segments `<category>.<value>`');
    return CategoryCondition(splits[0], splits[1]);
  }
}

/// When a label have a case with no condition.
class DefaultCondition extends Condition {
  const DefaultCondition() : super._();

  @override
  List<Object> get props => const <Object>[];
}

/// When a label have a case regarding a category.
class CategoryCondition extends Condition {
  const CategoryCondition(
    this.name,
    this._value,
  ) : super._();

  final String name;
  final String _value;

  String get value => recase.ReCase(_value).camelCase;

  @override
  List<Object> get props => [name, _value];
}
