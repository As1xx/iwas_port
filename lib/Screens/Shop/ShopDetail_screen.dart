import 'package:flutter/material.dart';
import 'package:getflutter/components/card/gf_card.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Styles/background_style.dart';

class ShopDetailScreen extends StatelessWidget {
  static const routeName = '/CartDetail';
  @override
  Widget build(BuildContext context) {
    final Wine productItem = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.actionsIconTheme,
        title: Text(
          'DetailPage',
          style: Theme.of(context).appBarTheme.textTheme.title,
        ),
      ),
      body: Background(
        child: Hero(
            tag: productItem.docID,
            child: GFCard(
              boxFit: BoxFit.cover,
                image: Image.network(productItem.imageURL,fit: BoxFit.fitWidth),
              content: Text('Test',style: Theme.of(context).textTheme.display1,),


            ),
        ),
      ),
    );
  }
}
