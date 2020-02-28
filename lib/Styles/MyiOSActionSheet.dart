import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iwas_port/Services/ImageService.dart';

class MyiOSActionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text('Select Photo'),
      actions: <Widget>[
        CupertinoActionSheetAction(
            child: FlatButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text('From Camera'),
              onPressed: () => ImageService().imageFromCamera,
            )
        ),
        CupertinoActionSheetAction(
            child: FlatButton.icon(
              icon: Icon(Icons.photo),
              label: Text('From Gallery'),
              onPressed: () {

              },
            )
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'),
        isDefaultAction:  true,
        onPressed: (){
          Navigator.pop(context,'Cancel');
        },
      ) ,
    );
  }
}


