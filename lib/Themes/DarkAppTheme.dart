import 'package:flutter/material.dart';

final darkAppTheme = ThemeData(
    //fontFamily: 'Neutra-Display',
    primaryColor: Colors.black,
    accentColor: Colors.purple,
    backgroundColor: Colors.black.withOpacity(0.9),
    focusColor: Colors.purple,
    errorColor: Colors.red,
    highlightColor: Colors.white,
    cursorColor: Colors.white,
    unselectedWidgetColor: Colors.white,



    accentTextTheme: TextTheme(
      button: TextStyle(color: Colors.white, fontSize: 14),
    ),



    textTheme: TextTheme(
      caption: TextStyle(color: Colors.white, fontSize: 18),
      headline1: TextStyle(color: Colors.white, fontSize: 20),
      headline2: TextStyle(color: Colors.white, fontSize: 18),
      headline3: TextStyle(color: Colors.white, fontSize: 16),
      headline4: TextStyle(color: Colors.white, fontSize: 14),
      headline5: TextStyle(color: Colors.white, fontSize: 12),
      headline6: TextStyle(color: Colors.white, fontSize: 10),
      bodyText1: TextStyle(color: Colors.white, fontSize: 14),
      bodyText2: TextStyle(color: Colors.white, fontSize: 12),
      button: TextStyle(color: Colors.white, fontSize: 16),
    ),

    appBarTheme: AppBarTheme(
      color: Colors.black,
      textTheme: TextTheme(
        caption: TextStyle(color: Colors.white, fontSize: 18),
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
      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
      prefixStyle: TextStyle(color: Colors.white),
      suffixStyle: TextStyle(color: Colors.white),
      errorStyle: TextStyle(color: Colors.red,fontSize: 12),
      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
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
      color: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    ),

    dialogTheme: DialogTheme(
      backgroundColor:  Colors.grey[800].withOpacity(0.9),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 14),
      contentTextStyle: TextStyle(color: Colors.white, fontSize: 18),
    ),

    popupMenuTheme: PopupMenuThemeData(
    ),

);
