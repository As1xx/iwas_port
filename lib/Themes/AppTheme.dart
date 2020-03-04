import 'package:flutter/material.dart';

final appTheme = ThemeData(
  //fontFamily: 'Neutra-Display',
  primaryColor: Colors.white,
  accentColor: Colors.purple,
  backgroundColor: Colors.black.withOpacity(0.9),
  focusColor: Colors.purple,
  errorColor: Colors.red,
  highlightColor: Colors.white,
  dialogBackgroundColor: Colors.grey[800].withOpacity(0.5) ,
  cursorColor: Colors.white,

  textTheme: TextTheme(
    title: TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 10),
    caption: TextStyle(color: Colors.white, fontSize: 16),
    display1: TextStyle(color: Colors.white, fontSize: 16),
    subtitle: TextStyle(color: Colors.white, fontSize: 12),
    headline: TextStyle(color: Colors.white, fontSize: 12),

  ),

  appBarTheme: AppBarTheme(
    color: Colors.black,
    textTheme: TextTheme(
      title: TextStyle(color: Colors.white, fontSize: 26),
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
    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
    prefixStyle: TextStyle(color: Colors.white),
    suffixStyle: TextStyle(color: Colors.white),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
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


);
