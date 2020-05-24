import 'package:flutter/material.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Screens/Drawer/Location/AddLocation_screen.dart';
import 'package:iwas_port/Screens/Drawer/Location/LocationItem_widget.dart';
import 'package:iwas_port/Screens/Drawer/Location/LocationPopupMenu_widget.dart';
import 'package:iwas_port/Screens/Drawer/Location/LocationSearchBar.dart';
import 'package:iwas_port/Screens/Loading/loading.dart';
import 'package:iwas_port/styles/background_style.dart';
import 'package:provider/provider.dart';


class LocationScreen extends StatefulWidget {
  static const routeName = '/LocationScreen';

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  bool isBusy = true;

  @override
  Widget build(BuildContext context) {
    var locationList = Provider.of<List<Location>>(context);
    GlobalKey popUpKey = GlobalKey();

    void updateSortScreen(List<Location> filteredList) {
      setState(() {
        locationList = filteredList;
      });
    }

    if (locationList != null){
      setState(() {
        isBusy = false;
      });
    }


    return isBusy ? Loading() : Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text('Lager',style: Theme.of(context).appBarTheme.textTheme.caption,),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AddLocation.routeName),
            icon: Icon(Icons.add),
          ),
          IconButton(
            key: popUpKey,
            onPressed: () {
              buildPopupMenu(context, popUpKey, locationList, updateSortScreen);
            },
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: LocationSearchBar(myList: locationList));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Background(
          child: ListView.builder(
            itemCount: locationList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 8),
                child: LocationItem(locationList[index]),
              );
            },
          )),
    );
  }
}
