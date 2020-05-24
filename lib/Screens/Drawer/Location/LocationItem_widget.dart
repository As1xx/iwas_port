import 'package:flutter/material.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Screens/Drawer/Location/EditLocation_screen.dart';
import 'package:iwas_port/Screens/Drawer/Location/LocationDetailScreen.dart';
import 'package:iwas_port/Services/LocationDatabaseService.dart';


class LocationItem extends StatelessWidget {
  final _databaseService = LocationDatabaseService();
  final Location _location;
  LocationItem(this._location);

  @override
  Widget build(BuildContext context) {

    Future<bool>_showDeleteDialog(){
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).dialogTheme.backgroundColor,elevation: 100,
            title: Text('Bist du sicher?',style: Theme.of(context).textTheme.caption,),
            actions: <Widget>[
              FlatButton(
                child: Text('Ja',style: Theme.of(context).textTheme.bodyText1,),
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
              ),
              FlatButton(
                child: Text('Nein',style: Theme.of(context).textTheme.bodyText1,),
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          ));
    }


    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _showDeleteDialog(),
      onDismissed: (_) => _databaseService.deleteFromDatabase(_location),
      key: ValueKey(_location.docID),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).errorColor,
        ),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).iconTheme.color,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 0.0),
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        color: Theme.of(context).cardTheme.color,
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: ListTile(
          onTap: () => Navigator.pushNamed(context, LocationDetailScreen.routeName,arguments: _location),
          title: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              _location.name,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(10,10,0,0),
            child: Text(
               _location.address,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit, color: Theme.of(context).iconTheme.color),
            onPressed: () => Navigator.pushNamed(context, EditLocation.routeName,
                arguments: _location),
          ),
        ),
      ),
    );
  }
}
