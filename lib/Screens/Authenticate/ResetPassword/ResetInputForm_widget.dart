import 'package:flutter/material.dart';
import 'package:iwas_port/Screens/Authenticate/Login/Login_notifier.dart';
import 'package:provider/provider.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';

class ResetInputForm extends StatelessWidget {
  String _validateEmailForm(email) {
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      return 'Enter a valid Email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final loginNotifier = Provider.of<LoginNotifier>(context);

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
            ],
          ),
        ),
      ),
    );
  }
}
