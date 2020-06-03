import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:iwas_port/Services/AuthException.dart';
import 'package:iwas_port/Screens/Authenticate/ResetPassword/ResetPassword_screen.dart';
import 'package:iwas_port/Screens/Home/Home.dart';
import 'package:iwas_port/Services/AuthenticateService.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:iwas_port/Screens/Authenticate/Login/Login_notifier.dart';


class AuthButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginNotifier = Provider.of<LoginNotifier>(context);

    void _validateSignUp() async {
      if (loginNotifier.formKey.currentState.validate()) {
        loginNotifier.isLoading = true;

        try {
           await AuthService().registerWithEmailAndPassword(
              loginNotifier.emailController.text,
              loginNotifier.passwordController.text);
          Vibrate.feedback(FeedbackType.success);
          Navigator.pushNamed(context, Home.routeName);
          print('Register OK');
        } on AuthenException catch (_authError) {
          loginNotifier.isLoading = false;
          AuthenException.showError(context, _authError.message);

        } catch (_otherErrors) {
          loginNotifier.isLoading = false;
          AuthenException.showError(context, _otherErrors.message);
        }
      }
    }

    void _validateLogin() async {
      if (loginNotifier.formKey.currentState.validate()) {
        loginNotifier.isLoading = true;
        try {
          await AuthService().signInWithEmailAndPassword(
              loginNotifier.emailController.text,
              loginNotifier.passwordController.text);
          Vibrate.feedback(FeedbackType.success);
         Navigator.pushNamed(context, Home.routeName);
          print('Login OK');
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
          increaseWidthBy: 150,
          child: Text('Registrieren', style: Theme.of(context).textTheme.headline4),
          callback: _validateSignUp,
          gradient: myGradient,
          shadowColor: Theme.of(context).accentColor,
        ),
        SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Bereits registriert?\n',
            style: Theme.of(context).textTheme.headline4,
            children: <TextSpan>[
              TextSpan(
                text: 'Log In',
                recognizer: TapGestureRecognizer()..onTap = _validateLogin,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Theme.of(context).accentColor),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, ResetPassword.routeName),
          child: Text('Passwort vergessen?',
              style: Theme.of(context).textTheme.headline4),
        )
      ],
    );
  }
}
