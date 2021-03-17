import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _currentLocale;

  @override
  void initState() {
    _currentLocale = AppLocalizations.languages.keys.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: _currentLocale,
      localizationsDelegates: [
        const AppLocalizationsDelegate(), // <- Your custom delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales:
          AppLocalizations.languages.keys.toList(), // <- Supported locales
      home: MyHomePage(
        title: 'Internationalization demo',
        locale: _currentLocale,
        onLocaleChanged: (locale) {
          if (_currentLocale != locale) {
            setState(() => _currentLocale = locale);
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.locale,
    required this.onLocaleChanged,
  }) : super(key: key);

  final String title;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context)!; // <- Accessing your labels
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          DropdownButton<Locale>(
            key: Key('Picker'),
            value: locale,
            items: AppLocalizations.languages.keys.map((locale) {
              return DropdownMenuItem<Locale>(
                value: locale,
                child: Text(
                  locale.toString(),
                ),
              );
            }).toList(),
            onChanged: (_) => onLocaleChanged,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(labels.actions.add),
                Text(labels.address.neighborhood.title),
                /*
                Text(labels.templated.datetime(DateFormatter.yMd,
                    now: DateTime.now().add(Duration(days: 2)))),
                Text(labels.amount(NumberFormatter.currency, amount: 1000000)),
                Text(labels.amount(NumberFormatter.compactCurrency,
                    amount: 1000000)),
                Text(labels.amount(NumberFormatter.decimalPattern,
                    amount: 1000000.101)),
                Text(labels.amount(null, amount: 1000000)),
                */
              ],
              // Displaying templated label
            ),
          ),
        ],
      ),
    );
  }
}
