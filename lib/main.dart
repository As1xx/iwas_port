import 'package:flutter/material.dart';
import 'package:iwas_port/Locales/AppLocales.dart';
import 'package:iwas_port/Models/user.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Authenticate/ResetPassword/ResetPassword_screen.dart';
import 'package:iwas_port/Screens/Authenticate/isLogged_widget.dart';
import 'package:iwas_port/Screens/Drawer/Wine_screen.dart';
import 'package:iwas_port/Services/AuthenticateService.dart';
import 'package:iwas_port/Screens/Authenticate/Login/Login_screen.dart';
import 'package:iwas_port/Themes/AppTheme.dart';
import 'package:provider/provider.dart';
import 'Screens/Drawer/AddWine_sceen.dart';
import 'Screens/Home/Home.dart';
import 'Screens/Loading/loading.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: appTheme,


        supportedLocales: supportedLocales,
        localizationsDelegates: localizationsDelegates,
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) => localeResolutionCallback(locale, supportedLocales),

        home: AddWine(),
        routes: {
          Home.routeName: (ctx) => Home(),
          Login.routeName: (ctx) => Login(),
          ResetPassword.routeName: (ctx) => ResetPassword(),
          WineScreen.routName: (ctx) => WineScreen(),
          AddWine.routName: (ctx) => AddWine(),}

      ),
    );
  }
}
