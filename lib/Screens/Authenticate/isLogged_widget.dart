import 'package:flutter/material.dart';
import 'package:iwas_port/Models/user.dart';
import 'package:iwas_port/Screens/Home/Home.dart';
import 'package:iwas_port/Screens/Authenticate/Login/Login_screen.dart';
import 'package:provider/provider.dart';


class IsLogged extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context) ?? null;
    // return either Home or Login Screen depending onAuthState Listener
    // implemented in Authenticate Service as Stream and wrapped in main
    return user == null ? Login() : Home();
  }
}
