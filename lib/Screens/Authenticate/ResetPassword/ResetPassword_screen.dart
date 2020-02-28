import 'package:flutter/material.dart';
import 'package:iwas_port/Models/ShapesPainter.dart';
import 'package:iwas_port/Screens/Authenticate/ResetPassword/ResetButtons_widget.dart';
import 'package:iwas_port/Screens/Authenticate/ResetPassword/ResetInputForm_widget.dart';
import 'package:iwas_port/Screens/Loading/loading.dart';
import 'package:iwas_port/Screens/Authenticate/Login/Login_notifier.dart';
import 'package:iwas_port/Screens/Authenticate/Logo_widget.dart';
import 'package:provider/provider.dart';


class ResetPassword extends StatelessWidget {

  static const routeName = '/resetPassword';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginNotifier(),
        child: LoginNotifier().isLoading
            ? Loading()
            : Scaffold(
            appBar: AppBar(
              iconTheme: Theme.of(context).appBarTheme.actionsIconTheme,
            ),
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
                      ResetInputForm(),
                      SizedBox(height: 20),
                      ResetButton(),
                    ]),
                  ),
                )
            )
        )
    );
  }
}
