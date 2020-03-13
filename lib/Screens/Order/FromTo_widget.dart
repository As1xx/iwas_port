import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';
import 'package:provider/provider.dart';

class FromTo extends StatefulWidget {
  final isBuy;

  FromTo(this.isBuy);

  @override
  _FromToState createState() => _FromToState();
}

class _FromToState extends State<FromTo> {
  var selectedSupplier;
  var selectedCustomer;
  var selectedLocation;

  @override
  Widget build(BuildContext context) {
    final supplierList = Provider.of<List<Supplier>>(context);
    final customerList = Provider.of<List<Customer>>(context);
    final locationList = Provider.of<List<Location>>(context);

    var supplierDropDown = Flexible(flex:3,
      child: DropdownButtonFormField(
        validator: (supplier) =>
            supplier == null ? 'Please specify Field' : null,
        iconEnabledColor: Theme.of(context).iconTheme.color,
        style: Theme.of(context).inputDecorationTheme.labelStyle,
        decoration: textFormDecoration(context),
        isDense: true,
        value: selectedSupplier,
        hint: Text('Select Supplier',
            style: Theme.of(context).inputDecorationTheme.labelStyle),
        items: supplierList.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item.name),
          );
        }).toList(),
        onChanged: (selectedItem) {
          setState(() {
            selectedSupplier = selectedItem;
          });
        },
      ),
    );

    var customerDropDown = Flexible(flex:3,
      child: DropdownButtonFormField(
        validator: (customer) =>
        customer == null ? 'Please specify Field' : null,
        iconEnabledColor: Theme.of(context).iconTheme.color,
        style: Theme.of(context).inputDecorationTheme.labelStyle,
        decoration: textFormDecoration(context),
        isDense: true,
        value: selectedCustomer,
        hint: Text('Select Customer',
            style: Theme.of(context).inputDecorationTheme.labelStyle),
        items: customerList.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item.name),
          );
        }).toList(),
        onChanged: (selectedItem) {
          setState(() {
            selectedCustomer = selectedItem;
          });
        },
      ),
    );


    return Stack(children: <Widget>[
      Container(
        height: 175,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('From', style: Theme.of(context).textTheme.body1),
                    Icon(FontAwesomeIcons.longArrowAltRight),
                    Text('To', style: Theme.of(context).textTheme.body1),
                  ],
                ),
                Divider(
                  height: 40,
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(flex:3,
                      child: DropdownButtonFormField(
                        validator: (location) =>
                            location == null ? 'Please specify Field' : null,
                        iconEnabledColor: Theme.of(context).iconTheme.color,
                        style:
                            Theme.of(context).inputDecorationTheme.labelStyle,
                        decoration: textFormDecoration(context),
                        isDense: true,
                        value: selectedLocation,
                        hint: Text('Select Location',
                            style: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle),
                        items: locationList.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item.name),
                          );
                        }).toList(),
                        onChanged: (selectedItem) {
                          setState(() {
                            selectedLocation = selectedItem;
                          });
                        },
                      ),
                    ),
                    Spacer(flex: 1,),
                    widget.isBuy == true ? customerDropDown : supplierDropDown,
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
