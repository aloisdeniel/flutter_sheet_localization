import 'package:localization_builder/localization_builder.dart';

class Localizations extends Section {
  Localizations({
    required this.name,
    required this.supportedLanguageCodes,
    required List<Label> labels,
    required List<Section> children,
  }) : super(
          children: children,
          labels: labels,
          key: '',
        );

  factory Localizations.fromSection({
    required List<String> supportedLanguageCodes,
    required String name,
    required Section section,
  }) =>
      Localizations(
        supportedLanguageCodes: supportedLanguageCodes,
        name: name,
        children: section.children,
        labels: section.labels,
      );

  final List<String> supportedLanguageCodes;

  final String name;

  factory Localizations.merge(String name, List<Localizations> values) {
    final supportedLanguageCodes = <String>[];

    Section? section;

    for (var value in values) {
      // Merging supportedLanguageCodes
      supportedLanguageCodes.addAll(
        value.supportedLanguageCodes.where(
          (x) => !supportedLanguageCodes.contains(x),
        ),
      );

      if (section == null) {
        section = value;
      } else {
        section = Section.merge(
          value,
          section,
        );
      }
    }

    return Localizations(
      name: name,
      children: section?.children ?? const <Section>[],
      labels: section?.labels ?? const <Label>[],
      supportedLanguageCodes: supportedLanguageCodes,
    );
  }

  @override
  List<Object> get props => [
        ...super.props,
        supportedLanguageCodes,
        name,
      ];

  Localizations copyWith({
    List<String>? supportedLanguageCodes,
    List<Label>? labels,
    List<Section>? children,
    String? name,
  }) {
    return Localizations(
      supportedLanguageCodes:
          supportedLanguageCodes ?? this.supportedLanguageCodes,
      labels: labels ?? this.labels,
      children: children ?? this.children,
      name: name ?? this.name,
    );
  }
}
