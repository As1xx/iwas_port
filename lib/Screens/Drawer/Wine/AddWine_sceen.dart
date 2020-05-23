import 'dart:io';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';
import 'package:iwas_port/Screens/Drawer/Wine/SelectPhoto_widget.dart';
import 'package:iwas_port/Services/DatabaseException.dart';
import 'package:iwas_port/Services/WineDatabaseService.dart';
import 'package:iwas_port/Services/ImageException.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:string_validator/string_validator.dart';



class AddWine extends StatefulWidget {
  static const routeName = '/AddWine';

  @override
  _AddWineState createState() => _AddWineState();
}

class _AddWineState extends State<AddWine> {
  final _databaseService = WineDatabaseService();
  final _formKey = GlobalKey<FormState>();
  final _wine = Wine.empty();
  File myImageFile;
  bool isLoading;

  final purchasePriceTextController = MoneyMaskedTextController(
  rightSymbol: '€', precision: 2, decimalSeparator: ',');

  final sellingPriceTextController = MoneyMaskedTextController(
      rightSymbol: '€', precision: 2, decimalSeparator: ',');


  String _checkInteger(String text) {
    if (text.isEmpty) {
      return 'Bitte Zahl eingeben!';
    } else if (!isInt(text)) {
      return 'Bitte Zahl zwischen 0-9 eingeben!';
    } else {
      return null;
    }
  }



  void _updateImage(File imageFile) {
    setState(() {
      myImageFile = imageFile;
    });
  }

  Widget _decideImage() {
    if (myImageFile == null) {
      return Icon(Icons.camera_alt);
    } else {
      return Image.file(myImageFile);
    }
  }




  Widget build(BuildContext context) {
    
    _showActionDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext context) =>
              SelectPhoto(_updateImage));
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
              message: 'Daten erfolgreich in die Cloud hochgeladen!').show(context).then((r) =>Navigator.of(context).pop());
        } on DatabaseException catch (error) {
          DatabaseException.showError(context, error.message);
        } catch (otherError) {
          DatabaseException.showError(context, otherError.message);
        }
      }
    }



    return Scaffold(
      appBar: AppBar(
        title: Text('Produkt hinzufügen',style: Theme.of(context).appBarTheme.textTheme.caption),
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
                      iconSize: 75,
                      icon: _decideImage(),
                      onPressed: () => _showActionDialog(),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (text) => _wine.manufacturer = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => text.isEmpty ? 'Bitte Text eingeben!' : null,
                    keyboardType: TextInputType.text,
                    cursorColor: Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Hersteller',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (text) => _wine.type = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => text.isEmpty ? 'Bitte Text eingeben!' : null,
                    keyboardType: TextInputType.text,
                    cursorColor: Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Typ',
                    ),
                  ),
                  SizedBox(height:20.0),
                  TextFormField(
                    onSaved: (text) => _wine.productID = int.parse(text),
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => _checkInteger(text),
                    keyboardType: TextInputType.number,
                    cursorColor: Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Produkt-ID',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (text) => _wine.purchasePrice = purchasePriceTextController.numberValue,
                    controller: purchasePriceTextController,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => purchasePriceTextController.numberValue <= 0 ? 'Einkaufspreis kann nicht 0 sein!':null,
                    keyboardType: TextInputType.number,
                    cursorColor: Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Einkaufspreis',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (text) => _wine.sellingPrice = sellingPriceTextController.numberValue,
                    controller: sellingPriceTextController,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) => sellingPriceTextController.numberValue <= 0 ? 'Verkaufspreis kann nicht 0 sein!':null,
                    keyboardType: TextInputType.number,
                    cursorColor: Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Verkaufspreis',
                    ),
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
