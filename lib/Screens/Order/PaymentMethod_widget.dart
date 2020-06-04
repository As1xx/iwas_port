import 'package:flutter/material.dart';
import 'package:iwas_port/Models/Order.dart';

class PaymentMethod extends StatefulWidget {
  final Order transaction;

  PaymentMethod({this.transaction});

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int groupRadioValue = 1;
  String paymentMethod = Order.empty().paymentMethod;
  bool checkBoxValue = !Order.empty().isPaymentPending;

  @override
  Widget build(BuildContext context) {


    return Stack(children: <Widget>[
      Container(
        height: 220,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Bezahlung',
                        style: Theme.of(context).textTheme.headline2),
                  ],
                ),
                Divider(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: groupRadioValue,
                      onChanged: (state) {
                        setState(() {
                          groupRadioValue = state;
                          paymentMethod = 'BankTransfer';
                          widget.transaction.paymentMethod = paymentMethod;
                        });
                      },
                    ),
                    Text('Bank Transfer',
                        style: Theme.of(context).textTheme.headline4),
                    Spacer(),
                    Text('Bezahlt?',
                            style: Theme.of(context).textTheme.headline4),
                        Checkbox(
                        value: checkBoxValue,
                        onChanged: (state){
                          setState(() {
                            checkBoxValue =! checkBoxValue;
                            widget.transaction.isPaymentPending = !checkBoxValue;
                          });
                        },
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: groupRadioValue,
                      onChanged: (state) {
                        setState(() {
                          groupRadioValue = state;
                          paymentMethod = 'Cash';
                          widget.transaction.paymentMethod = paymentMethod;
                        });
                      },
                    ),
                    Text('Cash', style: Theme.of(context).textTheme.headline4),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
