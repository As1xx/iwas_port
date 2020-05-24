import 'package:flutter/material.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Screens/Drawer/Wine/WineItem_widget.dart';
import 'package:iwas_port/styles/background_style.dart';



class LocationDetailScreen extends StatelessWidget {
  static const routeName = '/LocationDetailScreen';

  @override
  Widget build(BuildContext context) {

    final Location location = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text('Übersicht ${location.name}',style: Theme.of(context).appBarTheme.textTheme.caption),
      ),
      body: Background(
          child: ListView.builder(
            itemCount: location.productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 8),
                child: WineItem(location.productList[index]),
              );
            },
          )),
    );
  }
}
