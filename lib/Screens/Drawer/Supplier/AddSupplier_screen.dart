import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';
import 'package:iwas_port/Services/DatabaseException.dart';
import 'package:iwas_port/Services/SupplierDatabaseService.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:string_validator/string_validator.dart';

class AddSupplier extends StatefulWidget {
  static const routeName = '/AddSupplier';

  @override
  _AddSupplierState createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  final _databaseService = SupplierDatabaseService();
  final _formKey = GlobalKey<FormState>();
  final _supplier = Supplier.empty();
  bool isLoading;
  bool switchState = true;

  String _checkInteger(String text) {
    if (text.isEmpty) {
      return 'Please specify Field';
    } else if (!isInt(text)) {
      return 'Please Enter Number 0-9';
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    void _validateForm() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        _supplier.isDefault = switchState;

        try {
          await _databaseService.writeToDatabase(_supplier);
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
        title: Text('Add Supplier'),
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
                    onSaved: (text) => _supplier.name = text,
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
                    onSaved: (text) => _supplier.zipCode = int.parse(text),
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => _checkInteger(text),
                    keyboardType: TextInputType.numberWithOptions(),
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Zip Code',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (text) => _supplier.address = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.text,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Address',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (text) => _supplier.country = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.text,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Country',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (text) => _supplier.email = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (text) => _supplier.phoneNumber = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.phone,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'PhoneNumber',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (text) => _supplier.taxNumber = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.number,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'TaxNumber',
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Is Default?',
                        style: Theme.of(context).textTheme.display1,
                      ),
                      Spacer(),
                      Switch(
                        value: switchState,
                        onChanged: (bool state) {
                          setState(() {
                            switchState = state;
                          });
                        },
                      )
                    ],
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
