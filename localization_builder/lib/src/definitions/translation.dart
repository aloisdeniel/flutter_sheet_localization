import 'package:equatable/equatable.dart';
import 'package:template_string/template_string.dart';

/// Represents a translation as [value] of a label in the language with the [languageCode].
class Translation extends Equatable {
  /// Creates a new [Translation] with a [value] for a given language with [languageCode].
  const Translation(
    this.languageCode,
    this.value,
  );

  /// The language code.
  final String languageCode;

  /// The translatio value.
  final String value;

  /// The templated values are portions of the [value] in which dynamic values can be inserted.
  List<StringTemplate> get templatedValues => StringTemplate.parse(value);

  @override
  List<Object> get props => [
        languageCode,
        value,
        templatedValues.map((x) => x.key),
      ];
}
