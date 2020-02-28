import 'package:flutter/material.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/MasterDetail/AddWine_sceen.dart';
import 'package:iwas_port/Screens/MasterDetail/WineItem_widget.dart';
import 'package:iwas_port/Services/DatabaseService.dart';
import 'package:iwas_port/styles/background_style.dart';
import 'package:provider/provider.dart';

class WineScreen extends StatelessWidget {
  static const String collectionName = 'Wine';
  final DatabaseService _databaseService = DatabaseService(collectionName);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Wine>>(
      create: (_) => _databaseService.wineListOfCollection,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WineList'),
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddWine())),
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.filter_list),
            ),
            IconButton(
              onPressed: () {
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
