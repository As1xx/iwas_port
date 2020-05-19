import 'package:flutter/material.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Models/CartItem.dart';
import 'package:iwas_port/Screens/Cart/MyCounter.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;
  CartItemWidget(this.cartItem);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    Future<bool> _showDeleteDialog() {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Theme.of(context).dialogBackgroundColor,
                elevation: 100,
                title: Text(
                  'Are you sure?',
                  style: Theme.of(context).textTheme.caption,
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'Yes',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  FlatButton(
                    child: Text(
                      'No',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              ));
    }

    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _showDeleteDialog(),
      onDismissed: (_) => cart.removeCartItem(widget.cartItem.id),
      key: ValueKey(widget.cartItem.id),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).errorColor,
        ),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).iconTheme.color,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        color: Theme.of(context).backgroundColor,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Text(
                widget.cartItem.manufacturer + ' ' + widget.cartItem.type,
                style: Theme.of(context).textTheme.caption),
            subtitle: Text(
                'Total: ${widget.cartItem.price * widget.cartItem.quantity} €',
                style: Theme.of(context).textTheme.subtitle),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: FadeInImage(
                height: 350,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/camera_default.png'),
                image: NetworkImage(
                  widget.cartItem.imageURL,
                ),
              ),
              radius: 30,
            ),
            trailing: MyCounter(
              counterValue: widget.cartItem.quantity.toDouble(),
              cartItem: widget.cartItem,
            ),
          ),
        ),
      ),
    );
  }
}
