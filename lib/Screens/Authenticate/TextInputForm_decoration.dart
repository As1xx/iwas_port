import 'package:flutter/material.dart';

InputDecoration textFormDecoration(context) {
  return InputDecoration(
    filled: true,
    prefixStyle: Theme.of(context).inputDecorationTheme.prefixStyle,
    suffixStyle: Theme.of(context).inputDecorationTheme.suffixStyle,
    labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
    contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
    enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
    focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
    errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
    focusedErrorBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
  );
}
