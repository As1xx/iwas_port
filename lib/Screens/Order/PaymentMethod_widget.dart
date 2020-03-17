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
  bool checkBoxValue = true;
  String paymentMethod = 'Bank Transfer';

  @override
  Widget build(BuildContext context) {

    widget.transaction.isPaymentPending = checkBoxValue;
    widget.transaction.paymentMethod = paymentMethod;

    return Stack(children: <Widget>[
      Container(
        height: 210,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Payment Method',
                        style: Theme.of(context).textTheme.body1),
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
                        });
                      },
                    ),
                    Text('Bank Transfer',
                        style: Theme.of(context).textTheme.headline),
                    Spacer(),
                    Text('isPaid?',
                            style: Theme.of(context).textTheme.headline),
                        Checkbox(
                        value: checkBoxValue,
                        onChanged: (state){
                          setState(() {
                            checkBoxValue =! checkBoxValue;
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
                        });
                      },
                    ),
                    Text('Cash', style: Theme.of(context).textTheme.headline),
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
