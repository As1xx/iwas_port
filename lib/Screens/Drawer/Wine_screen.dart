import 'package:flutter/material.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Drawer/AddWine_sceen.dart';
import 'package:iwas_port/Screens/Drawer/WineItem_widget.dart';
import 'package:iwas_port/Services/DatabaseService.dart';
import 'package:iwas_port/styles/background_style.dart';
import 'package:provider/provider.dart';

class WineScreen extends StatelessWidget {
  static const routName = '/WineScreen';
  final WineDatabaseService _databaseService = WineDatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Wine>>(
      create: (_) => _databaseService.wineListOfCollection,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WineList'),
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.pushNamed(context, AddWine.routName),
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.filter_list),
            ),
            IconButton(
              onPressed: () {
                //TODO:implement SearchBar
                //showSearch(context: context, delegate: SearchBar());
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: Background(child: WineItem()),
      ),
    );
  }
}
