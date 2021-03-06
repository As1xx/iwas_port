import 'package:flutter/material.dart';
import 'package:iwas_port/Services/ImageService.dart';



class SelectPhoto extends StatelessWidget {

  final Function imageHandler;
  SelectPhoto(this.imageHandler);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
      title: Text('Suche Foto',style: Theme.of(context).dialogTheme.titleTextStyle,),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.camera_alt,color: Theme.of(context).iconTheme.color,),
                label: Text('Von Kamera',style: Theme.of(context).dialogTheme.contentTextStyle,),
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
              label: Text('Von Gallerie',style: Theme.of(context).dialogTheme.contentTextStyle,),
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

