import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:iwas_port/Models/user.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Home/Home.dart';
import 'package:iwas_port/Screens/Loading/loading.dart';
import 'package:iwas_port/Screens/Order/FromTo_widget.dart';
import 'package:iwas_port/Screens/Order/Notes_widget.dart';
import 'package:iwas_port/Screens/Order/OrderTotal_widget.dart';
import 'package:iwas_port/Screens/Order/PaymentMethod_widget.dart';
import 'package:iwas_port/Screens/Order/PopUpMenu.dart';
import 'package:iwas_port/Services/OrderDatabaseService.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:provider/provider.dart';
import 'package:iwas_port/Services/DatabaseException.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _databaseService = OrderDatabaseService();
  final transaction = Order.empty();
  int groupRadioValue = 1;
  final popUpMenuKey = GlobalKey();
  bool isBusy = true;

  @override
  Widget build(BuildContext context) {
    List<Location> locationList = Provider.of<List<Location>>(context);
    List<Supplier> supplierList = Provider.of<List<Supplier>>(context);
    List<Customer> customerList = Provider.of<List<Customer>>(context);
    DateTime date = DateTime.now();

    final cart = Provider.of<Cart>(context);
    final user = Provider.of<User>(context);
    final productList = Provider.of<List<Wine>>(context);

    transaction.tax = (cart.totalAmount * Order.taxPercent);
    transaction.products = cart.cartItems.values.toList();
    transaction.user = user.email;
    transaction.date = date;
    transaction.amount =
        cart.totalAmount + transaction.tax - transaction.discount;

    void checkBusy() {
      if (supplierList != null &&
          locationList != null &&
          customerList != null) {
        setState(() {
          isBusy = false;
        });
      }
    }

    checkBusy();

    void setDiscount(double discountValue) {
      setState(() {
        transaction.discount = discountValue;
      });
    }

    void setMethod(String method) {
      setState(() {
        transaction.method = method;
      });
    }

    void submitTransaction() async {
      if (transaction.docID != null &&
              transaction.products != null &&
              transaction.from != null &&
              transaction.to != null &&
              transaction.date != null &&
              transaction.amount != null &&
              transaction.discount != null &&
              transaction.tax != null) {
        try {
          await _databaseService.writeToDatabase(transaction);
          FlushbarHelper.createSuccess(
                  message: 'Daten erfolgreich in die Cloud hochgeladen!')
              .show(context).then((r) =>Navigator.of(context).popUntil(ModalRoute.withName(Home.routeName)));

          cart.updateProduct(productList, transaction.method);
          cart.clearCart();
          transaction.discount = 0;

          //Navigator.of(context).pop();
        } on DatabaseException catch (error) {
          DatabaseException.showError(context, error.message);
        } catch (otherError) {
          DatabaseException.showError(context, otherError.message);
        }
      } else {
        DatabaseException.showError(
            context, 'Fehler bei Verbindung mit Cloud!');
      }
    }

    return isBusy
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.date_range),
                        onPressed: () => DatePicker.showDatePicker(
                          context,
                          initialDateTime: date,
                          locale: DateTimePickerLocale.de,
                          onConfirm: (selectedDate, _) {
                            setState(() {
                              transaction.date = selectedDate;
                            });
                          },
                          pickerTheme: DateTimePickerTheme(
                            backgroundColor: Theme.of(context).highlightColor,
                            cancelTextStyle:
                                Theme.of(context).tooltipTheme.textStyle,
                            confirmTextStyle:
                                Theme.of(context).tooltipTheme.textStyle,
                            itemTextStyle:
                                Theme.of(context).tooltipTheme.textStyle,
                          ),
                        ),
                      ),
                      IconButton(
                        key: popUpMenuKey,
                        icon: Icon(Icons.more_vert),
                        onPressed: () =>
                            buildPopupMenu(context, popUpMenuKey, setMethod),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Background(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  OrderTotal(
                    transaction: transaction,
                    cart: cart,
                    setDiscount: setDiscount,
                  ),
                  PaymentMethod(
                    transaction: transaction,
                  ),
                  FromTo(
                    transaction: transaction,
                    customerList: customerList,
                    locationList: locationList,
                    supplierList: supplierList,
                  ),
                  Notes(
                    transaction: transaction,
                  ),
                  GradientButton(
                    increaseWidthBy: 300,
                    child: Text('Abschluss',
                        style: Theme.of(context).textTheme.headline2),
                    callback: () => submitTransaction(),
                    shadowColor: Theme.of(context).accentColor,
                  ),
                ]),
              ),
            ),
          );
  }
}
