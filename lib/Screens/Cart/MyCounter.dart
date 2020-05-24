import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/button/gf_icon_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Models/CartItem.dart';
import 'package:provider/provider.dart';

class MyCounter extends StatefulWidget {

  double counterValue;
  final double step;
  final double maxValue;
  final double minValue;
  final int decimalPlaces;
  final CartItem cartItem;


  MyCounter({
  this.counterValue = 0,
  this.step = 1,
  this.maxValue = 99999,
  this.minValue = 0,
  this.decimalPlaces = 0,
  this.cartItem});

  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {


  @override
  Widget build(BuildContext context) {
  final cart = Provider.of<Cart>(context);

    void increment() {
      if (widget.counterValue + widget.step <= widget.cartItem.quantity){
        setState(() {
          widget.counterValue += widget.step;
          cart.addCartItem(widget.cartItem);
        });
      }
    }

    void decrement() {
      if (widget.counterValue - widget.step >= widget.minValue){
        setState(() {
          widget.counterValue -= widget.step;
          cart.deleteCartItem(widget.cartItem);
        });
      }
    }


    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GFIconButton(
            onPressed: decrement,
            icon: Icon(FontAwesomeIcons.minus,
                color: Theme.of(context).iconTheme.color),
            size: GFSize.SMALL,
            shape: GFIconButtonShape.circle,
            color: Theme.of(context).accentColor,
            type: GFButtonType.outline2x,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text('${num.parse((widget.counterValue).toStringAsFixed(widget.decimalPlaces))} x',
                style: Theme.of(context).textTheme.headline3),
          ),
          GFIconButton(
            onPressed: increment,
            icon: Icon(FontAwesomeIcons.plus,
                color: Theme.of(context).iconTheme.color),
            size: GFSize.SMALL,
            shape: GFIconButtonShape.circle,
            color: Theme.of(context).accentColor,
            type: GFButtonType.outline2x,
          ),
        ],
      ),
    );
  }
}
