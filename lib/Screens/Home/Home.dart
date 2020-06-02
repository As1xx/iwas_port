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
import 'package:iwas_port/Screens/History/History_screen.dart';
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
    Text('in Bearbeitung'),
    HistoryScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

      return Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).appBarTheme.actionsIconTheme,
            title: Text(
              'Home',
              style: Theme.of(context).appBarTheme.textTheme.caption,
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
                      accountEmail: Text(user.email,style: Theme.of(context).textTheme.caption,),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: Text(
                      'Lager',
                      style: Theme.of(context).textTheme.headline3,
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
                        'Produkte',
                        style: Theme.of(context).textTheme.headline3,
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
                      'Lieferanten',
                      style: Theme.of(context).textTheme.headline3,
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
                      'Kunden',
                      style: Theme.of(context).textTheme.headline3,
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
                      style: Theme.of(context).textTheme.headline3,
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
                      'Abmelden',
                      style: Theme.of(context).textTheme.headline3,
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
            index: 0,
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
