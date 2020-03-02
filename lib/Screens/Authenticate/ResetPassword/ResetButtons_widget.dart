import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:iwas_port/Services/AuthException.dart';
import 'package:iwas_port/Services/AuthenticateService.dart';
import 'package:provider/provider.dart';
import 'package:vibrate/vibrate.dart';
import 'package:iwas_port/Screens/Authenticate/Login/Login_notifier.dart';


class ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginNotifier = Provider.of<LoginNotifier>(context);

    void _validatePasswordRecover() async {
      if (loginNotifier.formKey.currentState.validate()) {
        loginNotifier.isLoading = true;

        try {
           await AuthService().sendPasswordResetMail(
              loginNotifier.emailController.text,);
          Vibrate.feedback(FeedbackType.success);
          print('send password email ok!');
           Navigator.pop(context);
        } on AuthenException catch (_authError) {
          loginNotifier.isLoading = false;
          AuthenException.showError(context, _authError.message);
        } catch (_otherErrors) {
          loginNotifier.isLoading = false;
          AuthenException.showError(context, _otherErrors.message);
        }
      }
    }



    final myGradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Theme.of(context).backgroundColor,
          Theme.of(context).accentColor
        ],
        stops: [
          0.5,
          1
        ]);

    return Column(
      children: <Widget>[
        GradientButton(
          increaseWidthBy: 100,
          child: Text('Recover Password', style: Theme.of(context).textTheme.display1),
          callback: _validatePasswordRecover,
          gradient: myGradient,
          shadowColor: Theme.of(context).accentColor,
        ),
      ],
    );
  }
}
