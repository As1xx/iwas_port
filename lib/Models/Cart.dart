import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => {..._cartItems};

  int get cartItemCount{

    if (_cartItems.length == 0){
      return 0;
    }else{
      int totalQuantity = 0;
      List<CartItem> itemList = cartItems.values.toList();

      for( int i = 0; i < itemList.length; i++ ) {
        totalQuantity = itemList[i].quantity + totalQuantity;
      }
      return totalQuantity;
    }

  }

  void addCartItem(CartItem cartItem) {
    if (_cartItems.containsKey(cartItem.id)) {
      _cartItems.update(
          cartItem.id,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _cartItems.putIfAbsent(
          cartItem.id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: cartItem.title,
              quantity: 1,
              price: cartItem.price));
    }
    notifyListeners();
  }
}
