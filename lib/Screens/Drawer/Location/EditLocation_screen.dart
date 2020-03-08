import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';
import 'package:iwas_port/Services/DatabaseException.dart';
import 'package:iwas_port/Services/LocationDatabaseService.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:string_validator/string_validator.dart';

class EditLocation extends StatefulWidget {
  static const routeName = '/EditLocation';

  @override
  _EditLocationState createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  final _databaseService = LocationDatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading;
  bool switchState;


  Widget build(BuildContext context) {
    final Location _location = ModalRoute.of(context).settings.arguments;


    String _checkInteger(String text) {
      if (text.isEmpty) {
        return 'Please specify Field';
      } else if (!isInt(text)) {
        return 'Please Enter Number 0-9';
      } else {
        return null;
      }
    }



    void _validateForm() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();


        try {
          await _databaseService.writeToDatabase(_location);
          FlushbarHelper.createSuccess(
              message: 'Data successfully uploaded to Cloud')
              .show(context);
          //Navigator.of(context).pop();
        } on DatabaseException catch (error) {
          DatabaseException.showError(context, error.message);
        } catch (otherError) {
          DatabaseException.showError(context, otherError.message);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text('Edit Location'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _validateForm,
          ),
        ],
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: _location.name,
                    onSaved: (text) => _location.name = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                    text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.text,
                    cursorColor:
                    Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: _location.zipCode.toString(),
                    onSaved: (text) => _location.zipCode = int.parse(text),
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => _checkInteger(text),
                    keyboardType: TextInputType.text,
                    cursorColor:
                    Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Zip Code',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: _location.address,
                    onSaved: (text) => _location.address = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.number,
                    cursorColor:
                    Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Address',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _location.country,
                    onSaved: (text) => _location.country = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.number,
                    cursorColor:
                    Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Country',
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Default Location?',style: Theme.of(context).textTheme.display1,),
                      Spacer(),
                      Switch(
                      value: _location.isDefault,
                      onChanged: (bool state){
                        setState(() {
                          switchState = state;
                          _location.isDefault = state;
                        });
                      },
                    )],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
