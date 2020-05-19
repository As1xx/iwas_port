import 'package:after_init/after_init.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:provider/provider.dart';

class FromTo extends StatefulWidget {
  final isSell;
  final Order transaction;

  FromTo({this.isSell, this.transaction});

  @override
  _FromToState createState() => _FromToState();
}

class _FromToState extends State<FromTo> {
  List<Location> locationList;
  List<Supplier> supplierList;
  List<Customer> customerList;
  String selectedSupplier;
  String selectedCustomer;
  String selectedLocation;
  bool isBusy = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locationList = Provider.of<List<Location>>(context);
    supplierList = Provider.of<List<Supplier>>(context);
    customerList = Provider.of<List<Customer>>(context);
    selectedSupplier = supplierList[0].name;
    selectedCustomer = customerList[0].name;
    selectedLocation = locationList[0].name;
  }

  @override
  Widget build(BuildContext context) {

    if (widget.isSell){
      widget.transaction.location =
          Location.findByName(locationList, selectedLocation);
      widget.transaction.supplier =
          Supplier.empty();
      widget.transaction.customer =
          Customer.findByName(customerList, selectedCustomer);
    }else{
      widget.transaction.location =
          Location.findByName(locationList, selectedLocation);
      widget.transaction.supplier =
          Supplier.findByName(supplierList, selectedSupplier);
      widget.transaction.customer =
          Customer.empty();
    }


    if (supplierList.isNotEmpty &&
        locationList.isNotEmpty &&
        customerList.isNotEmpty) {
      setState(() {
        isBusy = false;
      });
    }

    var supplierDropDown = Column(
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
                title: "Pick Supplier",
                items: supplierList.map((item) => item.name).toList(),
                selectedItem: selectedSupplier,
                onChanged: (value) => setState(() => selectedSupplier = value),
              );
            },
          ),
        ),
        Text(selectedSupplier),
      ],
    );

    var customerDropDown = Column(
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
                title: "Pick Customer",
                items: customerList.map((item) => item.name).toList(),
                selectedItem: selectedCustomer,
                onChanged: (value) => setState(() => selectedCustomer = value),
              );
            },
          ),
        ),
        Text(selectedCustomer),
      ],
    );

    var locationDropDown = Column(
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
                title: "Pick Location",
                items: locationList.map((item) => item.name).toList(),
                selectedItem: selectedLocation,
                onChanged: (value) => setState(() => selectedLocation = value),
              );
            },
          ),
        ),
        Text(selectedLocation),
      ],
    );

    return isBusy
        ? SpinKitFadingCircle(
            color: Theme.of(context).accentColor,
          )
        : Stack(children: <Widget>[
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
                          Text('From',
                              style: Theme.of(context).textTheme.body1),
                          Icon(FontAwesomeIcons.longArrowAltRight),
                          Text('To', style: Theme.of(context).textTheme.body1),
                        ],
                      ),
                      Divider(
                        height: 40,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          locationDropDown,
                          Spacer(
                            flex: 1,
                          ),
                          widget.isSell == true
                              ? customerDropDown
                              : supplierDropDown,
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
