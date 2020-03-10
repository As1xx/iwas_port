import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';
import 'package:iwas_port/Services/CustomerDatabaseService.dart';
import 'package:iwas_port/Services/DatabaseException.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:string_validator/string_validator.dart';

class EditCustomer extends StatefulWidget {
  static const routeName = '/EditCustomer';

  @override
  _EditCustomerState createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final _databaseService = CustomerDatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading;



  Widget build(BuildContext context) {
    final Customer _customer = ModalRoute.of(context).settings.arguments;

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
          await _databaseService.writeToDatabase(_customer);
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
        title: Text('Edit Customer'),
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
                    initialValue: _customer.name,
                    onSaved: (text) => _customer.name = text,
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
                    initialValue: _customer.zipCode.toString(),
                    onSaved: (text) => _customer.zipCode = int.parse(text),
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => _checkInteger(text),
                    keyboardType: TextInputType.number,
                    cursorColor:
                    Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Zip Code',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: _customer.address,
                    onSaved: (text) => _customer.address = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.text,
                    cursorColor:
                    Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Address',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _customer.country,
                    onSaved: (text) => _customer.country = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.text,
                    cursorColor:
                    Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Country',
                    ),
                  ),
                  SizedBox(height:20),
                  TextFormField(
                    initialValue: _customer.email,
                    onSaved: (text) => _customer.email = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height:20),
                  TextFormField(
                    initialValue: _customer.phoneNumber,
                    onSaved: (text) => _customer.phoneNumber = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.phone,
                    cursorColor: Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'PhoneNumber',
                    ),
                  ),
                  SizedBox(height:20),
                  TextFormField(
                    initialValue: _customer.taxNumber,
                    onSaved: (text) => _customer.taxNumber = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => text.isEmpty ? 'Please specify Field' : null,
                    keyboardType: TextInputType.number,
                    cursorColor: Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'TaxNumber',
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Default Location?',style: Theme.of(context).textTheme.display1,),
                      Spacer(),
                      Switch(
                        value: _customer.isInvoiceAddress,
                        onChanged: (bool state){
                          setState(() {
                            _customer.isInvoiceAddress = state;
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
