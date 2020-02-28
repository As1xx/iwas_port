import 'package:flutter/material.dart';
import 'package:iwas_port/Screens/Authenticate/Login/Login_notifier.dart';
import 'package:provider/provider.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';

class InputForm extends StatelessWidget {

  String _validateEmailForm(email) {
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      return 'Enter a valid Email';
    }
    return null;
  }

  String _validatePasswordForm(password) {
    if (password.length < 6) {
      return 'Enter a password 6+ chars long';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {

    final loginNotifier = Provider.of<LoginNotifier>(context);

    Icon _showObscureIcon() {
      if(loginNotifier.isObscure == true){
        return Icon(Icons.visibility_off,
            color: Theme.of(context).inputDecorationTheme.focusColor);
      }
        return Icon(Icons.visibility,
          color: Theme.of(context).inputDecorationTheme.focusColor);

    }

    return Form(
      key: loginNotifier.formKey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                style: Theme.of(context).inputDecorationTheme.labelStyle,
                validator: _validateEmailForm,
                controller: loginNotifier.emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Theme.of(context).inputDecorationTheme.focusColor,
                decoration: textFormDecoration(context).copyWith(
                  labelText: 'E-Mail',
                  prefixIcon: Icon(Icons.email,
                      color: Theme.of(context).inputDecorationTheme.focusColor),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: Theme.of(context).inputDecorationTheme.labelStyle,
                validator: _validatePasswordForm,
                controller: loginNotifier.passwordController,
                obscureText: loginNotifier.isObscure,
                keyboardType: TextInputType.text,
                cursorColor: Theme.of(context).inputDecorationTheme.focusColor,
                decoration: textFormDecoration(context).copyWith(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock,
                      color: Theme.of(context).inputDecorationTheme.focusColor),
                  suffixIcon: IconButton(
                    onPressed: () {
                      loginNotifier.isObscure = !loginNotifier.isObscure;
                    },
                    icon: _showObscureIcon(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

