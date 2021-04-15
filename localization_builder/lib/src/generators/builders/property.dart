import 'base.dart';

class PropertyBuilder {
  const PropertyBuilder({
    required this.name,
    required this.type,
    required this.isPrivate,
    this.defaultValue,
    PropertyBuilderJsonConverter jsonConverter =
        defaultPropertyBuilderJsonConverter,
  }) : _jsonConverter = jsonConverter;
  final String name;
  final String type;
  final bool isPrivate;
  final String? defaultValue;
  final PropertyBuilderJsonConverter _jsonConverter;
  String get fieldName => '${isPrivate ? '_' : ''}$argumentName';
  String get argumentName => '${createFieldName(name)}';

  String jsonConverter(String value) => _jsonConverter(this, value);

  String buildConstructorParameter({bool nullSafety = true}) {
    final result = StringBuffer();
    result.write(' ${nullSafety ? '' : '@'}required');
    result.write(' ${isPrivate ? '$type ' : 'this.'}$argumentName');
    return result.toString();
  }

  List<String> buildConstructorInitializers({bool nullSafety = true}) {
    return [
      if (!nullSafety) 'assert($argumentName != null)',
      if (isPrivate) '$fieldName = $argumentName',
    ];
  }

  String buildField({bool nullSafety = true}) {
    return 'final $type $fieldName;';
  }
}

typedef PropertyBuilderJsonConverter = String Function(
  PropertyBuilder property,
  String value,
);

String defaultPropertyBuilderJsonConverter(
  PropertyBuilder property,
  String value,
) {
  if (property.type == 'String') {
    return '$value as String';
  } else if (property.type == 'bool') {
    return '$value as bool';
  } else if (property.type == 'int') {
    return '($value as num).toInt()';
  } else if (property.type == 'double') {
    return '($value as num).toDouble()';
  } else if (property.type == 'DateTime') {
    return 'DateTime.parse($value as String)';
  } else {
    return '$value';
  }
}

String fromJsonPropertyBuilderJsonConverter(
  PropertyBuilder property,
  String value,
) {
  return '${property.type}.fromJson($value as Map<String,Object?>)';
}
