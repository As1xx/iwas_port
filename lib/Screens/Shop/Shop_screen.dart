import 'package:flutter/material.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Loading/loading.dart';
import 'package:iwas_port/Screens/Shop/ShopItem_widget.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  static const routeName = '/ShopScreen';

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool isBusy = true;

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<List<Wine>>(context);

    if (productList != null){
      setState(() {
        isBusy = false;
      });
    }

    return isBusy? Loading():Scaffold(
      body: Background(
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: productList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemBuilder: (context, index) => ShopItem(productList[index]),
        ),
      ),
    );
  }
}
