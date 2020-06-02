import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';
import 'package:iwas_port/Services/DatabaseException.dart';
import 'package:iwas_port/Services/LocationDatabaseService.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:iwas_port/Credentials.dart';
import 'package:google_maps_webservice/places.dart' as Places;

class AddLocation extends StatefulWidget {
  static const routeName = '/AddLocation';

  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {

  final _databaseService = LocationDatabaseService();
  final _formKey = GlobalKey<FormState>();
  final _location = Location.empty();
  bool isLoading;
  bool switchState = false;


  var selectedPlace;
  Places.GoogleMapsPlaces _places =
      Places.GoogleMapsPlaces(apiKey: PLACES_API_KEY);



  Widget build(BuildContext context) {

    void _validateForm() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        _location.isDefault = switchState;

        try {
          await _databaseService.writeToDatabase(_location);
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
          _location.address = detail.result.formattedAddress; // Address
        });

      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Lager hinzufügen',style: Theme.of(context).appBarTheme.textTheme.caption),
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
                    onSaved: (text) => _location.name = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Bitte Text eingeben' : null,
                    keyboardType: TextInputType.text,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: 20),
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
                      Flexible(child: Text(_location.address != null ? _location.address:'',style: Theme.of(context).textTheme.headline4,)),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text(
                        'Standard Lager?',
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
