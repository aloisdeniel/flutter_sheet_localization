import 'package:template_string/src/template.dart';

import 'formatters.dart';

extension TemplateStringExtension on String {
  /// Replaces all templates with [values].
  ///
  /// The [locale] is used by formatters when provided.
  String insertTemplateValues(Map<String, Object> values, {String? locale}) {
    final result = StringBuffer();
    final templates = StringTemplate.parse(this);
    var previousIndex = 0;
    for (var template in templates) {
      result.write(substring(previousIndex, template.startIndex));
      final value = values[template.key];
      if (value == null) {
        throw Exception('Missing argument "${template.key}" in [values]');
      }
      final formatted = () {
        if (template.type != 'String') {
          return StringTemplateFormatters.format(
            template.type,
            value,
            template.formatting,
            locale,
          );
        }
        return value.toString();
      }();
      result.write(formatted);
      previousIndex = template.endIndex;
    }
    if (previousIndex < length) {
      result.write(substring(previousIndex, length));
    }
    return result.toString();
  }
}
