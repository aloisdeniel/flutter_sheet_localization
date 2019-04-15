import 'package:meta/meta.dart';
import 'package:recase/recase.dart';

class Localizations extends Section {
  final List<String> supportedLanguageCodes;
  final String name;

  Localizations(
      {this.name = "AppLocalizations",
      @required this.supportedLanguageCodes,
      List<Label> labels,
      List<Section> children})
      : super(path: [name, "Labels"], children: children, labels: labels, key: null);
}

class Section {
  final List<String> path;
  final String key;
  final List<Label> labels;
  final List<Section> children;
  String get normalizedKey => ReCase(this.key).camelCase;
  String get normalizedName =>
      this.path.map((x) => ReCase(x).pascalCase).join("_");

  Section(
      {@required this.path,
      @required String key,
      List<Label> labels,
      List<Section> children})
      : this.key = key ?? "labels",
        this.labels = labels ?? [],
        this.children = children ?? [];

  void insert(String path, List<Translation> translations) {
    this._insert(path.trim().split("."), translations);
  }

  void _insert(List<String> splits, List<Translation> translations) {
    if (splits.length > 0) {
      final key = splits[0].trim();
      if (splits.length == 1) {
        this.labels.add(Label(key: key, translations: translations));
        return;
      } else {
        final section =
            this.children.firstWhere((x) => x.key == key, orElse: () {
          final newSection = Section(
              path: <String>[]
                ..addAll(this.path)
                ..add(key),
              key: key);
          this.children.add(newSection);
          return newSection;
        });
        section._insert(splits.skip(1).toList(), translations);
      }
    }
  }
}

class Label {
  final String key;
  final List<Translation> translations;
  String get normalizedKey => ReCase(this.key).camelCase;
  Label({@required this.key, @required this.translations});
}

class Translation {
  final String languageCode;
  final String value;
  Translation(this.languageCode, this.value);
}
