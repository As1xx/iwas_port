import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Models/CartItem.dart';
import 'package:iwas_port/Screens/Cart/Cart_screen.dart';
import 'package:provider/provider.dart';

class ShopDetailScreen extends StatefulWidget {
  static const routeName = '/ShopDetailScreen';
  @override
  _ShopDetailScreenState createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final CartItem cartItem = ModalRoute.of(context).settings.arguments;
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 40),
            child: Badge(
              child: IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, CartScreen.routeName),
                  icon: Icon(Icons.shopping_cart,
                      color: Theme.of(context).iconTheme.color)),
              toAnimate: true,
              animationType: BadgeAnimationType.scale,
              badgeColor: Theme.of(context).accentColor,
              badgeContent: Text(cart.cartItemCount.toString()),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/camera_default.png'),
                    image: NetworkImage(
                      cartItem.imageURL,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.25),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.05),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 350,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.25),
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              cartItem.manufacturer + ' ' + cartItem.type,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${cartItem.price.toStringAsFixed(2)} €',
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).backgroundColor,
                          offset: Offset(2, 5),
                          blurRadius: 10)
                    ]),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          'Description:\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Theme.of(context).accentColor,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () => cart.addCartItem(cartItem),
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              'Zum Einkaufswagen hinzufügen',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
