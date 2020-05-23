import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';
import 'package:iwas_port/Services/CustomerDatabaseService.dart';
import 'package:iwas_port/Services/DatabaseException.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:string_validator/string_validator.dart';
import 'package:iwas_port/Credentials.dart';
import 'package:google_maps_webservice/places.dart' as Places;

class EditCustomer extends StatefulWidget {
  static const routeName = '/EditCustomer';

  @override
  _EditCustomerState createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final _databaseService = CustomerDatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading;

  var selectedPlace;
  Places.GoogleMapsPlaces _places =
      Places.GoogleMapsPlaces(apiKey: PLACES_API_KEY);

  Widget build(BuildContext context) {
    final Customer _customer = ModalRoute.of(context).settings.arguments;

    Future getAddressFromPrediction(Places.Prediction p) async {
      if (p != null) {
        Places.PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(p.placeId);
        setState(() {
          _customer.address = detail.result.formattedAddress; // Address
        });
      }
    }

    String _checkInteger(String text) {
      if (text.isEmpty) {
        return 'Bitte Zahl eingeben!';
      } else if (!isInt(text)) {
        return 'Bitte Zahl zwischen 0-9 eingeben!';
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
                  message: 'Daten erfolgreich in die Cloud hochgeladen!')
              .show(context).then((r) =>Navigator.of(context).pop());
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
        title: Text('Kunde bearbeiten',
            style: Theme.of(context).appBarTheme.textTheme.caption),
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
                        label: Text(
                          'Suche',
                          style: Theme.of(context).textTheme.headline2,
                        ),
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        _customer.address != null ? _customer.address : '',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: _customer.email,
                    onSaved: (text) => _customer.email = text,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: (text) =>
                        text.isEmpty ? 'Bitte Text eingeben!' : null,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'E-Mail',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _customer.phoneNumber,
                    onSaved: (text) => _customer.phoneNumber = text,
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
                        'Rechnungsadresse = Lieferadresse?',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Spacer(),
                      Switch(
                        value: _customer.isInvoiceAddress,
                        onChanged: (bool state) {
                          setState(() {
                            _customer.isInvoiceAddress = state;
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
