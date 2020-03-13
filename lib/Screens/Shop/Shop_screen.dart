import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Shop/ShopItem_widget.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatelessWidget {
  static const routeName = '/ShopScreen';
  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<List<Wine>>(context);

    return Scaffold(
      body: Background(
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: productList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (context, index) => ShopItem(productList[index]),
        ),
      ),
    );
  }
}
