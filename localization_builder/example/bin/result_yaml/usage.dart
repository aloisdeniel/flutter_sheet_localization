import 'package:intl/locale.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'labels.g.dart';

void main() {
  initializeDateFormatting();
  final locale = Locale.parse('fr');
  final labels = localizedLabels[locale]!;
  print(labels.templated.date
      .pattern(date: DateTime.now(), locale: locale.toString()));
}
