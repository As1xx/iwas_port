import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Screens/Order/Order_screen.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:provider/provider.dart';
import 'package:iwas_port/Screens/Cart/CartItem_widget.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.actionsIconTheme,
        title: Text(
          'Einkaufswagen',
          style: Theme.of(context).appBarTheme.textTheme.caption,
        ),
      ),
      body: Background(
        child: Column(
          children: <Widget>[
            Card(
              color: Theme.of(context).cardTheme.color,
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    GFButton(
                      text: '${cart.totalAmount} €',
                      textStyle: Theme.of(context).textTheme.caption,
                      color: Theme.of(context).accentColor,
                      type: GFButtonType.outline2x,
                      shape: GFButtonShape.pills,
                      onPressed: null,
                      size: GFSize.LARGE,
                    ),
                    GFButton(
                      text: 'Checkout',
                      textStyle: Theme.of(context).textTheme.headline2,
                      color: Theme.of(context).accentColor,
                      type: GFButtonType.solid,
                      shape: GFButtonShape.pills,
                      onPressed: () => Navigator.pushNamed(context, OrderScreen.routeName),
                      size: GFSize.LARGE,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (ctx,index) => CartItemWidget(cart.cartItems.values.toList()[index]),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
