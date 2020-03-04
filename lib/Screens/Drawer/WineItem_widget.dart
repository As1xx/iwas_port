import 'package:flutter/material.dart';
import 'package:iwas_port/Services/DatabaseService.dart';

import 'EditWine_screen.dart';

class WineItem extends StatelessWidget {
  final _databaseService = WineDatabaseService();
  final _wine;
  WineItem(this._wine);

  @override
  Widget build(BuildContext context) {

    Future<bool>_showDeleteDialog(){
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).dialogBackgroundColor,elevation: 100,
            title: Text('Are you sure?',style: Theme.of(context).textTheme.caption,),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes',style: Theme.of(context).textTheme.display1,),
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
              ),
              FlatButton(
                child: Text('No',style: Theme.of(context).textTheme.display1,),
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
      onDismissed: (_) => _databaseService.deleteFromDatabase(_wine),
      key: ValueKey(_wine.docID),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Theme.of(context).iconTheme.color,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        color: Theme.of(context).backgroundColor,
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: () => null, //TODO: implement Detail View
          leading: CircleAvatar(
            backgroundImage: NetworkImage(_wine.imageURL),
            radius: 25.0,
          ),
          title: Text(
            _wine.manufacturer,
            style: Theme.of(context).textTheme.caption,
          ),
          subtitle: Text(
            _wine.type,
            style: Theme.of(context).textTheme.subtitle,
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit, color: Theme.of(context).iconTheme.color),
            onPressed: () => Navigator.pushNamed(context, EditWine.routName,
                arguments: _wine),
          ),
        ),
      ),
    );
  }
}
