import 'package:equatable/equatable.dart';
import 'package:recase/recase.dart' as recase;

/// A category represents a set of possible alternative for
/// a label.
///
/// For example, the `Gender` (`male`, `female`) or the `Plurarity` (`zero`, `single`, `multiple`).
class Category extends Equatable {
  const Category({
    required this.name,
    required this.values,
  });

  /// The name of the category.
  ///
  /// Example : `Gender`.
  final String name;

  /// All the possible cases.
  ///
  /// Example : `[ 'male', 'female']`.
  final Set<String> values;

  /// The normalized name.
  String get normalizedName => recase.ReCase(name).pascalCase;

  @override
  List<Object> get props => [name];
}
