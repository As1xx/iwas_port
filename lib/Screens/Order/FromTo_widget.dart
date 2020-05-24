import 'package:after_init/after_init.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:iwas_port/Screens/Loading/loading.dart';
import 'package:provider/provider.dart';

class FromTo extends StatefulWidget {
  final Order transaction;
  final List<Location> locationList;
  final List<Supplier> supplierList;
  final List<Customer> customerList;

  FromTo(
      {this.transaction,
      this.supplierList,
      this.customerList,
      this.locationList});

  @override
  _FromToState createState() => _FromToState();
}

class _FromToState extends State<FromTo> {
  var supplierDropDown;
  var locationDropDown;
  var customerDropDown;
  var fromDropDown;
  var toDropDown;

  @override
  Widget build(BuildContext context) {
    String selectedSupplier = widget.supplierList[0].name;
    String selectedCustomer = widget.customerList[0].name;
    String selectedLocation = widget.locationList[0].name;

    void setMethodProperty() {
      if (widget.transaction.method == 'Verkaufen') {
        widget.transaction.from =
            Location.findByName(widget.locationList, selectedLocation);
        widget.transaction.to =
            Customer.findByName(widget.customerList, selectedCustomer);
        fromDropDown = locationDropDown;
        toDropDown = customerDropDown;
      } else if (widget.transaction.method == 'Kaufen') {
        widget.transaction.from =
            Supplier.findByName(widget.supplierList, selectedSupplier);
        widget.transaction.to =
            Location.findByName(widget.locationList, selectedLocation);
        fromDropDown = supplierDropDown;
        toDropDown = locationDropDown;
      } else if (widget.transaction.method == 'Transfer') {
        widget.transaction.from =
            Location.findByName(widget.locationList, selectedLocation);
        widget.transaction.to =
            Location.findByName(widget.locationList, selectedLocation);
        fromDropDown = locationDropDown;
        toDropDown = locationDropDown;
      }
    }

    supplierDropDown = Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: RaisedButton(
            color: Colors.transparent,
            child: Icon(Icons.local_shipping),
            onPressed: () {
              showMaterialScrollPicker(
                buttonTextColor: Theme.of(context).accentColor,
                context: context,
                title: "Wähle Lieferenten",
                items: widget.supplierList.map((item) => item.name).toList(),
                selectedItem: selectedSupplier,
                onChanged: (value) => setState(() => selectedSupplier = value),
              );
            },
          ),
        ),
        Text(selectedSupplier),
      ],
    );

    customerDropDown = Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: RaisedButton(
            color: Colors.transparent,
            child: Icon(Icons.people),
            onPressed: () {
              showMaterialScrollPicker(
                buttonTextColor: Theme.of(context).accentColor,
                context: context,
                title: "Wähle Kunden",
                items: widget.customerList.map((item) => item.name).toList(),
                selectedItem: selectedCustomer,
                onChanged: (value) => setState(() => selectedCustomer = value),
              );
            },
          ),
        ),
        Text(selectedCustomer),
      ],
    );

    locationDropDown = Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: RaisedButton(
            color: Colors.transparent,
            child: Icon(Icons.location_on),
            onPressed: () {
              showMaterialScrollPicker(
                buttonTextColor: Theme.of(context).accentColor,
                context: context,
                title: "Wähle Lager",
                items: widget.locationList.map((item) => item.name).toList(),
                selectedItem: selectedLocation,
                onChanged: (value) => setState(() => selectedLocation = value),
              );
            },
          ),
        ),
        Text(selectedLocation),
      ],
    );

    setMethodProperty();

    return Stack(children: <Widget>[
      Container(
        height: 200,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Von', style: Theme.of(context).textTheme.headline2),
                    Icon(FontAwesomeIcons.longArrowAltRight),
                    Text('Zu', style: Theme.of(context).textTheme.headline2),
                  ],
                ),
                Divider(
                  height: 40,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    fromDropDown,
                    Spacer(
                      flex: 1,
                    ),
                    toDropDown,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
