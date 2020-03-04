import 'package:flutter/material.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Drawer/AddWine_sceen.dart';
import 'package:iwas_port/Screens/Drawer/PopupMenu_widget.dart';
import 'package:iwas_port/styles/background_style.dart';
import 'package:iwas_port/Styles/SearchBar.dart';
import 'package:provider/provider.dart';

import 'WineItem_widget.dart';

class WineScreen extends StatelessWidget {
  static const routName = '/WineScreen';

  @override
  Widget build(BuildContext context) {
    final wineList = Provider.of<List<Wine>>(context);
    GlobalKey popUpKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text('WineList'),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AddWine.routName),
            icon: Icon(Icons.add),
          ),
          IconButton(key: popUpKey ,
            //TODO: Add Filter
            onPressed: () {
              buildPopupMenu(context,popUpKey,wineList);
            },
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchBar(myList: wineList));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Background(
          child: ListView.builder(
        itemCount: wineList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8),
            child: WineItem(wineList[index]),
          );
        },
      )),
    );
  }
}
