import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iwas_port/Models/wine.dart';

class WineItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Wine> wines = Provider.of<List<Wine>>(context) ?? [];

    return ListView.builder(
      itemCount: wines.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 8),
          child: Card(
            color: Theme.of(context).backgroundColor,
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              onTap: () => null, //TODO: implement Detail View
              leading: CircleAvatar(
                backgroundImage: NetworkImage(wines[index].imageURL),
                radius: 25.0,
              ),
              title: Text(wines[index].manufacturer),
              subtitle: Text(wines[index].type),
            ),
          ),
        );
      },
    );
  }
}
