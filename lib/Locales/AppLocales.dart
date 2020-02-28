import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'AppLocalization.dart';

final supportedLocales = [
  Locale('en', 'US'),
  Locale('de', 'GER'),
];

// These delegates make sure that the localization data for the proper language is loaded
final localizationsDelegates = [
// THIS CLASS WILL BE ADDED LATER
// A class which loads the translations from JSON files
  AppLocalizations.delegate,
// Built-in localization of basic text for Material widgets
  GlobalMaterialLocalizations.delegate,
// Built-in localization for text direction LTR/RTL
  GlobalWidgetsLocalizations.delegate,
];

// Returns a locale which will be used by the app
dynamic localeResolutionCallback(locale, supportedLocales) {
// Check if the current device locale is supported
  for (var supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode &&
        supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }
// If the locale of the device is not supported, use the first one
// from the list (English, in this case).
  return supportedLocales.first;
}
