import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Models/supplier.dart';

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
  var locationTwoDropDown;
  var customerDropDown;
  String selectedSupplier;
  String selectedCustomer;
  String selectedLocation;
  String selectedLocationTwo;

  @override
  void initState() {
    super.initState();

    if (widget.supplierList.isEmpty || widget.supplierList == null){
      selectedSupplier = 'Kein Lieferant';
    }else{
      selectedSupplier = widget.supplierList[0].name;
    }

    if (widget.customerList.isEmpty || widget.customerList == null){
      selectedCustomer = 'Kein Kunde';
    }else{
      selectedCustomer = widget.customerList[0].name;
    }

    if (widget.locationList.isEmpty || widget.locationList == null){
      selectedLocation = 'Kein Lager';
      selectedLocationTwo = 'Kein Lager';
    }else{
      selectedLocation = widget.locationList[0].name;
      selectedLocationTwo = widget.locationList[0].name;
    }


  }

  var fromDropDown;
  var toDropDown;

  @override
  Widget build(BuildContext context) {


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
            Location.findByName(widget.locationList, selectedLocationTwo);
        fromDropDown = locationDropDown;
        toDropDown = locationTwoDropDown;
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
                backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
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
                backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
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
                backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
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


    locationTwoDropDown = Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: RaisedButton(
            color: Colors.transparent,
            child: Icon(Icons.location_on),
            onPressed: () {
              showMaterialScrollPicker(
                backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
                buttonTextColor: Theme.of(context).accentColor,
                context: context,
                title: "Wähle Lager",
                items: widget.locationList.map((item) => item.name).toList(),
                selectedItem: selectedLocationTwo,
                onChanged: (value) => setState(() => selectedLocationTwo = value),
              );
            },
          ),
        ),
        Text(selectedLocationTwo),
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
