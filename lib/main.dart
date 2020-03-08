import 'package:flutter/material.dart';
import 'package:iwas_port/Locales/AppLocales.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Models/user.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Authenticate/ResetPassword/ResetPassword_screen.dart';
import 'package:iwas_port/Screens/Authenticate/isLogged_widget.dart';
import 'package:iwas_port/Screens/Drawer/Location/AddLocation_screen.dart';
import 'package:iwas_port/Screens/Drawer/Location/EditLocation_screen.dart';
import 'package:iwas_port/Screens/Drawer/Location/Location_screen.dart';
import 'package:iwas_port/Screens/Drawer/Wine/Wine_screen.dart';
import 'package:iwas_port/Services/AuthenticateService.dart';
import 'package:iwas_port/Screens/Authenticate/Login/Login_screen.dart';
import 'package:iwas_port/Services/LocationDatabaseService.dart';
import 'package:iwas_port/Services/WineDatabaseService.dart';
import 'package:iwas_port/Themes/DarkAppTheme.dart';
import 'package:iwas_port/Themes/LightAppTheme.dart';
import 'package:provider/provider.dart';
import 'Screens/Drawer/Wine/AddWine_sceen.dart';
import 'Screens/Drawer/Wine/EditWine_screen.dart';
import 'Screens/Home/Home.dart';
import 'Screens/Loading/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WineDatabaseService _wineDatabaseService = WineDatabaseService();
  final LocationDatabaseService _locationDatabaseService = LocationDatabaseService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Wine>>(
            initialData: [],
            create: (_) => _wineDatabaseService.wineListOfCollection),
        StreamProvider<User>(
          initialData: User(email: ''),
          create: (_) => AuthService().user,
        ),
        StreamProvider<List<Location>>(
            initialData: [],
            create: (_) => _locationDatabaseService.locationListOfCollection),
      ],
      child: MaterialApp(
          theme: darkAppTheme,
          supportedLocales: supportedLocales,
          localizationsDelegates: localizationsDelegates,
          // Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) =>
              localeResolutionCallback(locale, supportedLocales),
          home: IsLogged(),
          routes: {
            Home.routeName: (ctx) => Home(),
            Login.routeName: (ctx) => Login(),
            ResetPassword.routeName: (ctx) => ResetPassword(),
            WineScreen.routeName: (ctx) => WineScreen(),
            AddWine.routeName: (ctx) => AddWine(),
            EditWine.routeName: (ctx) => EditWine(),
            LocationScreen.routeName: (ctx) => LocationScreen(),
            AddLocation.routName: (ctx) => AddLocation(),
            EditLocation.routeName: (ctx) => EditLocation(),
          }),
    );
  }
}
