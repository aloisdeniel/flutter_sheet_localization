import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale;

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
        locale: this._currentLocale,
        onLocaleChanged: (locale) {
          if (this._currentLocale != locale) {
            this.setState(() => this._currentLocale = locale);
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage(
      {Key key,
      this.title,
      @required this.locale,
      @required this.onLocaleChanged})
      : super(key: key);

  final String title;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context); // <- Accessing your labels
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Column(
        children: <Widget>[
          DropdownButton<Locale>(
            key: Key("Picker"),
            value: this.locale,
            items: AppLocalizations.languages.keys.map((locale) {
              return DropdownMenuItem<Locale>(
                value: locale,
                child: Text(
                  locale.toString(),
                ),
              );
            }).toList(),
            onChanged: this.onLocaleChanged,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(labels.dates.month.february),
                Text(labels.templated.hello(firstName: "World")),
                Text(labels.templated.contact(Gender.male, lastName: "John")),
                Text(labels.templated.contact(Gender.female, lastName: "Jane")),
                Text("0 " + labels.plurals.man(plural(0))),
                Text("1 " + labels.plurals.man(plural(1))),
                Text("5 " + labels.plurals.man(plural(5))),
              ],
              // Displaying templated label
            ),
          ),
        ],
      ),
    );
  }
}
