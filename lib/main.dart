import 'package:flutter/material.dart';
import 'package:iwas_port/Locales/AppLocales.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:iwas_port/Models/user.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Authenticate/ResetPassword/ResetPassword_screen.dart';
import 'package:iwas_port/Screens/Authenticate/isLogged_widget.dart';
import 'package:iwas_port/Screens/Cart/Cart_screen.dart';
import 'package:iwas_port/Screens/Drawer/Customer/AddCustomer_screen.dart';
import 'package:iwas_port/Screens/Drawer/Customer/Customer_screen.dart';
import 'package:iwas_port/Screens/Drawer/Customer/EditCustomer_screen.dart';
import 'package:iwas_port/Screens/Drawer/Location/AddLocation_screen.dart';
import 'package:iwas_port/Screens/Drawer/Location/EditLocation_screen.dart';
import 'package:iwas_port/Screens/Drawer/Location/LocationDetailScreen.dart';
import 'package:iwas_port/Screens/Drawer/Location/Location_screen.dart';
import 'package:iwas_port/Screens/Drawer/Supplier/AddSupplier_screen.dart';
import 'package:iwas_port/Screens/Drawer/Supplier/EditSupplier_screen.dart';
import 'package:iwas_port/Screens/Drawer/Supplier/Supplier_Screen.dart';
import 'package:iwas_port/Screens/Drawer/Wine/Wine_screen.dart';
import 'package:iwas_port/Screens/Order/Order_screen.dart';
import 'package:iwas_port/Screens/Shop/ShopDetail_screen.dart';
import 'package:iwas_port/Screens/Shop/Shop_screen.dart';
import 'package:iwas_port/Services/AuthenticateService.dart';
import 'package:iwas_port/Screens/Authenticate/Login/Login_screen.dart';
import 'package:iwas_port/Services/CustomerDatabaseService.dart';
import 'package:iwas_port/Services/LocationDatabaseService.dart';
import 'package:iwas_port/Services/OrderDatabaseService.dart';
import 'package:iwas_port/Services/SupplierDatabaseService.dart';
import 'package:iwas_port/Services/WineDatabaseService.dart';
import 'package:iwas_port/Themes/DarkAppTheme.dart';
import 'package:provider/provider.dart';
import 'Screens/Drawer/Wine/AddWine_sceen.dart';
import 'Screens/Drawer/Wine/EditWine_screen.dart';
import 'Screens/Home/Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WineDatabaseService _wineDatabaseService = WineDatabaseService();
  final LocationDatabaseService _locationDatabaseService = LocationDatabaseService();
  final CustomerDatabaseService _customerDatabaseService = CustomerDatabaseService();
  final SupplierDatabaseService _supplierDatabaseService = SupplierDatabaseService();
  final OrderDatabaseService _orderDatabaseService = OrderDatabaseService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Wine>>(
            updateShouldNotify: (_, __) => true,
            initialData: null,//Wine.initStreamData(),
            create: (_) => _wineDatabaseService.wineListOfCollection),
        StreamProvider<User>(
          initialData: User(email: ''),
          create: (_) => AuthService().user,
        ),
        StreamProvider<List<Location>>(
           //updateShouldNotify: (_, __) => true,
            initialData: null,//Location.initStreamData(),
            create: (_) => _locationDatabaseService.locationListOfCollection),
        StreamProvider<List<Customer>>(
            initialData: null,//Customer.initStreamData(),
            create: (_) => _customerDatabaseService.customerListOfCollection),
        StreamProvider<List<Supplier>>(
            initialData: null,//Supplier.initStreamData(),
            create: (_) => _supplierDatabaseService.supplierListOfCollection),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        StreamProvider<List<Order>>(
            initialData: null,
            create: (_) => _orderDatabaseService.orderListOfCollection),
      ],
      child: MaterialApp(
          theme: darkAppTheme,
          supportedLocales: supportedLocales,
          localizationsDelegates: localizationsDelegates,
          // Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) =>
              localeResolutionCallback(locale, supportedLocales),
          home: IsLogged(),
          routes: {
            Home.routeName: (ctx) => Home(),
            Login.routeName: (ctx) => Login(),
            ResetPassword.routeName: (ctx) => ResetPassword(),
            WineScreen.routeName: (ctx) => WineScreen(),
            AddWine.routeName: (ctx) => AddWine(),
            EditWine.routeName: (ctx) => EditWine(),
            LocationScreen.routeName: (ctx) => LocationScreen(),
            AddLocation.routeName: (ctx) => AddLocation(),
            EditLocation.routeName: (ctx) => EditLocation(),
            CustomerScreen.routeName: (ctx) => CustomerScreen(),
            AddCustomer.routeName: (ctx) => AddCustomer(),
            EditCustomer.routeName: (ctx) => EditCustomer(),
            SupplierScreen.routeName: (ctx) => SupplierScreen(),
            AddSupplier.routeName: (ctx) => AddSupplier(),
            EditSupplier.routeName: (ctx) => EditSupplier(),
            ShopDetailScreen.routeName: (ctx) => ShopDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            ShopScreen.routeName: (ctx) => ShopScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            LocationDetailScreen.routeName: (ctx) => LocationDetailScreen(),
          }),
    );
  }
}
