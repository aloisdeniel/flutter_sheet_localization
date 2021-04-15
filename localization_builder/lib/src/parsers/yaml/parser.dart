import 'package:localization_builder/src/definitions/case.dart';
import 'package:localization_builder/src/definitions/condition.dart';
import 'package:localization_builder/src/definitions/label.dart';
import 'package:localization_builder/src/definitions/localizations.dart';
import 'package:localization_builder/src/definitions/section.dart';
import 'package:localization_builder/src/definitions/translation.dart';
import 'package:localization_builder/src/parsers/result.dart';
import 'package:yaml/yaml.dart';

import '../parser.dart';
import 'token.dart';

class YamlLocalizationParser
    extends LocalizationParser<YamlNode, YamlLocalizationToken> {
  YamlLocalizationParser();

  List<YamlLocalizationToken> _tokens = <YamlLocalizationToken>[];

  @override
  ParsingResult<YamlNode, YamlLocalizationToken> parse({
    required YamlNode input,
    required String name,
  }) {
    if (!(input is YamlMap)) {
      throw ParsingException<YamlLocalizationToken>(
        message: '[input] should be a YamlMap',
        token: YamlLocalizationToken.unknown(input),
      );
    }
    final map = input;
    _tokens = <YamlLocalizationToken>[];

    // Parsing language coedes
    final languages = <Localizations>[];

    for (var languageEntry in map.nodes.entries) {
      _addToken(
        YamlLocalizationTokenType.languageKey,
        languageEntry.key,
      );
      if (!(languageEntry.value is YamlMap)) {
        throw ParsingException<YamlLocalizationToken>(
          message: '[${languageEntry.key}] should be a YamlMap',
          token: YamlLocalizationToken.unknown(languageEntry.value),
        );
      }
      final section = _parseSection(
        languageEntry.key.toString(),
        name,
        languageEntry.value as YamlMap,
      );
      languages.add(
        Localizations.fromSection(
          name: name,
          supportedLanguageCodes: [languageEntry.key.toString()],
          section: section,
        ),
      );
    }

    return ParsingResult<YamlNode, YamlLocalizationToken>(
      input: input,
      result: Localizations.merge(name, languages),
      tokens: _tokens,
    );
  }

  Section _parseSection(String languageKey, String key, YamlMap map) {
    final labels = <Label>[];
    final children = <Section>[];
    for (var sectionEntry in map.nodes.entries) {
      final value = sectionEntry.value;
      // Label
      if (value is YamlScalar) {
        final labelTranslation = value.value.toString();
        _addToken(
          YamlLocalizationTokenType.labelKey,
          sectionEntry.key,
        );
        _addToken(
          YamlLocalizationTokenType.labelValue,
          sectionEntry.value,
        );
        labels.add(
          Label(
            key: sectionEntry.key.toString(),
            cases: <Case>[
              Case(
                condition: DefaultCondition(),
                translations: [
                  Translation(
                    languageKey,
                    labelTranslation,
                  ),
                ],
              ),
            ],
          ),
        );
      } else if (value is YamlMap) {
        // Label with cases
        if (value.containsKey('cases')) {
          _addToken(
            YamlLocalizationTokenType.labelKey,
            sectionEntry.key,
          );
          final cases = <Case>[];

          final caseNodes = value.nodes['cases'];

          if (!(caseNodes is YamlMap)) {
            throw ParsingException<YamlLocalizationToken>(
              message: '[cases] should be a YamlMap',
              token: YamlLocalizationToken.unknown(caseNodes),
            );
          }

          _addToken(
            YamlLocalizationTokenType.caseKey,
            value.nodes.entries
                .firstWhere((x) => x.key.toString() == 'cases')
                .key,
          );

          final caseMap = caseNodes;

          for (var caseEntry in caseMap.nodes.entries) {
            _addToken(
              YamlLocalizationTokenType.caseKey,
              caseEntry.key,
            );
            _addToken(
              YamlLocalizationTokenType.caseValue,
              caseEntry.value,
            );
            final caseTranslation = caseEntry.value.toString();
            final condition = Condition.parse(caseEntry.key.toString());
            cases.add(
              Case(
                condition: condition,
                translations: [
                  Translation(
                    languageKey,
                    caseTranslation,
                  ),
                ],
              ),
            );
          }

          labels.add(
            Label(
              key: sectionEntry.key.toString(),
              cases: cases,
            ),
          );
        }
        // Child section
        else {
          _addToken(
            YamlLocalizationTokenType.sectionKey,
            sectionEntry.key,
          );
          final sectionKey = sectionEntry.key.toString();

          if (!(sectionEntry.value is YamlMap)) {
            throw ParsingException<YamlLocalizationToken>(
              message: '[$sectionKey] should be a YamlMap',
              token: YamlLocalizationToken.unknown(sectionEntry.value),
            );
          }

          final child = _parseSection(
            languageKey,
            sectionKey,
            sectionEntry.value as YamlMap,
          );
          children.add(child);
        }
      }
    }
    return Section(
      key: key,
      children: children,
      labels: labels,
    );
  }

  void _addToken(YamlLocalizationTokenType type, YamlNode node) {
    _tokens.add(
      YamlLocalizationToken(
        type: type,
        node: node,
      ),
    );
  }
}
