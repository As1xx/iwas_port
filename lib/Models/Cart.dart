import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String imageURL;
  final String manufacturer;
  final String type;
  final int quantity;
  final double price;
  final int maxStockQuantity;

  CartItem(
      {@required this.id,
      @required this.manufacturer,
      @required this.type,
      @required this.price,
      @required this.maxStockQuantity,
      this.imageURL,
      this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => {..._cartItems};

  int get cartItemCount {
    if (_cartItems.length == 0) {
      return 0;
    } else {
      int totalQuantity = 0;
      _cartItems.forEach((key, cartItem) {
        totalQuantity += cartItem.quantity;
      });
      return totalQuantity;
    }
  }

  double get totalAmount {
    double totalAmount = 0.0;
    _cartItems.forEach((key, cartItem) {
      totalAmount += cartItem.price * cartItem.quantity;
    });
    return totalAmount;
  }

  void addCartItem(CartItem cartItem) {
    if (_cartItems.containsKey(cartItem.id)) {
      _cartItems.update(
          cartItem.id,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                manufacturer: existingCartItem.manufacturer,
                type: existingCartItem.type,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
                imageURL: existingCartItem.imageURL,
                maxStockQuantity: existingCartItem.maxStockQuantity,
              ));
    } else {
      _cartItems.putIfAbsent(
          cartItem.id,
          () => CartItem(
              id: cartItem.id,
              imageURL: cartItem.imageURL,
              manufacturer: cartItem.manufacturer,
              type: cartItem.type,
              quantity: 1,
              price: cartItem.price,
              maxStockQuantity: cartItem.maxStockQuantity));
    }
    notifyListeners();
  }

  void deleteCartItem(CartItem cartItem) {
    if (_cartItems.containsKey(cartItem.id)) {
      _cartItems.update(
          cartItem.id,
              (existingCartItem) => CartItem(
            id: existingCartItem.id,
            manufacturer: existingCartItem.manufacturer,
            type: existingCartItem.type,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1,
            imageURL: existingCartItem.imageURL,
            maxStockQuantity: existingCartItem.maxStockQuantity,
          ));
    } else {
      removeCartItem(cartItem.id);
    }
    notifyListeners();
  }




  void removeCartItem(String productID){
    _cartItems.remove(productID);
    notifyListeners();
  }
}
