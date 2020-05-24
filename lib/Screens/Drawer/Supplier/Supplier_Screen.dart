import 'package:flutter/material.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:iwas_port/Screens/Drawer/Supplier/AddSupplier_screen.dart';
import 'package:iwas_port/Screens/Drawer/Supplier/SupplierItem_widget.dart';
import 'package:iwas_port/Screens/Drawer/Supplier/SupplierPopupMenu_widget.dart';
import 'package:iwas_port/Screens/Drawer/Supplier/SupplierSearchBar.dart';
import 'package:iwas_port/Screens/Loading/loading.dart';
import 'package:iwas_port/styles/background_style.dart';
import 'package:provider/provider.dart';


class SupplierScreen extends StatefulWidget {
  static const routeName = '/SupplierScreen';

  @override
  _SupplierScreenState createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {

  bool isBusy = true;

  @override
  Widget build(BuildContext context) {
    var supplierList = Provider.of<List<Supplier>>(context);
    GlobalKey popUpKey = GlobalKey();

    void updateSortScreen(List<Supplier> filteredList) {
      setState(() {
        supplierList = filteredList;
      });
    }

    if (supplierList != null){
      setState(() {
        isBusy = false;
      });
    }




    return isBusy ? Loading() : Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text('Lieferanten',style: Theme.of(context).appBarTheme.textTheme.caption),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AddSupplier.routeName),
            icon: Icon(Icons.add),
          ),
          IconButton(
            key: popUpKey,
            onPressed: () {
              buildPopupMenu(context, popUpKey, supplierList, updateSortScreen);
            },
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SupplierSearchBar(myList: supplierList));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Background(
          child: ListView.builder(
            itemCount: supplierList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 8),
                child: SupplierItem(supplierList[index]),
              );
            },
          )),
    );
  }
}
