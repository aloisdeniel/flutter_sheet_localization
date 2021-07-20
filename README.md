# Flutter Google Sheet localizations generator

Generates a localizations delegate from an online Google Sheet file.

## Install

Add the following to your `pubspec.yaml`:

```sh
dependencies:
  flutter_sheet_localization: <latest>
  flutter_localizations:
    sdk: flutter

dev_dependencies:
  flutter_sheet_localization_generator: <latest>
  build_runner: <latest>
```

### Usage

#### 1. Create a Google Sheet

Create a sheet with your translations (following the bellow format, [an example sheet is available here](https://docs.google.com/spreadsheets/d/1AcjI1BjmQpjlnPUZ7aVLbrnVR98xtATnSjU4CExM9fs/edit#gid=0)) :

![example](https://github.com/aloisdeniel/flutter_sheet_localization/raw/master/flutter_sheet_localization_generator/example.png)

Make sure that your sheet is shared :

![share](https://github.com/aloisdeniel/flutter_sheet_localization/raw/master/flutter_sheet_localization_generator/share.png)

Extract from the link the `DOCID` and `SHEETID` values : `https://docs.google.com/spreadsheets/d/<DOCID>/edit#gid=<SHEETID>`) :

#### 2. Declare a localization delegate

Declare the following `AppLocalizationsDelegate` class with the `SheetLocalization` annotation pointing to your sheet in a `lib/localization.dart` file :

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

part 'localization.g.dart';

extension AppLocalizationsExtensions on BuildContext {
  AppLocalizationsData get localizations {
    return Localizations.of<AppLocalizationsData>(this, AppLocalizationsData)!;
  }
}

@SheetLocalization("DOCID", "SHEETID", 1) // <- See 1. to get DOCID and SHEETID
// the `1` is the generated version. You must increment it each time you want to regenerate
// a new version of the labels.
class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizationsData> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => localizedLabels.containsKey(locale);

  @override
  Future<AppLocalizationsData> load(Locale locale) =>
      SynchronousFuture<AppLocalizationsData>(localizedLabels[locale]!);
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

```

#### 3. Generate your localizations

Run the following command to generate a `lib/localization.g.dart` file :

```
flutter packages pub run build_runner build
```

#### 4. Configure your app

Update your Flutter app with your newly created delegate :

```dart
MaterialApp(
    locale: localizedLabels.keys.first, // <- Current locale
    localizationsDelegates: [
    const AppLocalizationsDelegate(), // <- Your custom delegate
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales:
        localizedLabels.keys.first, // <- Supported locales
    // ...
);
```

#### 5. Display your labels

```dart
print(context.localizations.dates.month.february);
print(context.localizations.templated.hello(firstName: "World"));
print(context.localizations.templated.contact(Gender.male, lastName: "John"));
```

## Regeneration

Because of the caching system of the build_runner, it can't detect if there is a change on the distant sheet and it can't know if a new generation is needed.

The `version` parameter of the `@SheetLocalization` annotation solves this issue.

Each time you want to trigger a new generation, simply increment that version number and call the build runner again.

## Google Sheet format

You can see [an example sheet here](https://docs.google.com/spreadsheets/d/1AcjI1BjmQpjlnPUZ7aVLbrnVR98xtATnSjU4CExM9fs/edit#gid=0).

### Global format

The file should have :

* A first header row
  * Column 0 : "Key"
  * then each supported language code ("en", "fr", ...)
* Following rows for labels
  * Column 0 : the label key (can be a hierarchy, separated by dots)
  * then each translation based on language code of the column

### Ignoring a column

Sometimes you may need to add comments for translators. For this, simply add a column with a name between parenthesis and the column will be completely ignored by the generator.

Example :

> | Key | (Comments) | fr | en |
> | --- | --- | --- | --- |
> | example.man(Gender.male) | This is a man title on home page | homme | man |
> | example.man(Gender.female) | This is a woman title on home page | femme | woman |

### Conditionals

It is pretty common to have variants of a label based on a condition (for example: Genders, Plurals, ...).

Simply duplicate your entries and end them with `(<ConditionName>.<ConditionCase)`.


Example :

> | Key | fr | en |
> | --- | --- | --- |
> | example.man(Gender.male) | homme | man |
> | example.man(Gender.female) | femme | woman |

See [example](example) for more details.

#### Plurals

The conditionals can be used the same way for plurals :

Example :

> | Key | fr | en |
> | --- | --- | --- |
> | example.man(Plural.zero) | hommes |	man |
> | example.man(Plural.one) | homme | man |
> | example.man(Plural.multiple) | hommes | men |

From your Dart code, you can then define an extension :

```dart
extension PluralExtension on int {
  Plural plural() {
    if (this == 0) return Plural.zero;
    if (this == 1) return Plural.one;
    return Plural.multiple;
  }
}
```

See [example](example) for more details.

### Dynamic labels

You can insert a `{{KEY}}` template into a translation value to have dynamic labels.

A Dart function will be generated to be used from your code.

```
/// Sheet
values.hello, "Hello {{first_name}}!"

/// Code
print(labels.values.hello(firstName: "World"));
```

#### Typed parameters

You can also add one of the compatible types (`int`, `double`, `num`, `DateTime`) to the parameter by suffixing its key with `:<type>`.

```
/// Sheet
values.price, "The price is {{price:double}}\$"

/// Code
print(labels.values.price(price: 10.5));
```

#### Formatted parameters

You can indicate how the templated value must be formatted by ending the value with a formatting rule in brackets `[<rule-key>]`. This can be particulary useful for typed parameters.

The available formatting rules depend on the type and generally rely on the `intl` package.

> | Type | rule-key| Generated code |
> | --- | --- | --- |
> | `double`, `int`, `num` | `decimalPercentPattern`, `currency`, `simpleCurrency`, `compact`, `compactLong`, `compactSimpleCurrency`, `compactCurrency`, `decimalPattern`, `percentPattern`, `scientificPattern` |	`NumberFormat.<rule-key>(...)` |
> | `DateTime` | Any date format valid pattern  |	`DateFormat('<rule-key>', ...).format(...)` |

Examples:

```
/// Sheet
values.price, "Price : {{price:double[compactCurrency]}}"

/// Code
print(labels.values.price(price: 2.00));
```

```
/// Sheet
values.today, "Today : {{date:DateTime[EEE, M/d/y]}}"

/// Code
print(labels.values.today(date: DateTime.now()));
```


## Why ?

I find the Flutter internationalization tools not really easy to use, and I wanted a simple tool for sharing translations. Most solutions also use string based keys, and I wanted to generate pure dart code to improve permormance.
