import 'package:intl/date_symbol_data_local.dart';
import 'package:template_string/template_string.dart';

void main() {
  initializeDateFormatting();

  print(
    'Hello {{first_name[lowercase]}}! Your score is {{score:Int[percentPattern]}} as of {{date:DateTime[yMMMM]}}.'
        .insertTemplateValues(
      {
        'first_name': 'John',
        'score': 67.8,
        'date': DateTime.now(),
      },
      locale: 'en',
    ),
  );
}
