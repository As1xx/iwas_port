import 'package:flutter/material.dart';

final lightAppTheme = ThemeData(
  //fontFamily: 'Neutra-Display',
    primaryColor: Colors.white,
    accentColor: Colors.purple,
    backgroundColor: Colors.white,
    focusColor: Colors.purple,
    errorColor: Colors.red,
    highlightColor: Colors.purple,
    dialogBackgroundColor: Colors.grey[800].withOpacity(0.5),
    cursorColor: Colors.black,
    textTheme: TextTheme(
      title: TextStyle(color: Colors.black, fontSize: 24, letterSpacing: 10),
      caption: TextStyle(color: Colors.black, fontSize: 16),
      display1: TextStyle(color: Colors.black, fontSize: 16),
      subtitle: TextStyle(color: Colors.black, fontSize: 12),
      headline: TextStyle(color: Colors.black, fontSize: 12),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      textTheme: TextTheme(
        title: TextStyle(color: Colors.black, fontSize: 26),
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      focusColor: Colors.purple,
      contentPadding: EdgeInsets.all(10.0),
      labelStyle: TextStyle(color: Colors.black, fontSize: 18),
      prefixStyle: TextStyle(color: Colors.black),
      suffixStyle: TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(20.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple),
        borderRadius: BorderRadius.circular(20.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(20.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      highlightColor: Colors.purple,
    ),
    snackBarTheme: SnackBarThemeData(),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.black,
      thickness: 1,
    ),

    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    ));
