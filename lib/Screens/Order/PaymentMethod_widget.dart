import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int groupRadioValue = 1;

  @override
  Widget build(BuildContext context) {
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
                        });
                      },
                    ),
                    Text('Bank Transfer',
                        style: Theme.of(context).textTheme.headline),
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
