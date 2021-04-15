import 'package:equatable/equatable.dart';
import 'package:localization_builder/src/definitions/localizations.dart';

class ParsingResult<Input extends Object, Token> extends Equatable {
  const ParsingResult({
    required this.input,
    required this.result,
    required this.tokens,
  });

  final Input input;
  final Localizations result;
  final List<Token> tokens;

  @override
  List<Object> get props => [
        input,
        result,
        tokens,
      ];
}

class ParsingException<Token> {
  const ParsingException({
    required this.message,
    required this.token,
  });

  final String message;
  final Token token;
}
