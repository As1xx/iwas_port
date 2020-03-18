import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Models/user.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Order/FromTo_widget.dart';
import 'package:iwas_port/Screens/Order/Notes_widget.dart';
import 'package:iwas_port/Screens/Order/OrderTotal_widget.dart';
import 'package:iwas_port/Screens/Order/PaymentMethod_widget.dart';
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
  bool sellSwitchState = true;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

    final myGradient = LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Theme.of(context).backgroundColor.withOpacity(0.8),
          Theme.of(context).accentColor.withOpacity(0.5),
        ],
        stops: [
          0.5,
          1
        ]);

    final cart = Provider.of<Cart>(context);
    final user = Provider.of<User>(context);

    // Fill Transaction Object with Data
    transaction.tax = (cart.totalAmount * Order.taxPercent);
    transaction.amount =
        cart.totalAmount + transaction.tax - transaction.discount;
    transaction.products = cart.cartItems.values.toList();
    transaction.user = user.email;
    transaction.date = date;

    void submitTransaction() async {
      if (transaction.docID != null &&
          transaction.products != null &&
          transaction.location != null &&
          transaction.customer != null ||
          transaction.supplier != null &&
          transaction.date != null &&
          transaction.amount != null &&
          transaction.discount != null &&
          transaction.tax != null) {
        try {
          await _databaseService.writeToDatabase(transaction);
          FlushbarHelper.createSuccess(
                  message: 'Data successfully uploaded to Cloud')
              .show(context);
          //Navigator.of(context).pop();
        } on DatabaseException catch (error) {
          DatabaseException.showError(context, error.message);
        } catch (otherError) {
          DatabaseException.showError(context, otherError.message);
        }
      }else{
        DatabaseException.showError(context, 'Enter missing Fields');
      }
    }

//TODO: Hit Submit and create Transaction -> Upload to Database -> Show in History -> Calculate Stock (maybe new Class)
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () => showMaterialDatePicker(
                      context: context,
                      selectedDate: date,
                      onChanged: (selectedDate) {
                        setState(() {
                          date = selectedDate;
                        });
                      }),
                ),
                Text('Buy'),
                Switch(
                  value: sellSwitchState,
                  onChanged: (state) {
                    setState(() {
                      sellSwitchState = !sellSwitchState;
                    });
                  },
                ),
                Text('Sell'),
              ],
            ),
          ),
        ],
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            OrderTotal(transaction: transaction, cart: cart),
            PaymentMethod(
              transaction: transaction,
            ),
            FromTo(
              isSell: sellSwitchState,
              transaction: transaction,
            ),
            Notes(
              transaction: transaction,
            ),
            GradientButton(
              increaseWidthBy: 300,
              child:
                  Text('Submit', style: Theme.of(context).textTheme.display1),
              callback: () => submitTransaction(),
              gradient: myGradient,
              shadowColor: Theme.of(context).accentColor,
            ),
          ]),
        ),
      ),
    );
  }
}
