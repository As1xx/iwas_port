import 'package:flutter/material.dart';
import 'package:iwas_port/Models/ShapesPainter.dart';
import 'package:iwas_port/Screens/Loading/loading.dart';
import 'package:iwas_port/Screens/Authenticate/Login/Login_notifier.dart';
import 'package:iwas_port/Screens/Authenticate//Logo_widget.dart';
import 'package:provider/provider.dart';
import 'Buttons_widget.dart';
import 'InputForm_widget.dart';

class Login extends StatelessWidget {
  static const routeName = '/Login';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginNotifier>(create: (_) => LoginNotifier()),
      ],
      child: LoginNotifier().isLoading
          ? Loading()
          : Scaffold(
              appBar: AppBar(),
              body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: CustomPaint(
                    painter: ShapesPainter(
                        triangleColor: Theme.of(context).accentColor),
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        buildUnboxedLogo(context),
                        buildBoxedLogo(context),
                        SizedBox(height: 50),
                        InputForm(),
                        SizedBox(height: 20),
                        AuthButtons(),
                      ]),
                    ),
                  ))),
    );
  }
}
