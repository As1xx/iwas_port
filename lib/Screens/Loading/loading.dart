import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iwas_port/styles/background_style.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Center(
        child: SpinKitFadingCircle(
          color: Theme.of(context).accentColor,
          size: 100,
        ),
      ),
    );
  }
}