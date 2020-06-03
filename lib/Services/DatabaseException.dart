import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
class DatabaseException implements Exception {

  final String message;

  DatabaseException(this.message);

  @override
  String toString() {
    return message;
  }

  static void showError(BuildContext context,String message){
    Vibrate.feedback(FeedbackType.error);
    FlushbarHelper.createError(
      message: message,
      duration: Duration(seconds: 3),
    ).show(context);
  }

}