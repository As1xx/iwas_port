import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Models/Transaction.dart';
import 'package:iwas_port/Screens/Order/Discount_bottomSheet.dart';
import 'package:iwas_port/Screens/Order/FromTo_widget.dart';
import 'package:iwas_port/Screens/Order/Notes_widget.dart';
import 'package:iwas_port/Screens/Order/OrderTotal_widget.dart';
import 'package:iwas_port/Screens/Order/PaymentMethod_widget.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final transaction = Transaction.empty();
  bool buySellSwitchState = true;



  @override
  Widget build(BuildContext context) {
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
    transaction.tax = (cart.totalAmount * Transaction.taxPercent);
    transaction.amount =
        cart.totalAmount + transaction.tax - transaction.discount;

//TODO: Hit Submit and create Transaction -> Upload to Database -> Show in History -> Calculate Stock (maybe new Class)
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: <Widget>[
                Text('Sell'),
                Switch(
                  value: buySellSwitchState,
                  onChanged: (state) {
                    setState(() {
                      buySellSwitchState = !buySellSwitchState;
                    });
                  },
                ),
                Text('Buy'),
              ],
            ),
          ),
        ],
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            OrderTotal(transaction: transaction, cart: cart),
            PaymentMethod(),
            FromTo(buySellSwitchState),
            Notes(),
            GradientButton(
              increaseWidthBy: 300,
              child: Text('Submit', style: Theme.of(context).textTheme.display1),
              callback: (){},
              gradient: myGradient,
              shadowColor: Theme.of(context).accentColor,
            ),
          ]),
        ),
      ),
    );
  }
}

