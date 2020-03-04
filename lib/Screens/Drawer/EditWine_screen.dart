import 'dart:io';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';
import 'package:iwas_port/Screens/Drawer/SelectPhoto_widget.dart';
import 'package:iwas_port/Services/DatabaseException.dart';
import 'package:iwas_port/Services/DatabaseService.dart';
import 'package:iwas_port/Services/ImageException.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

class EditWine extends StatefulWidget {
  static const routName = '/EditWine';

  @override
  _EditWineState createState() => _EditWineState();
}

class _EditWineState extends State<EditWine> {
  final _databaseService = WineDatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading;
  File myImageFile;

//TODO: validate is numeric
  Widget build(BuildContext context) {
    final Wine _wine = ModalRoute.of(context).settings.arguments;

    void _updateImage(File imageFile) {
      setState(() {
        myImageFile = imageFile;
      });
    }

    _showActionDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext context) => SelectPhoto(_updateImage));
    }

    void _validateForm() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        try {
          await _databaseService.uploadImage(myImageFile, _wine);
        } on ImageException catch (error) {
          isLoading = false;
          ImageException.showError(context, error.message);
        } catch (otherError) {
          ImageException.showError(context, otherError.message);
        }

        try {
          await _databaseService.writeToDatabase(_wine);
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
        title: Text('Edit Wine'),
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
                  IconButton(
                    iconSize: 100,
                    icon: Image(
                      image: NetworkToFileImage(
                        url: _wine.imageURL,
                        file: myImageFile,
                      ),
                    ),
                    onPressed: () => _showActionDialog(),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: _wine.manufacturer,
                    onSaved: (text) => _wine.manufacturer = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Please Enter Manufacturer' : null,
                    keyboardType: TextInputType.text,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Manufacturer',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: _wine.type,
                    onSaved: (text) => _wine.type = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Please Enter Type' : null,
                    keyboardType: TextInputType.text,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Type',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: _wine.productID.toString(),
                    onSaved: (text) => _wine.productID = int.parse(text),
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Please Enter Product ID' : null,
                    keyboardType: TextInputType.number,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'ProductID',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _wine.quantity.toString(),
                    onSaved: (text) => _wine.quantity = int.parse(text),
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Please Enter Quantity' : null,
                    keyboardType: TextInputType.number,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Quantity',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _wine.criticalQuantity.toString(),
                    onSaved: (text) => _wine.criticalQuantity = int.parse(text),
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Please Enter Critical Quantity' : null,
                    keyboardType: TextInputType.number,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Critical Quantity',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    items: null,
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
