import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:iwas_port/Screens/Authenticate//AuthException.dart';
import 'package:iwas_port/Screens/Authenticate/ResetPassword/ResetPassword_screen.dart';
import 'package:iwas_port/Screens/Home/Home.dart';
import 'package:iwas_port/Services/AuthenticateService.dart';
import 'package:provider/provider.dart';
import 'package:vibrate/vibrate.dart';
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
        } on AuthException catch (_authError) {
          Vibrate.feedback(FeedbackType.error);
          loginNotifier.isLoading = false;
          FlushbarHelper.createError(
            message: _authError.message,
            duration: Duration(seconds: 3),
          ).show(context);
        } catch (_otherErrors) {
          Vibrate.feedback(FeedbackType.error);
          loginNotifier.isLoading = false;
          FlushbarHelper.createError(
            message: _otherErrors.message,
            duration: Duration(seconds: 3),
          ).show(context);
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
        } on AuthException catch (_authError) {
          Vibrate.feedback(FeedbackType.error);
          loginNotifier.isLoading = false;
          FlushbarHelper.createError(
            message: _authError.message,
            duration: Duration(seconds: 3),
          ).show(context);
        } catch (_otherErrors) {
          Vibrate.feedback(FeedbackType.error);
          loginNotifier.isLoading = false;
          FlushbarHelper.createError(
            message: _otherErrors.message,
            duration: Duration(seconds: 3),
          ).show(context);
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
          child: Text('SignUp', style: Theme.of(context).textTheme.display1),
          callback: _validateSignUp,
          gradient: myGradient,
          shadowColor: Theme.of(context).accentColor,
        ),
        SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Already have an account?\n',
            style: Theme.of(context).textTheme.display1,
            children: <TextSpan>[
              TextSpan(
                text: 'Log In',
                recognizer: TapGestureRecognizer()..onTap = _validateLogin,
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(color: Theme.of(context).accentColor),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, ResetPassword.routeName),
          child: Text('Forgot Password?',
              style: Theme.of(context).textTheme.display1),
        )
      ],
    );
  }
}
