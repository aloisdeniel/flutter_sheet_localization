# localization_builder

Generates a Flutter localization delegates from YAML or CSV.

## Install

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  localization_builder: <latest>
```

## Usage 

### YAML Parsing

```dart
import 'package:yaml/yaml.dart';
import 'package:localization_builder/localization_builder.dart';


final parser = YamlLocalizationParser();
final yaml = await File('example.yaml').readAsString();
final node = loadYaml(yaml);
final result = parser.parse(node);
```


### CSV Parsing

```dart
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:localization_builder/localization_builder.dart';

final parser = CsvLocalizationParser();
final csv = await File('example.csv').readAsBytes();
final rows = csv.transform(utf8.decoder)
        .transform(CsvToListConverter(
          shouldParseNumbers: false,
        ))
        .toList();
final result = parser.parse(rows);
```

### Generate Flutter localization code

```dart
import 'package:localization_builder/localization_builder.dart';

final code = DartLocalizationBuilder().build(result.result.copyWith(name: 'Example'));
print(code);
```

## Used by

* []