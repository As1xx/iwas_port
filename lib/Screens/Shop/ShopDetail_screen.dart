import 'package:flutter/material.dart';
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
            tag: 'detail',
            child: Image.network(productItem.imageURL,fit: BoxFit.scaleDown)
        ),
      ),
    );
  }
}
