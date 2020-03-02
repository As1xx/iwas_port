import 'package:flutter/material.dart';
import 'package:iwas_port/Services/ImageService.dart';



class SelectPhoto extends StatelessWidget {

  final Function imageHandler;
  SelectPhoto(this.imageHandler);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).accentColor.withOpacity(0.75),
      title: Text('Select Photo'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.camera_alt,color: Theme.of(context).iconTheme.color,),
                label: Text('From Camera',style: Theme.of(context).textTheme.display1,),
                onPressed: () async{
                  var imageFile = await ImageService().imageFromCamera ?? null;
                    imageHandler(imageFile);
                    Navigator.of(context).pop();
                }
            ),
            Divider(
              color: Theme.of(context).dividerTheme.color,
            ),
            FlatButton.icon(
              icon: Icon(Icons.photo,color: Theme.of(context).iconTheme.color,),
              label: Text('From Gallery',style: Theme.of(context).textTheme.display1,),
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

