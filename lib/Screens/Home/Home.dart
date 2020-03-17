import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Models/user.dart';
import 'package:iwas_port/Screens/Cart/Cart_screen.dart';
import 'package:iwas_port/Screens/Drawer/Customer/Customer_screen.dart';
import 'package:iwas_port/Screens/Drawer/Location/Location_screen.dart';
import 'package:iwas_port/Screens/Drawer/Supplier/Supplier_Screen.dart';
import 'package:iwas_port/Screens/Drawer/Wine/Wine_screen.dart';
import 'package:iwas_port/Screens/Shop/Shop_screen.dart';
import 'package:iwas_port/styles/background_style.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  User user;
  int _selectedPage = 0;
  final _pageLayout = [
    ShopScreen(),
    Text('Item 2'),
    Text('Item 3'),
  ];



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

      return Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).appBarTheme.actionsIconTheme,
            title: Text(
              'HomeScreen',
              style: Theme.of(context).appBarTheme.textTheme.title,
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right:40),
                child: Consumer<Cart>(
                  builder: (_,cart,givenChild) => Badge(
                    child: givenChild,
                    toAnimate: true,
                    animationType: BadgeAnimationType.scale,
                    badgeColor: Theme.of(context).accentColor,
                    badgeContent: Text(cart.cartItemCount.toString()),
                  ),
                  child: IconButton(
                      onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
                      icon: Icon(Icons.shopping_cart,color: Theme.of(context).iconTheme.color)
                  ),
                ),
              )
            ],
          ),
          body: Background(
            child: _pageLayout[_selectedPage],
          ),
          drawer: Drawer(
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                      ),
                      accountEmail: Text(user.email,style: Theme.of(context).textTheme.display1,),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: Text(
                      'Locations',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, LocationScreen.routeName);
                    },
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.store,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      title: Text(
                        'Products',
                        style: Theme.of(context).textTheme.display1,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, WineScreen.routeName);
                      },
                    ),
                  ListTile(
                    leading: Icon(
                      Icons.local_shipping,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: Text(
                      'Supplier',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, SupplierScreen.routeName);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.people,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: Text(
                      'Customer',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, CustomerScreen.routeName);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.import_export,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: Text(
                      'Import/Export',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: Text(
                      'Sign Out',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    onTap: () {},
                  ),

                ],
              ),
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            color: Theme.of(context).backgroundColor,
            backgroundColor: Theme.of(context).accentColor,
            buttonBackgroundColor: Theme.of(context).backgroundColor,
            height: 50,
            animationDuration: Duration(milliseconds: 500),
            index: 1,
            items: <Widget>[
              Icon(
                Icons.shopping_cart,
                size: 20,
                color: Theme.of(context).iconTheme.color,
              ),
              Icon(
                Icons.store,
                size: 20,
                color: Theme.of(context).iconTheme.color,
              ),
              Icon(
                Icons.history,
                size: 20,
                color: Theme.of(context).iconTheme.color,
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedPage = index;
              });
            },
          ),
    );
  }
}
