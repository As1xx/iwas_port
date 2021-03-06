import 'package:flutter/material.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Drawer/Wine/AddWine_sceen.dart';
import 'package:iwas_port/Screens/Drawer/Wine/WinePopupMenu_widget.dart';
import 'package:iwas_port/Screens/Drawer/Wine/WineItem_widget.dart';
import 'package:iwas_port/Screens/Loading/loading.dart';
import 'package:iwas_port/styles/background_style.dart';
import 'package:iwas_port/Screens/Drawer/Wine/WineSearchBar.dart';
import 'package:provider/provider.dart';


class WineScreen extends StatefulWidget {
  static const routeName = '/WineScreen';

  @override
  _WineScreenState createState() => _WineScreenState();
}

class _WineScreenState extends State<WineScreen> {

  bool isBusy = true;


  @override
  Widget build(BuildContext context) {
    List <Wine> wineList = Provider.of<List<Wine>>(context);
    GlobalKey popUpKey = GlobalKey();

    void updateSortScreen(List<Wine> filteredList) {
      setState(() {
        wineList = filteredList;
      });
    }

    if (wineList != null){
      setState(() {
        isBusy = false;
      });
    }




    return isBusy ? Loading() : Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text('Produkte',style: Theme.of(context).appBarTheme.textTheme.caption),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AddWine.routeName),
            icon: Icon(Icons.add),
          ),
          IconButton(
            key: popUpKey,
            onPressed: () {
              buildPopupMenu(context, popUpKey, wineList, updateSortScreen);
            },
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: WineSearchBar(myList: wineList));
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
