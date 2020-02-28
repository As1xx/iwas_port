import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Services/ImageService.dart';
import 'package:provider/provider.dart';


class MyAndroidActionSheet extends StatelessWidget {

  final Function imageHandler;
  MyAndroidActionSheet(this.imageHandler);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Photo'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text('From Camera'),
                onPressed: () async{
                  var imageFile = await ImageService().imageFromCamera ?? null;
                    imageHandler(imageFile);
                    Navigator.of(context).pop();
                }
            ),
            Divider(),
            FlatButton.icon(
              icon: Icon(Icons.photo),
              label: Text('From Gallery'),
              onPressed: ()  async {
                var imageFile = await ImageService().imageFromGallery ?? null;
                imageHandler(imageFile);
                Navigator.of(context).pop();
              }
            )
          ],
        ),
      ),
    );
  }
}

