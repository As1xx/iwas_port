import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';
import 'package:iwas_port/Services/DatabaseException.dart';
import 'package:iwas_port/Services/SupplierDatabaseService.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:string_validator/string_validator.dart';
import 'package:iwas_port/Credentials.dart';
import 'package:google_maps_webservice/places.dart' as Places;

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
  TextEditingController emailTextController = TextEditingController(text: '');
  TextEditingController phoneTextController = TextEditingController(text: '');

  var selectedPlace;
  Places.GoogleMapsPlaces _places =
  Places.GoogleMapsPlaces(apiKey: PLACES_API_KEY);

  String _checkInteger(String text) {
    if (text.isEmpty) {
      return 'Bitte Zahl eingeben!';
    } else if (!isInt(text)) {
      return 'Bitte Zahl zwischen 0-9 eingeben!';
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
                  message: 'Daten erfolgreich in die Cloud hochgeladen!')
              .show(context).then((r) =>Navigator.of(context).pop());
        } on DatabaseException catch (error) {
          DatabaseException.showError(context, error.message);
        } catch (otherError) {
          DatabaseException.showError(context, otherError.message);
        }
      }
    }

    Future getAddressFromPrediction(Places.Prediction p) async {
      if (p != null) {
        Places.PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId);
        setState(() {
          _supplier.address = detail.result.formattedAddress; // Address
          _supplier.email = detail.result.website;
          emailTextController.text = detail.result.website;
          _supplier.phoneNumber = detail.result.formattedPhoneNumber;
          phoneTextController.text = detail.result.formattedPhoneNumber;

        });

      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Lieferanten hinzufügen',style: Theme.of(context).appBarTheme.textTheme.caption),
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
                        text.isEmpty ? 'Bitte Text eingeben!' : null,
                    keyboardType: TextInputType.text,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text(
                        'Adresse',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Spacer(),
                      FlatButton.icon(
                        icon: Icon(Icons.location_on),
                        label: Text('Suche',style: Theme.of(context).textTheme.headline2,),
                        onPressed: () async {
                          selectedPlace = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: PLACES_API_KEY,
                              mode: Mode.fullscreen, // Mode.fullscreen
                              language: "de",
                              components: [
                                Places.Component(Places.Component.country, "de")
                              ]);
                          getAddressFromPrediction(selectedPlace);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(child: Text(_supplier.address != null ? _supplier.address:'',style: Theme.of(context).textTheme.headline4,)),
                    ],
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: emailTextController,
                    onSaved: (text) => _supplier.email = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Bitte Text eingeben' : null,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'E-Mail',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneTextController,
                    onSaved: (text) => _supplier.phoneNumber = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Bitte Text eingeben!' : null,
                    keyboardType: TextInputType.phone,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Telefon',
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Standard Lieferant?',
                        style: Theme.of(context).textTheme.headline2,
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
