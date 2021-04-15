import 'result.dart';

abstract class LocalizationParser<Input extends Object, Token> {
  const LocalizationParser();
  ParsingResult<Input, Token> parse({
    required Input input,
    required String name,
  });
}
