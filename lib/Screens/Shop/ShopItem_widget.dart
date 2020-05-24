import 'package:flutter/material.dart';
import 'package:iwas_port/Models/Cart.dart';
import 'package:iwas_port/Models/CartItem.dart';
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
              child: FadeInImage(
                height: 350,
                fit: BoxFit.contain,
                placeholder: AssetImage('assets/images/camera_default.png'),
                image: NetworkImage(
                  productItem.imageURL,
                ),
              ),
        ),
        footer: GridTileBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(productItem.manufacturer, textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle1,),
          subtitle: Text(productItem.type, textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2,),
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
