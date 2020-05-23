import 'package:flutter/material.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:iwas_port/Screens/Drawer/Supplier/EditSupplier_screen.dart';
import 'package:iwas_port/Services/SupplierDatabaseService.dart';


class SupplierItem extends StatelessWidget {
  final _databaseService = SupplierDatabaseService();
  final Supplier _supplier;
  SupplierItem(this._supplier);

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
      onDismissed: (_) => _databaseService.deleteFromDatabase(_supplier),
      key: ValueKey(_supplier.docID),
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
          onTap: () => null, //TODO: implement Detail View
          title: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              _supplier.name,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(10,10,0,0),
            child: Text(
              _supplier.address,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit, color: Theme.of(context).iconTheme.color),
            onPressed: () => Navigator.pushNamed(context, EditSupplier.routeName,
                arguments: _supplier),
          ),
        ),
      ),
    );
  }
}
