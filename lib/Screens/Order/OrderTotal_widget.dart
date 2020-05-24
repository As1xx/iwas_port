import 'package:flutter/material.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Screens/Order/Discount_bottomSheet.dart';

class OrderTotal extends StatefulWidget {
  const OrderTotal({
    Key key,
    @required this.transaction,
    @required this.cart,
    @required this.setDiscount,
  }) : super(key: key);

  final Order transaction;
  final Cart cart;
  final Function setDiscount;

  @override
  _OrderTotalState createState() => _OrderTotalState();
}

class _OrderTotalState extends State<OrderTotal> {

  // for calculating the Discount (percentage)
  double initOrderAmount;

  @override
  void initState() {
    super.initState();
    initOrderAmount = widget.transaction.amount;
  }





  void addDiscount(double orderAmount, Function setter) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return DiscountScreen(orderAmount, setter);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        height: 250,
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Übersicht', style: Theme.of(context).textTheme.headline2),
                    FlatButton(
                      onPressed: () =>
                          addDiscount(initOrderAmount, widget.setDiscount),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add, color: Theme.of(context).accentColor),
                          Text('Rabatt',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      color: Theme.of(context).accentColor)),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: 30),
                Center(
                    child: Container(
                  //margin: const EdgeInsets.all(30.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${widget.transaction.amount.toStringAsFixed(2)} €',
                    style: Theme.of(context).textTheme.caption,
                  ),
                )),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('Rabatt',
                            style: Theme.of(context).textTheme.headline3),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${widget.transaction.discount.toStringAsFixed(2)} €',style:Theme.of(context).textTheme.headline5,),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('Netto',
                            style: Theme.of(context).textTheme.headline3),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${widget.cart.totalAmount.toStringAsFixed(2)} €',style:Theme.of(context).textTheme.headline5,)),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('MwSt. ${(Order.taxPercent*100).toStringAsFixed(0)} %',
                            style: Theme.of(context).textTheme.headline3),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${widget.transaction.tax.toStringAsFixed(2)} €',style:Theme.of(context).textTheme.headline5,),
                        ),
                      ],
                    ),
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
