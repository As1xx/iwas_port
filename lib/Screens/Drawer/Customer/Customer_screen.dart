import 'package:flutter/material.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Screens/Drawer/Customer/AddCustomer_screen.dart';
import 'package:iwas_port/Screens/Drawer/Customer/CustomerItem_widget.dart';
import 'package:iwas_port/Screens/Drawer/Customer/CustomerPopupMenu_widget.dart';
import 'package:iwas_port/Screens/Drawer/Customer/CustomerSearchBar.dart';
import 'package:iwas_port/Screens/Loading/loading.dart';
import 'package:iwas_port/styles/background_style.dart';
import 'package:provider/provider.dart';


class CustomerScreen extends StatefulWidget {
  static const routeName = '/CustomerScreen';

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {

  bool isBusy = true;

  @override
  Widget build(BuildContext context) {
    var customerList = Provider.of<List<Customer>>(context);
    GlobalKey popUpKey = GlobalKey();

    void updateSortScreen(List<Customer> filteredList) {
      setState(() {
        customerList = filteredList;
      });
    }

    if (customerList.isEmpty != null){
      setState(() {
        isBusy = false;
      });
    }




    return isBusy ? Loading() : Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text('Customer List'),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AddCustomer.routeName),
            icon: Icon(Icons.add),
          ),
          IconButton(
            key: popUpKey,
            onPressed: () {
              buildPopupMenu(context, popUpKey, customerList, updateSortScreen);
            },
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: CustomerSearchBar(myList: customerList));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Background(
          child: ListView.builder(
            itemCount: customerList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 8),
                child: CustomerItem(customerList[index]),
              );
            },
          )),
    );
  }
}
