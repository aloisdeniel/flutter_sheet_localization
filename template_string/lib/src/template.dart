/// Represents a part of a [Translation] that can be replaced
/// by a value at runtime.
///
/// It follows the pattern `{{key}}`.
class StringTemplate {
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
  final String? formatting;

  final int startIndex;

  final int endIndex;

  const StringTemplate(
    this.startIndex,
    this.endIndex,
    this.value,
    this.key,
    this.type,
    this.formatting,
  );

  static final regExp = RegExp(
    r'\{\{([a-zA-Z0-9_-]+)(:([a-zA-Z0-9_-]+))?(\[([^\]]+)\])?\}\}',
  );

  /// Parse the given value and extract all templated values.
  static List<StringTemplate> parse(String value) {
    final matches = StringTemplate.regExp.allMatches(value);
    return matches
        .map(
          (match) => StringTemplate(
            match.start,
            match.end,
            match.input.substring(match.start, match.end),
            match.group(1)!,
            match.group(3) ?? 'String',
            match.group(5),
          ),
        )
        .toList();
  }

  @override
  bool operator ==(Object o) => o is StringTemplate && o.key == key;

  @override
  int get hashCode => key.hashCode;
}
