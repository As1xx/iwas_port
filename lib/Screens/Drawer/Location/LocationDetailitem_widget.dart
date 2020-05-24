import 'package:flutter/material.dart';
import 'package:iwas_port/Models/wine.dart';

class LocationDetailItem extends StatelessWidget {

  final Wine wine;
  LocationDetailItem({this.wine});

  @override
  Widget build(BuildContext context) {



    return  Card(
        color: Theme.of(context).cardTheme.color,
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: ListTile(
          onTap: () => null,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: ClipOval(
              child: Image.network(wine.imageURL),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              wine.manufacturer,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(10,10,0,0),
            child: Text(
              wine.type,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          trailing: Text('${wine.quantity.toString()} x'),
        ),
      );
  }
}
