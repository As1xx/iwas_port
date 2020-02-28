import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Services/DatabaseService.dart';
import 'package:iwas_port/styles/MyAndroidActionSheet.dart';
import 'package:iwas_port/Screens/Authenticate//TextInputForm_decoration.dart';

//TODO: Implement Loading Screen and Check Database Connection, refactor set state with TextController, Maybe split, ERROR Handling with Database Service
class AddWine extends StatefulWidget {
  @override
  _AddWineState createState() => _AddWineState();
}

class _AddWineState extends State<AddWine> {

  final _formKey = GlobalKey<FormState>();
  File myImageFile;
  final Wine _wine = Wine.empty();

  static const String collectionName = 'Wine';
  final DatabaseService _databaseService = DatabaseService(collectionName);


  void _updateImage(File imageFile){
    setState(() {
      myImageFile = imageFile;
    });
  }


  Widget decideImage(){
    if (myImageFile == null){
      return Icon(Icons.camera_alt);
    }else{
      return Image.file(myImageFile);
    }
  }


  void _validateForm() async {
    if (_formKey.currentState.validate()){
       await _databaseService.uploadImage(myImageFile, _wine);
       var isWritten = await _databaseService.writeToDatabase(_wine);

       if (isWritten){
         await Flushbar(message: 'Data successfully uploaded to Cloud',duration: Duration(seconds: 2)).show(context);
       }else{
         await Flushbar(message: 'Could not upload Data to Cloud',duration: Duration(seconds: 2)).show(context);
       }

      Navigator.of(context).pop();
    }
  }


  Widget build(BuildContext context) {

    _showActionDialog(){
      return showDialog(
          context: context,
          builder: (BuildContext context) => MyAndroidActionSheet(_updateImage)
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Add Wine'),
          backgroundColor: Colors.redAccent[200],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              onPressed: _validateForm,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  IconButton(
                      iconSize: 100,
                      icon:  decideImage(),
                      onPressed: ()  {
                        _showActionDialog();
                      }
                    ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    //decoration: textFormStyle.copyWith(labelText: 'Manufacturer'),
                    validator: (val) => val.isEmpty ? 'Please Enter Manufacturer' : null,
                    onChanged: (val){
                      setState(() => _wine.manufacturer = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                   // decoration: textFormStyle.copyWith(labelText: 'Type'),
                    validator: (val) => val.isEmpty ? 'Please Enter Type' : null,
                    onChanged: (val){
                      setState(() => _wine.type = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    //decoration: textFormStyle.copyWith(labelText: 'Product ID'),
                    validator: (val) => val.isEmpty ? 'Please Enter Product ID' : null,
                    onChanged: (val){
                      setState(() => _wine.productID =  int.parse(val));
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    //decoration: textFormStyle.copyWith(labelText: 'Quantity'),
                    validator: (val) => val.isEmpty ? 'Please Enter Quantity' : null,
                    onChanged: (val){
                      setState(() => _wine.quantity = int.parse(val));
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    //decoration: textFormStyle.copyWith(labelText: 'Critical Quantity'),
                    validator: (val) => val.isEmpty ? 'Please Enter Critical Quantity' : null,
                    onChanged: (val){
                      setState(() => _wine.criticalQuantity = int.parse(val));
                    },
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    items: null,
                  ),
                ],
              ),

            ),
          ),
        ),
      );
  }
}
