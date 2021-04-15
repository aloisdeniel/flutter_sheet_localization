import 'package:equatable/equatable.dart';
import 'package:yaml/yaml.dart';

class YamlLocalizationToken extends Equatable {
  const YamlLocalizationToken({
    required this.node,
    required this.type,
  });

  const YamlLocalizationToken.unknown(this.node)
      : type = YamlLocalizationTokenType.unknown;

  final YamlNode? node;
  final YamlLocalizationTokenType type;

  @override
  List<Object> get props => [
        node ?? '',
        type,
      ];
}

enum YamlLocalizationTokenType {
  unknown,
  languageKey,
  sectionKey,
  labelKey,
  caseKey,
  labelValue,
  caseValue,
}
