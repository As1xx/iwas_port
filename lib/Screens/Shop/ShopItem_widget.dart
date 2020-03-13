import 'package:flutter/material.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Shop/ShopDetail_screen.dart';
import 'package:provider/provider.dart';

class ShopItem extends StatelessWidget {
  final Wine productItem;
  ShopItem(this.productItem);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    CartItem cartItem = CartItem(
        id: productItem.docID,
        imageURL: productItem.imageURL,
        type: productItem.type,
        manufacturer: productItem.manufacturer,
        price: productItem.sellingPrice,
        maxStockQuantity: productItem.quantity);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, ShopDetailScreen.routeName,
              arguments: cartItem),
              child: Image.network(
                productItem.imageURL,
                fit: BoxFit.cover,
              ),
        ),
        footer: GridTileBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(productItem.manufacturer, textAlign: TextAlign.center),
          subtitle: Text(productItem.type, textAlign: TextAlign.center),
          trailing: IconButton(
            onPressed: () => cart.addCartItem(cartItem),
            icon: Icon(Icons.shopping_cart,
                color: Theme.of(context).iconTheme.color),
          ),
        ),
      ),
    );
  }
}
