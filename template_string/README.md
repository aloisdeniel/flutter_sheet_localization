# template_string

Simple string formatting from inline templates.

## Usage

```dart
 print(
    'Hello {{first_name[lowercase]}}! Your score is {{score:Int[percentPattern]}} as of {{date:DateTime[yMMMM]}}.'
        .insertTemplateValues(
      {
        'first_name': 'John',
        'score': 67.8,
        'date': DateTime.now(),
      },
      Locale.parse('en'),
    ),
  );
// Hello John! Your score is 6,780% as of March 2021.
```