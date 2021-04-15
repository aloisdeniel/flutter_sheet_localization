class ArgumentBuilder {
  const ArgumentBuilder({
    required this.name,
    required this.type,
    this.defaultValue,
    this.isRequired = true,
  });
  final String name;
  final String type;
  final String? defaultValue;
  final bool isRequired;

  String build({bool nullSafety = true}) {
    final result = StringBuffer();
    if (defaultValue == null && isRequired) {
      result.write(' ${nullSafety ? '' : '@'}required ');
    }
    result.write('$type $name');
    if (defaultValue != null) {
      result.write('= $defaultValue');
    }
    return result.toString();
  }
}
