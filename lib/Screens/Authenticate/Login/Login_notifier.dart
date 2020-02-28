import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier{

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isObscure = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  GlobalKey<FormState> get formKey => _formKey;

  set formKey(GlobalKey<FormState> value) {
    _formKey = value;
    notifyListeners();
  }


  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isObscure => _isObscure;

  set isObscure(bool value) {
    _isObscure = value;
    notifyListeners();
  }

  TextEditingController get passwordController => _passwordController;

  set passwordController(TextEditingController value) {
    _passwordController = value;
    notifyListeners();
  }

  TextEditingController get emailController => _emailController;

  set emailController(TextEditingController value) {
    _emailController = value;
    notifyListeners();
  }


}