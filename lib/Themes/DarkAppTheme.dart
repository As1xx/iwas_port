import 'package:flutter/material.dart';

final darkAppTheme = ThemeData(
    //fontFamily: 'Neutra-Display',
    primaryColor: Colors.black,
    accentColor: Colors.purple,
    backgroundColor: Colors.black.withOpacity(0.9),
    focusColor: Colors.purple,
    errorColor: Colors.red,
    highlightColor: Colors.white,
    dialogBackgroundColor: Colors.grey[800].withOpacity(0.5),
    cursorColor: Colors.white,
    cardColor: Colors.black,
    unselectedWidgetColor: Colors.white,

    accentTextTheme: TextTheme(
      button: TextStyle(color: Colors.purple, fontSize: 14),
    ),



    textTheme: TextTheme(
      title: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 10),
      caption: TextStyle(color: Colors.white, fontSize: 16),
      display1: TextStyle(color: Colors.white, fontSize: 16),
      subtitle: TextStyle(color: Colors.white, fontSize: 12),
      headline: TextStyle(color: Colors.white, fontSize: 12),
      body1: TextStyle(color: Colors.white, fontSize: 20),
      body2: TextStyle(color: Colors.white, fontSize: 24),
      subhead: TextStyle(color: Colors.white, fontSize: 16),
      button: TextStyle(color: Colors.white, fontSize: 16),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.black,
      textTheme: TextTheme(
        title: TextStyle(color: Colors.white, fontSize: 20),
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black,
      focusColor: Colors.white,
      contentPadding: EdgeInsets.all(10.0),
      labelStyle: TextStyle(color: Colors.white, fontSize: 14),
      prefixStyle: TextStyle(color: Colors.white),
      suffixStyle: TextStyle(color: Colors.white),
      errorStyle: TextStyle(color: Colors.red,fontSize: 11),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white,width: 0.5),
       borderRadius: BorderRadius.circular(20.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple,width: 0.5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,width: 0.5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple,width: 0.5),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
      highlightColor: Colors.white,
    ),
    snackBarTheme: SnackBarThemeData(),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.white,
      thickness: 1,
    ),

    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    )

);
