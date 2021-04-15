import 'argument.dart';

class MethodBuilder {
  const MethodBuilder({
    required this.name,
    required this.body,
    required this.returnType,
    required this.arguments,
  });
  final String name;
  final String returnType;
  final String body;
  final List<ArgumentBuilder> arguments;

  String build({bool nullSafety = true}) {
    final result = StringBuffer();
    result.write('$returnType $name(');
    if (arguments.isNotEmpty) {
      result.write('{');
      for (var argument in arguments) {
        result.write(argument.build(nullSafety: nullSafety));
        result.write(',');
      }
      result.write('}');
    }
    result.write(') $body');
    return result.toString();
  }
}
