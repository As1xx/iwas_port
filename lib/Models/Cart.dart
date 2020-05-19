import 'package:flutter/material.dart';
import 'package:iwas_port/Models/CartItem.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Services/WineDatabaseService.dart';

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

  void clearCart(){
    _cartItems = {};
  }

  Wine findProductFromCart(List<Wine> productList,CartItem cartItem){

    Wine product = Wine.empty();

    for (int i =0; i<productList.length; i++){
        if (productList[i].docID == cartItem.id){
          product = productList[i];
        }

    }
    return product;
  }

  void updateProduct(List<Wine> productList, bool isSold ){
    final cartItemList = _cartItems.values.toList();
    cartItemList.forEach((cartItem) {
      final product = findProductFromCart(productList,cartItem);
      if (isSold){
        product.quantity -= cartItem.quantity;
      }else{
        product.quantity += cartItem.quantity;
      }
      WineDatabaseService().writeToDatabase(product);
    });
  }



}
