# Flutter localizations generator from CSV files.

Generates a localizations delegate from a CSV file.

## Usage

Install globally the tool :

```sh
$ pub global activate flutter_csv_localization
```

Then run the generator :

```dart
$ pub global run flutter_csv_localization:generate -o example.g.dart example.csv
```

## Example

[.csv](example/lib/example.csv) -> [.dart](example/lib/example.g.dart)

## CSV format

The csv file should have :

* Row
  * Column 0 : "Key"
  * then each supported language code ("en", "fr", ...)
* Following rows for labels
  * Column 0 : the label key (can be a hierarchy, separated by dots)
  * then each translation based on language code of the column

![example](example.png)

```csv
Key,fr,en
dates.weekday.monday,lundi,monday
dates.weekday.tuesday,mardi,tuesday
dates.weekday.wednesday,mercredi,wednesday
dates.weekday.thursday,jeudi,thursday
dates.weekday.friday,vendredi,friday
dates.weekday.saturday,samedi,saturday
dates.weekday.sunday,dimanche,sunday
```

## Roadmap / Ideas

* [ ] Multiple values per label (plural, gender, ...)
* [ ] Native labels (plist, xml, ...)

## Why ?

I find the Flutter internationalization tools not really easy to use, and I wanted a simple tool for sharing translations.

